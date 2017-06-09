//
//  BaseChatCellViewModel.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/27.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

fileprivate let AvatarWidth:CGFloat = margin*4
fileprivate let TimeLabelMaxWidth   = ScreenWidth * 0.3
fileprivate let TimeLabelFont = fontSize12

public enum layoutLocation : Int {
    
    case left
    
    case right
    
}

class BaseChatCellViewModel: NSObject {
    //: 视图类型
    var type:MessageType?
    //: 视图模型大小
    var viewFrame:ViewFrame = ViewFrame()
    //: 模型ID
    var id:String?
    
    
    //: 基本属性
    var timeLabelText:String?
    var timeLabelFont:UIFont?
    var avatarImage:UIImage?
    var avatarUrl:URL?
    var viewLocation:layoutLocation?
    var showNameLabel:Bool = true
    
    var avatarWidth:CGFloat = AvatarWidth
    
    init(withMsgModel msg:MessageModel) {
        
        id = msg.id
        type = msg.type
        
        if let text = msg.date?.ToStringInfo() {
            timeLabelText = String(format: "  %@  ", text)
            timeLabelFont = TimeLabelFont
        }
        
        //: 头像大小
        avatarWidth = AvatarWidth
        
        
        //: 从本地获取
        if let name = msg.fromUsr?.avatarLoc {
            if name.contains("/") {
                let image = UIImage(named: FileManager.userAvatarPath(avatarName: name))
                avatarImage = image
            }
            else{
                avatarImage = UIImage(named: name)
            }
        }
        //: 获取网络图片
        else {
            
            if let url = msg.fromUsr?.avatarUrl {
                avatarUrl = URL(string: url)
            }
        }
        
        
        //: 更新布局位置
        if msg.source == .myself {
            viewLocation = layoutLocation(rawValue: layoutLocation.right.rawValue)
        }
        else {
            viewLocation = layoutLocation(rawValue: layoutLocation.left.rawValue)
        }
        
        
        let labelSize = timeLabelText!.fitSize(CGSize(width: TimeLabelMaxWidth, height: CGFloat(MAXFLOAT)), TimeLabelFont)
        
        viewFrame.height = avatarWidth + labelSize.height + margin*1.5
        
    }
    //: 判断是否为同一个模型
    func isEqualModel(_ model: BaseChatCellViewModel) -> Bool {
        return id == model.id ? true : false
    }
    
//MARK: 外部接口
    class func create(withMsgModel msg:MessageModel) -> BaseChatCellViewModel? {
        switch msg.type {
        case .text:
           return  TextChatCellViewModel(withTextMessage: msg as! TextMessage)
        case .image:
            return ImageChatCellViewModel(withImageMessage: msg as! ImageMessage)
        case .voice:
            return VoiceChatCellViewModel(withVoiceMessage: msg as! VoiceMessage)
        case .video:
            return VideoChatCellViewModel(withVideoMessage: msg as! VideoMessage)
        default:
            return nil
        }
    }
    
}
