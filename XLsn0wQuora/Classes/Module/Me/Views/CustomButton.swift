//
//  CustomButton.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/24.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class CustomButton: UIButton {

//MARK: 重写布局
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let centerMargin = margin * 0.2
        let imageOffsetY = (bounds.height - imageView!.bounds.height - titleLabel!.bounds.height - centerMargin) * 0.5
        let imageOffsetX = (bounds.width - imageView!.bounds.width) * 0.5
        let titleOffsetX = (bounds.width - titleLabel!.bounds.width) * 0.5
        
        imageView!.frame.origin.y = imageOffsetY
        imageView!.frame.origin.x = imageOffsetX
        
    
        titleLabel!.frame.origin.y = imageView!.frame.maxY + centerMargin
        titleLabel!.frame.origin.x = titleOffsetX
        
        
    }
}
