//
//  BaseGoodsViewModel.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/20.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class BaseGoodsDataModel: NSObject {
    var topicImageUrls:Array<String>?
}


class BaseGoodsViewModel: NSObject {
    var dataModel:BaseGoodsDataModel?
    
    var photoImage:UIImage?
    var titleLabelText:String?
    var priceLabelText:String?
    var likeButtonText:String?
    
    init(withModel model:BaseGoodsDataModel) {
        self.dataModel = model
        
        photoImage = UIImage(named: "goods_\(Int(arc4random() % 10) + 1).jpg")
        titleLabelText = "干物妹小埋.悲伤大猫U型枕"
        priceLabelText = "￥129.00"
        likeButtonText = "236"
    }
}
