//
//  UIColorHex.swift
//  AutoLayoutDemo
//
//  Created by 董知樾 on 2017/3/27.
//  Copyright © 2017年 董知樾. All rights reserved.
//

import UIKit

public extension UIColor{
    
    static func hexValue (_ value:UInt32) -> UIColor{
        return UIColor.hexValue(value, alpha: 1);
    }
    static func hexValue (_ value:UInt32, alpha:CGFloat) -> UIColor{
        let r = (value & 0x00FF0000) >> 16
        let g = (value & 0x0000FF00) >> 8
        let b = (value & 0x000000FF)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue:CGFloat(b)/255.0, alpha: alpha)
    }
    
    
}
