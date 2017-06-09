//
//  VoiceChatCellViewModel.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/28.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

fileprivate let voiceCellWidth:CGFloat = 80.0
fileprivate let voiceCellHeight:CGFloat = 45.0

class VoiceChatCellViewModel: BaseChatCellViewModel {
    
    var voiceStatus:RecordStatus?
    var voicebackImage:UIImage?
    var voicebackHightLightImage:UIImage?
    var voiceTimeLabelFont:UIFont?
    var voiceTimeLabelText:String?
    
    init(withVoiceMessage msg: VoiceMessage) {
        super.init(withMsgModel: msg as MessageModel)
        
        if viewLocation == .right {
            voicebackImage = #imageLiteral(resourceName: "SenderTextNodeBkg")
            voicebackHightLightImage = #imageLiteral(resourceName: "SenderTextNodeBkgHL")
        }
        else{
            voicebackImage = #imageLiteral(resourceName: "ReceiverTextNodeBkg")
            voicebackHightLightImage = #imageLiteral(resourceName: "ReceiverTextNodeBkgHL")
        }
        
        voiceTimeLabelFont = fontSize14
        voiceTimeLabelText = String(format: "%.0lf\"\n", msg.time)
        voiceStatus = msg.status
        viewFrame.contentSize = CGSize(width: voiceCellWidth, height: voiceCellHeight)
        viewFrame.height += viewFrame.contentSize.height
    }
}
