//
//  MeHeaderViewModel.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/26.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit


class MeHeaderDataModel: NSObject {
    var headIconUrl:String?
    var userName:String?
    var sex:Int = 0
    
    override init() {
        super.init()
    }
}
class MeHeaderViewModel: NSObject {
    var dataModel:MeHeaderDataModel
    
    var headImageUrl:URL?
    var userNameText:String?
    var gender: Int = 0
    var isEmptyModel:Bool = true
    
    init(withModel model:MeHeaderDataModel?) {
        
        guard let model = model else {
            isEmptyModel = true
            self.dataModel = MeHeaderDataModel()
            return
        }
        
        isEmptyModel = false
        
        self.dataModel = model
        
        if let urlString  = model.headIconUrl {
            headImageUrl = URL(string: urlString)
        }
        userNameText = model.userName
        
        gender = model.sex
        
    }
}
