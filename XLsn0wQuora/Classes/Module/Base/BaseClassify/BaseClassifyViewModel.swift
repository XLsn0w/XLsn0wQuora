//
//  BaseClassifyViewModel.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/20.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class BaseClassifyDataModel: NSObject {
    var topicImageUrls:Array<String>?
}

class BaseClassifyViewModel: NSObject {
    var dataModel:BaseClassifyDataModel?
    
    var image:UIImage
    var sellerHeadImage:UIImage
    var tagButtonText:String
    var sellerTitleButtonText:String
    var sellerNameLabelText:String
    var sellerDetailLabelText:String
    var priseButtonText:String
    
    init(withModel model:BaseClassifyDataModel) {
        self.dataModel = model
        image = UIImage(named: "strategy_\(Int(arc4random() % 17) + 1).jpg")!
        sellerHeadImage = UIImage(named: "seller\(Int(arc4random() % 4) + 1).jpg")!
        tagButtonText = "礼物"
        sellerTitleButtonText = "不打烊的礼物店"
        
        let name = ["小小礼物","大大的店","好好礼物","萌萌哒，我啊❤️","我最开心","妹妹的袜子","小坏坏","不打烊的店"]
        sellerNameLabelText = name[Int(arc4random() % 8)]
        sellerDetailLabelText = "第83期 | 古风墨色，许你一场最美的意外"
        priseButtonText = "\(1000 + Int(arc4random() % 5000))"
    }
}
