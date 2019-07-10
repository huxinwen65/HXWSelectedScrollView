//
//  HXWSelectScrollView.swift
//  SwiftTest
//
//  Created by BTI-HXW on 2019/6/28.
//  Copyright © 2019 BTI-HXW. All rights reserved.
//

import UIKit


class HXWSelectScrollView: UIView {
    
    var titleSc : HXWLabelScrollView?
    var contentSc : HXWDisplayContentView?
    var currentPage : Int = 0
    var didDraging :Bool = false
    
    init(frame: CGRect, numbersOfContentView: ()->Int, contentViewAtIndex: (_ index:Int, _ contentFrame:CGRect) -> UIView, titles:[String]) {
        super.init(frame: frame)
        let titleScro = HXWLabelScrollView.init(frame: CGRect(x: 0.0, y: 0.0, width: bounds.width, height: 50.0), numberOfLables: numbersOfContentView, titles: titles)
        titleScro.labelScrollViewDelegate = self
        addSubview(titleScro)
        titleSc = titleScro
        let contenScro = HXWDisplayContentView.init(frame: CGRect(x: 0.0, y: 50.0, width: bounds.width, height: bounds.height-50.0), numbersOfContentView: numbersOfContentView, contentViewAtIndex: contentViewAtIndex)
        contenScro.isPagingEnabled = true
        contenScro.delegate = self
        addSubview(contenScro)
        contentSc = contenScro
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
///点击title回调
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
///滑动内容页面
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
