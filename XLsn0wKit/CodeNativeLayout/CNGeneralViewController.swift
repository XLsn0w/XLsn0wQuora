//
//  CNGeneralViewController.swift
//  AutoLayoutDemo
//
//  Created by 董知樾 on 2017/3/28.
//  Copyright © 2017年 董知樾. All rights reserved.
//

import UIKit

class CNGeneralViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "原生代码-常规布局"
        view.backgroundColor = .white
        
        let blueView = UIView()
        blueView.backgroundColor = UIColor.hexValue(0x40a0ff)
        view.addSubview(blueView)
        
        blueView.translatesAutoresizingMaskIntoConstraints = false
        let blueTopConstraint = NSLayoutConstraint.init(item: blueView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 20)
        let blueBottomConstraint = NSLayoutConstraint.init(item: blueView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -20)
        let blueLeadingConstraint = NSLayoutConstraint.init(item: blueView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20)
        let blueTrailingConstraint = NSLayoutConstraint.init(item: blueView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20)
        
        ///toItem.addConstraints... iOS6 or NSLayoutConstraint.activate... iOS8
//        view.addConstraints([blueTopConstraint,blueBottomConstraint,blueLeadingConstraint,blueTrailingConstraint])
        NSLayoutConstraint.activate([blueTopConstraint,blueBottomConstraint,blueLeadingConstraint,blueTrailingConstraint])
        
        let redView = UIView()
        redView.backgroundColor = UIColor.hexValue(0xfd84ea)
        blueView.addSubview(redView)
        redView.translatesAutoresizingMaskIntoConstraints = false
        let redTopConstraint = NSLayoutConstraint.init(item: redView, attribute: .top, relatedBy: .equal, toItem: blueView, attribute: .top, multiplier: 1, constant: 20)
        let redBottomConstraint = NSLayoutConstraint.init(item: redView, attribute: .bottom, relatedBy: .equal, toItem: blueView, attribute: .bottom, multiplier: 1, constant: -20)
        let redLeadingConstraint = NSLayoutConstraint.init(item: redView, attribute: .leading, relatedBy: .equal, toItem: blueView, attribute: .leading, multiplier: 1, constant: 20)
        let redTrailingConstraint = NSLayoutConstraint.init(item: redView, attribute: .trailing, relatedBy: .equal, toItem: blueView, attribute: .trailing, multiplier: 1, constant: -20)
        
        NSLayoutConstraint.activate([redTopConstraint,redBottomConstraint,redLeadingConstraint,redTrailingConstraint])
        
    }

    

}
