//
//  MeFooterViewModel.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/26.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit


class MeFooterViewModel: NSObject {
    var iconImage:UIImage?
    var tipLabelText:String?
    
    init(isLogin state:Bool) {
        
        if !state {
            iconImage = #imageLiteral(resourceName: "me_blank")
            tipLabelText = "登录以享受更多功能"
        }else{
            iconImage = nil
            tipLabelText = ""
        }
    }
}
