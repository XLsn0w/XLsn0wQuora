//
//  ExpressionMessage.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/28.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class ExpressionMessage: MessageModel {
    var emoji:Emoji?
    
    var path:String?
    
    var url:String?
    
//: 构造方法
    override init() {
        super.init()
        type = .Expression
    }
}
