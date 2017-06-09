//
//  ClassifySingleListHeadViewModel.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/23.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class ClassifySingleListHeadDataModel: NSObject {
    
}

class ClassifySingleListHeadViewModel: NSObject {
    var dataModel:ClassifySingleListHeadDataModel?
    
    var photoImage:UIImage?
    var titleLabelText:String?
    var detialLabelText:String?
    
    init(withModel model:ClassifySingleListHeadDataModel) {
        self.dataModel = model
        photoImage = UIImage(named: "strategy_\(Int(arc4random() % 17) + 1).jpg")
        titleLabelText = "简介"
        detialLabelText = "做你的私人搭配师，每日搭配治好你的选择困难症，满足你多睡5分钟的小小心愿"
    }
}
