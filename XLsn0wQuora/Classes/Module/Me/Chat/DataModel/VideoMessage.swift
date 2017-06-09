//
//  VideoMessage.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/28.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class VideoMessage: MessageModel {
    //: 视频本地路径
    var path:String?
    
    //: 视频网络路径
    var url:String?
    
    //: 视频预览图本地路径
    var imagePath:String?
    
    //: 视频预览图网络路径
    var imageUrl:String?
    
    override init() {
        super.init()
        
        type = .video
    }
}
