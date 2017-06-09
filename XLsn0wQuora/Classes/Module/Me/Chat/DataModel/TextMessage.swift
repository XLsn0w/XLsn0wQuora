//
//  TextMessage.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/28.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class TextMessage: MessageModel {
    //: 文字信息
    var text:String?{
        didSet{
            attrText = text!.toMsgString()
        }
    }
    //: 格式化的富文本
    var attrText:NSAttributedString?
//MARK: 构造方法
    override init() {
        super.init()
        type = .text
    }
    
    //: 用户消息
    class func userMessage(text:String) -> TextMessage {
        let msg = TextMessage()
        msg.text = text
        msg.owner = .user
        msg.source = .myself
        
        return msg
    }
}
