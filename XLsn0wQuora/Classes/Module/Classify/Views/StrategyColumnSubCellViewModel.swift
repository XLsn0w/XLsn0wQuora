//
//  StrategyColumnSubCellViewModel.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/21.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class StrategyColumnSubCellDataModel: NSObject{
    
}

class StrategyColumnSubCellViewModel: NSObject {
    var dataModel:StrategyColumnSubCellDataModel?
    var photoImage:UIImage?
    var titleLabelText:String?
    var detialLabelText:String?
    var nameLabelText:String?
    
    
    init(withModel model:StrategyColumnSubCellDataModel) {
        self.dataModel = model
        photoImage = UIImage(named: "strategy_\(Int(arc4random() % 17) + 1).jpg")
        titleLabelText = "美体日记"
        detialLabelText = "更新至第1期"
        let name = ["小小礼物","大大的店","好好礼物","萌萌哒，我啊❤️","我最开心","妹妹的袜子","小坏坏","不打烊的店"]
        nameLabelText = name[Int(arc4random() % 8)]
    }
}
