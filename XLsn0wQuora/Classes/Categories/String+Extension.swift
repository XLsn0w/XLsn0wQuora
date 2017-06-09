//
//  String+Extension.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/18.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

extension String {
    //: 返回字体宽度
    func stringWidth(withFont font:UIFont) -> CGFloat{
        return self.boundingRect(with: CGSize.zero, options: .init(rawValue: 0), attributes: [NSFontAttributeName:font], context: nil).width
    }
}
