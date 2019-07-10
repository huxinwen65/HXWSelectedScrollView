//
//  ViewController.swift
//  SwiftTest
//
//  Created by BTI-HXW on 2019/6/27.
//  Copyright © 2019 BTI-HXW. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var scroView : HXWSelectScrollView?
    
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
    
    
    

}

