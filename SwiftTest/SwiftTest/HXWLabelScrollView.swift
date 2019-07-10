//
//  HXWLabelScrollView.swift
//  SwiftTest
//
//  Created by BTI-HXW on 2019/6/27.
//  Copyright © 2019 BTI-HXW. All rights reserved.
//

import UIKit

@objc protocol HXWLabelScrollViewDelegate : NSObjectProtocol {
    
    @objc optional func didSelectTitleAtIndex(_ index:Int)
}

class HXWLabelScrollView: UIScrollView {
    
    weak open var labelScrollViewDelegate: HXWLabelScrollViewDelegate?
    var total :Int = 0
    
    var current : Int = 0
    init(frame: CGRect,numberOfLables:() -> Int,titles:[String]) {
        super.init(frame: frame)
        showsHorizontalScrollIndicator = false
        scrollview(numberOfLables: numberOfLables,titles:titles)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func scrollview(numberOfLables:() -> Int, titles:[String]){
        
        let count = numberOfLables()
        total = count
        let margin:CGFloat = 8.0
        var x = margin
        let height = bounds.height;
        for i in 0..<count{
            let label = HXWLabel.init(frame: CGRect.zero, index: i, action: { (index) in
                if index == self.current {return}///点击title事件回调
                UIView.animate(withDuration: 0.05, animations: {
                    self.scrollToPage(page: index)
                    self.labelScrollViewDelegate?.didSelectTitleAtIndex?(index)
                })
                
            })
            label.text = "\(titles[i]) \(i)"
            label.font = UIFont.systemFont(ofSize: 18.0)
            label.sizeToFit()
            label.font = UIFont.systemFont(ofSize: 14.0)
            label.frame = CGRect(x: x, y: 0.0, width: label.bounds.width, height: height)
            label.tag = i + 100
            label.textAlignment = NSTextAlignment.center
            addSubview(label)
            
            x += margin + label.bounds.width
        }
        contentSize = CGSize(width: x+margin, height: 50.0)
        
    }
    func scrollToPage(page:Int){
        ///拿到当前选中的title，改变颜色为mnormal
        let lastL:HXWLabel = (self.viewWithTag(self.current + 100)) as! HXWLabel
        lastL.view?.backgroundColor = UIColor.white
        lastL.textColor = UIColor.black
        ///更新当前为点击的
        current = page;
        let currentL:HXWLabel = (self.viewWithTag(self.current + 100)) as! HXWLabel
        let offset = currentL.frame.minX - (UIScreen.main.bounds.width - currentL.bounds.width)/2
        print("title \(offset)")
        let finalL:HXWLabel = (self.viewWithTag(total - 1 + 100)) as! HXWLabel
        let maxOffset = finalL.frame.maxX - UIScreen.main.bounds.width
        if offset > 0 && offset <=  maxOffset{
            contentOffset = CGPoint(x: offset, y: 0)
        }else if offset > maxOffset{
            contentOffset = CGPoint(x: maxOffset, y: 0)
        }else{
            contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    func scrollToIndex(index:Int) {
        if index == current {return}
        UIView.animate(withDuration: 0.05) {
            self.scrollToPage(page: index)
            let currentL:HXWLabel = (self.viewWithTag(self.current + 100)) as! HXWLabel
            currentL.view?.backgroundColor = UIColor.red
            currentL.textColor = UIColor.red
        }
        
    }
}
