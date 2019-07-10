# HXWSelectedScrollView
仿头条首页滚动
在平时项目开发过程中经常会遇见类似头条首页滚动式需求，效果如下：![未命名s.gif](https://upload-images.jianshu.io/upload_images/6938768-79c97626e39b0bdc.gif?imageMogr2/auto-orient/strip)
最近在熟悉swift，就用swift语言封装了一个这样的工具，欢迎大神指正。
###实现思路：
- 总体层次结构：
对外提供的是一个继承UIView的HXWSelectScrollView，上面铺了两个UIScrollView，一个是title的HXWLabelScrollView（继承UIScrollView），另一个是contentView的HXWDisplayContentView（继承UIScrollView），另外在HXWLabelScrollView上铺上了自定义HXWLabel继承UILabel，展示title，添加了点击手势。总体结构如下：![总体结构.png](https://upload-images.jianshu.io/upload_images/6938768-2306216f78e991a7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
- 对外接口类HXWSelectScrollView：
在构造化的方法传入需要实现的滚动页数，对应的页面内容UIView，对应的titles
```
init(frame: CGRect, numbersOfContentView: ()->Int, contentViewAtIndex: (_ index:Int, _ contentFrame:CGRect) -> UIView, titles:[String]) {
        super.init(frame: frame)
        let titleScro = HXWLabelScrollView.init(frame: CGRect(x: 0.0, y: 0.0, width: bounds.width, height: 50.0), numberOfLables: numbersOfContentView, titles: titles)///title view
        titleScro.labelScrollViewDelegate = self
        addSubview(titleScro)
        titleSc = titleScro
        let contenScro = HXWDisplayContentView.init(frame: CGRect(x: 0.0, y: 50.0, width: bounds.width, height: bounds.height-50.0), numbersOfContentView: numbersOfContentView, contentViewAtIndex: contentViewAtIndex)///content view
        contenScro.isPagingEnabled = true
        contenScro.delegate = self
        addSubview(contenScro)
        contentSc = contenScro
    }
///点击title回调HXWLabelScrollViewDelegate
extension HXWSelectScrollView :HXWLabelScrollViewDelegate{
    
    func didSelectTitleAtIndex(_ index: Int) {
        currentPage = index;
        scrollContentToPage(page: index)
    }
    func scrollContentToPage(page:Int) {///将内容更新的对应的title页面
        let offset = UIScreen.main.bounds.width*CGFloat(page)
        self.contentSc?.contentOffset = CGPoint(x: offset, y: 0.0)
    }
}
///滑动内容页面回调UIScrollViewDelegate
extension HXWSelectScrollView :UIScrollViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print( "scrollViewDidEndDragging + \(scrollView.contentOffset.x) + \(decelerate)")
        didDraging = true
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if didDraging {///手滑动页面
            print("scrollViewDidScroll + \(scrollView.contentOffset.x)")
            let currentOffset = CGFloat(currentPage)*UIScreen.main.bounds.width
            let scrollOffset = scrollView.contentOffset.x
            let offset = scrollOffset - currentOffset
            print("\(offset)")
            if offset > UIScreen.main.bounds.width/2.0 {//右翻
                currentPage += 1
                titleSc?.scrollToIndex(index: currentPage)
            }else if offset < UIScreen.main.bounds.width/2.0*(-1.0){///左翻
                currentPage -= 1
                titleSc?.scrollToIndex(index: currentPage)
            }else if offset == 0{//没变
            }
            didDraging = false
        }
    }
}
```
demo的调用如下：
```
 override func viewDidLoad() {
        super.viewDidLoad()
        let scro = HXWSelectScrollView.init(frame: view.bounds, numbersOfContentView: { () -> Int in
             return 16///数量
        }, contentViewAtIndex: { (index,contentBounds) -> UIView in///内容试图
            let view = UIView.init()
            view.backgroundColor = UIColor.lightGray
            let conten = UILabel.init()
            view.addSubview(conten)
            conten.font = UIFont.systemFont(ofSize: 30.0)
            conten.text = "hello \(index)"
            conten.textAlignment = NSTextAlignment.center
            conten.frame = contentBounds
            return view
        }, titles: ["hello","hello","hello","hello","hello","hello","hello","hello","hello","hello","hello","hello","hello","hello","hello","hello"])///title名称
        
        view.addSubview(scro)
        scroView = scro
    }
```
[具体见demo](https://github.com/huxinwen65/HXWSelectedScrollView)，欢迎指正！！！
