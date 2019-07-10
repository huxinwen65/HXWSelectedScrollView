//
//  HXWDisplayContentView.swift
//  SwiftTest
//
//  Created by BTI-HXW on 2019/6/28.
//  Copyright © 2019 BTI-HXW. All rights reserved.
//

import UIKit

class HXWDisplayContentView: UIScrollView {

    init(frame: CGRect, numbersOfContentView: ()->Int, contentViewAtIndex: (_ index:Int, _ contentbounds:CGRect) -> UIView) {
        super.init(frame: frame)
        let count = numbersOfContentView()
        var originX:CGFloat = 0.0
        for i in 0..<count {
            let contentBounds = CGRect(x: 0.0, y: 0.0, width: bounds.width, height: bounds.height)
            let contentV = contentViewAtIndex(i,contentBounds)
            contentV.frame = CGRect(x: originX, y: 0.0, width: bounds.width, height: bounds.height)
            addSubview(contentV)
            originX += bounds.width
            
        }
        contentSize = CGSize(width: originX, height: bounds.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
