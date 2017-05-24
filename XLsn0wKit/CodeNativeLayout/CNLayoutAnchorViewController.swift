//
//  CNLayoutAnchorViewController.swift
//  AutoLayoutDemo
//
//  Created by 董知樾 on 2017/3/28.
//  Copyright © 2017年 董知樾. All rights reserved.
//

import UIKit

class CNLayoutAnchorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "原生代码-NSLayoutAnchor"
        view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let scrollViewTop = scrollView.topAnchor.constraint(equalTo: view.topAnchor)
        let scrollViewBottom = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let scrollViewLeading = scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let scrollViewTrailing = scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        NSLayoutConstraint.activate([scrollViewTop,scrollViewBottom,scrollViewLeading,scrollViewTrailing])
        
        var lastLabel : UILabel!
        
        for i in 0...20 {
            let label = UILabel()
            label.backgroundColor = UIColor.hexValue(0xf8f8f8)
            label.textColor = UIColor.hexValue(0x666666)
            scrollView.addSubview(label)
            label.font = UIFont.systemFont(ofSize: 14)
            label.numberOfLines = 0
            
            var labelTop : NSLayoutConstraint!
            var labelBottom : NSLayoutConstraint!
            var labelLeading : NSLayoutConstraint!
            var labelTrailing : NSLayoutConstraint!
            
            label.translatesAutoresizingMaskIntoConstraints = false
            let labelWidth = label.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -24)
            
            if i == 0 {
                labelTop = label.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12)
                labelLeading = label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 12)
                labelTrailing = label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 12)
            } else {
                labelTop = label.topAnchor.constraint(equalTo: lastLabel.bottomAnchor, constant: 12)
                labelLeading = label.leadingAnchor.constraint(equalTo: lastLabel.leadingAnchor)
                labelTrailing = label.trailingAnchor.constraint(equalTo: lastLabel.trailingAnchor)
                if i == 20 {
                    labelBottom = label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -12)
                    NSLayoutConstraint.activate([labelBottom])
                }
            }
            NSLayoutConstraint.activate([labelTop,labelLeading,labelTrailing,labelWidth])
            label.text = arcText()
            lastLabel = label
        }
        
        ///NSLayoutAnchor是iOS9之后新增的约束方式，相较于NSLayoutConstraint来说，更能体现AutoLayout的相对性，且代码量减少了许多，看起来也更加清晰了
    }
    
    func arcText() -> String! {
        let utilText = "util "
        let number = arc4random() % 30 + 20
        var text = ""
        for _ in 0...number {
            text += utilText
        }
        return text
    }
    

}
