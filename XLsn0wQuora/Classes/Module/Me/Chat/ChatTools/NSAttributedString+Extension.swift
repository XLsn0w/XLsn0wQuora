//
//  NSAttributedString+Extension.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/29.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import Foundation
import UIKit


extension NSAttributedString {
    func sizeToFits(_ size:CGSize) -> CGSize {
        
        guard let font = attribute(NSFontAttributeName, at: 0, effectiveRange: nil) else {
            return CGSize.zero
        }
        
        return string.fitSize(size, font as! UIFont)
    }
}
