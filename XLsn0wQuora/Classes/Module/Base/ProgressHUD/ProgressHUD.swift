//
//  ProgressHUD.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/25.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SVProgressHUD

class ProgressHUD: NSObject {
    class func setupProgressHUD() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor(white: 0.0, alpha: 0.8))
        SVProgressHUD.setFont(UIFont.boldSystemFont(ofSize: 16))
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        SVProgressHUD.setDefaultMaskType(.clear)
    }
    
    class func show() {
        SVProgressHUD.show()
    }
    
    class func show(withStatus status: String) {
        SVProgressHUD.show(withStatus: status)
    }
    
    class func showInfo(withStatus status: String) {
        SVProgressHUD.showInfo(withStatus: status)
    }
    
    class func showSuccess(withStatus status: String) {
        SVProgressHUD.showSuccess(withStatus: status)
    }
    
    class func showError(withStatus status: String) {
        SVProgressHUD.showError(withStatus: status)
    }
    
    class func dismiss() {
        SVProgressHUD.dismiss()
    }
}
