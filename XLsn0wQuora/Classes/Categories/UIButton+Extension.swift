//
//  UIButton+Extension.swift
//  PresentGift
//
//  Created by 李莎鑫 on 17/3/18.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(x: CGFloat, iconName: NSString, target: AnyObject?, action: Selector, imageEdgeInsets: UIEdgeInsets){
        self.init()
        frame = CGRect(x: x, y: 0, width: 44, height: 44)
    
        setImage(UIImage(named: iconName as String), for: UIControlState.normal)
        setImage(UIImage(named: iconName as String), for: UIControlState.highlighted)
        self.imageEdgeInsets = imageEdgeInsets
        addTarget(target, action: action, for: UIControlEvents.touchUpInside)
    }
    
    //: 导航栏排序按钮
    convenience init(sortTarget: AnyObject?, action: Selector) {
        self.init()
        frame = CGRect(x: 0, y: 0, width: 44.0, height: 44.0)
        contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        setImage(UIImage(named: "icon_sort"), for: UIControlState.normal)
        addTarget(sortTarget, action: action, for: UIControlEvents.touchUpInside)
    }
    
    //: 导航栏返回按钮
    convenience init(backTarget: AnyObject?, action: Selector) {
        self.init()
        setImage(UIImage(named: "back"), for: UIControlState.normal)
        frame = CGRect(x: 0, y: 0, width: 44.0, height: 44.0)
        contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        addTarget(backTarget, action: action, for: UIControlEvents.touchUpInside)
    }
    
    //: 导航栏取消按钮
    convenience init(cancelTarget: AnyObject?, action: Selector) {
        self.init()
        setTitle("取消", for: UIControlState.normal)
        frame = CGRect(x: 0, y: 0, width: 44.0, height: 44.0)
        contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        addTarget(cancelTarget, action: action, for: UIControlEvents.touchUpInside)
    }
    

}
