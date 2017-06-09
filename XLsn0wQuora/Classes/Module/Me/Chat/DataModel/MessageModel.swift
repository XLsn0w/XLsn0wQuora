//
//  MessageModel.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/27.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//  IM 消息基本模型定义

import UIKit
import QorumLogs

//MARK: 消息所有者
public enum MessageOwner : Int {
    
    case user     //: 用户
    
    case group    //: 用户群
    
}
//MARK: 消息来源
public enum MessageSource : Int {
    
    case unknown  //: 未知消息
    
    case system   //: 系统消息
    
    case myself   //: 用户自己
    
    case friends  //: 对方发送
    
}

//MARK: 消息发送状态
public enum MessageSendState : Int {
    
    case success  //: 发送成功
    
    case fail   //: 发送失败
    
}

//MARK: 消息发送状态
public enum MessageReadState : Int {
    
    case unRead  //: 未读取
    
    case readed   //: 已经读取
    
}

//MARK: 消息类型
public enum MessageType : Int {
    
    case unknown     //: 未知
    
    case text        //: 文本
    
    case image       //: 图片
    
    case Expression  //: 表情
    
    case voice       //: 语音
    
    case video       //: 视频
    
    case url         //: 链接
    
    case postion     //: 位置
    
    case card        //: 名片
    
    case system      //: 系统
    
    case other       //: 其他
}


//MARK: 消息读取状态

class MessageModel: NSObject {
    //: 消息ID
    var id:String?
    //: 发送者ID
    var uid:String?
    //: 接收者ID
    var fid:String?
    //: 讨论组ID
    var groupID:String?
    
    
    //: 消息发送时间
    var date:Date?
    //: 发送用户信息
    var fromUsr:UserModel?
    //: 消息来源
    var source:MessageSource = MessageSource(rawValue: 0)! {
        didSet{
            //: 如果是发送消息自动获取时间
            if source == .myself {
                date = Date()
                fromUsr = AccountModel.shareAccount()!.toUserModel()
            }
        }
    }
    //: 消息所有者
    var owner:MessageOwner = MessageOwner(rawValue: 0)!
    //: 消息类型
    var type:MessageType = MessageType(rawValue: 0)!
    //: 消息读取状态
    var readState:MessageReadState = MessageReadState(rawValue: 0)!
    //: 消息发送状态
    var sendState:MessageSendState = MessageSendState(rawValue: 0)!
    
//MARK: 构造方法
    override init() {
        super.init()
    
        //: 初始化消息id 
        id = String(format: "%lld", UInt(Date().timeIntervalSince1970 * 1000))

    }
    
//MARK: 外部接口
    //: 判断是否为同一个模型
    func isEqualModel(_ model: MessageModel) -> Bool {
        return ((type == model.type) && (id == model.id)) ? true : false
    }
}
