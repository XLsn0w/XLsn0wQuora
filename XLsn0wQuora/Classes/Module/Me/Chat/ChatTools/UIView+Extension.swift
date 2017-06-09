//
//  UIView+Extension.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/29.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import Foundation


extension UIView {
    
    func height() -> CGFloat {
        var maxHeight:CGFloat = 0.0
        
        for i in  0..<subviews.count {
            let view = subviews[i]
            if view.frame.maxY > maxHeight {
                maxHeight = view.frame.maxY
            }
        }
        
        return maxHeight
    }
}
