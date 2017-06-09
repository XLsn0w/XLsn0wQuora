//
//  PositionMessage.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/29.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import CoreLocation

class PositionMessage: MessageModel {
    //: 地址信息
    var address:String?
    
    //: 地址坐标
    var location:CLLocation?
    
//MARK: 构造方法
    override init() {
        super.init()
        type = .postion
    }
}
