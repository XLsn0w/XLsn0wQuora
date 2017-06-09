//
//  VoiceMessage.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/28.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

//MARK: 语音消息状态
public enum RecordStatus : Int {
    
    case normal      //: 普通状态
    
    case recording   //: 录制状态
    
    case playing     //: 播放状态
    
}
class VoiceMessage: MessageModel {
    //: 录音文件名称
    var fileName:String?
    
    //: 录音文件路径
    var path:String?
    
    //: 录音网络文件地址
    var url:String?
    
    //: 录音时长
    var time:CGFloat = 0.0
    
    //: 录音状态 
    var status:RecordStatus = RecordStatus(rawValue: 0)!
    
//MARK: 构造方法
    override init() {
        super.init()
        type = .voice
    }
//MARK: 外部接口
    //: 用户消息
    class func userMessage(status:RecordStatus) -> VoiceMessage {
        let msg = VoiceMessage()

        msg.owner = .user
        msg.source = .myself
        msg.status = status
        
        return msg
    }
    
}
