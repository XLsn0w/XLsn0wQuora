//
//  ChatBarViewModel.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/29.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class ChatBarDataModel: NSObject {
    
}

public enum ChatBarButtonType : Int {
    
    case voice
    
    case emoji
    
    case more
    
    case text
    
}

class ChatBarViewModel: NSObject {
    
    var voiceButtonImage:UIImage?
    var voiceButtonHightLightedImage:UIImage?
    
    var moreButtonImage:UIImage?
    var moreButtonHightLightedImage:UIImage?
    
    var emojiButtonImage:UIImage?
    var emojiButtonHightLightedImage:UIImage?
    
    var switchButtonImage:UIImage?
    var switchButtonHightLightImage:UIImage?
    
    var textViewFont:UIFont?
    
    
    override init() {
        super.init()
        
        voiceButtonImage = #imageLiteral(resourceName: "ToolViewInputVoice")
        voiceButtonHightLightedImage = #imageLiteral(resourceName: "ToolViewInputVoiceHL")
        
        moreButtonImage = #imageLiteral(resourceName: "TypeSelectorBtn_Black")
        moreButtonHightLightedImage = #imageLiteral(resourceName: "TypeSelectorBtnHL_Black")
        
        emojiButtonImage = #imageLiteral(resourceName: "ToolViewEmotion")
        emojiButtonHightLightedImage = #imageLiteral(resourceName: "ToolViewEmotionHL")
        
        switchButtonImage = #imageLiteral(resourceName: "ToolViewKeyboard")
        switchButtonHightLightImage = #imageLiteral(resourceName: "ToolViewKeyboardHL")
        
        textViewFont = fontSize16
    }

}
