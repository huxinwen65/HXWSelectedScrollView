//
//  HXWLabel.swift
//  SwiftTest
//
//  Created by BTI-HXW on 2019/6/28.
//  Copyright © 2019 BTI-HXW. All rights reserved.
//

import UIKit

class HXWLabel: UILabel {
    var index:Int?
    var action : ((_ index:Int) -> Void)?
    var view: UIView?
    override var frame: CGRect{
        get{
            return super.frame
        }
        set {
            super.frame = newValue
            self.view?.frame = CGRect(x: 0, y: bounds.height-1.0, width: bounds.width, height: 1.0)
        }
    }
    init(frame: CGRect, index:Int, action: @escaping (_ index:Int) -> Void) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.index = index
        self.action = action
        view = UIView.init()
        addSubview(view!)
        if index == 0 {
            view?.backgroundColor = UIColor.red
            textColor = UIColor.red
        }else{
            view?.backgroundColor = UIColor.white
            textColor = UIColor.black
        }
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tapClick))
        addGestureRecognizer(tap)
    }
    @objc func tapClick(sender:UITapGestureRecognizer){
        
        guard let action = self.action ,let index = index else{
            print("不存在")
            return
        }
        UIView.animate(withDuration: 0.05) {
            self.view?.backgroundColor = UIColor.red
            self.textColor = UIColor.red
        }
        
        action(index)
        print("点击了label \(index)")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
