//
//  ImageChatCellViewModel.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/28.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class ImageChatCellViewModel: BaseChatCellViewModel {

    var imageSize:CGSize = .zero
    
//MARK: 构造方法
    init(withImageMessage msg: ImageMessage) {
        super.init(withMsgModel: msg)
    }
}
