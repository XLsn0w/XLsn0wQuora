//
//  TextChatCellViewModel.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/27.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import QorumLogs

fileprivate let maxMessageWidth:CGFloat = ScreenWidth * 0.6

class TextChatCellViewModel: BaseChatCellViewModel {
    
    //: 富文本字体
    var msgAttributedText:NSAttributedString?
    
    //: 消息背景图片
    var msgBackViewImage:UIImage?
    
    //: 消息选中背景图片
    var msgBackViewSelImage:UIImage?
    

    init(withTextMessage msg:TextMessage){
        super.init(withMsgModel: msg as MessageModel)
        
        msgAttributedText = msg.attrText
        //: 消息来源
        if msg.source == .myself {
            msgBackViewImage = #imageLiteral(resourceName: "SenderTextNodeBkg")
            msgBackViewSelImage = #imageLiteral(resourceName: "SenderTextNodeBkgHL")
        }
        else{
            msgBackViewImage = #imageLiteral(resourceName: "ReceiverTextNodeBkg")
            msgBackViewSelImage = #imageLiteral(resourceName: "ReceiverTextNodeBkgHL")
        }

        //: 设置Label大小
        var size = msgAttributedText!.sizeToFits(CGSize(width: maxMessageWidth, height: CGFloat(MAXFLOAT)))
        if size == .zero {
            QL4("富文本字体自适应失败！")
        }

        size.height += margin*0.5
        size.width  += margin*0.5
        viewFrame.contentSize = size
        viewFrame.height += viewFrame.contentSize.height 
    }
    
    
    
}
