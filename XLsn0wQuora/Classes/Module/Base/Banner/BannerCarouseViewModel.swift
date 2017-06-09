//
//  BannerCarouseViewModel.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/18.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//  图片轮播器视图模型

import UIKit

class BannerDataModel: NSObject {
    var bannerImageUrls:Array<String>?
}

class BannerCarouseViewModel: NSObject {
    var dataModel:BannerDataModel?
    
    var pageImage:UIImage
    
    init(withModel model:BannerDataModel) {
        self.dataModel = model
            pageImage = UIImage(named: "banner-0\(Int(arc4random() % 5) + 1).jpg")!
    }
}
