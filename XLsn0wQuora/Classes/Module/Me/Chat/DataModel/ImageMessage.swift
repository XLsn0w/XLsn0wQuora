//
//  ImageMessage.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/28.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class ImageMessage: MessageModel {
    //: 本地图片路径
    var imagePath:String?
    
    //: 网络图片路径
    var imageUrl:String?
 
//MARK: 构造方法
    override init() {
        super.init()
        type = .image
    }
}
