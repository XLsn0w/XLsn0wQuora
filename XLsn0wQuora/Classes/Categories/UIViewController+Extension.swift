//
//  UIViewController+Extension.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import QorumLogs

extension UIViewController{
    //: 通过类名称创建控制器
    class func controller(withName controllerName:String?) -> UIViewController? {
        
        //: 获取命名空间
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            QL4("获取命名空间失败")
            return nil
        }
        
        guard let className = NSClassFromString(nameSpace + "." + (controllerName ?? ""))  else {
            QL4("\(ToControllerKey):控制器名称\(controllerName)找不到!")
            return nil
        }
        
        
        //: 获取类型
        guard let classType = className as? UIViewController.Type  else {
            QL3("获取类型失败，不能创建控制器")
            return nil
        }
        
        return classType.init()
    }
    

    func hideNavigationBar(isHiden hide:Bool) {
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.setBackgroundImage(hide ? UIImage() : UIImage.image(withColor: SystemNavgationBarTintColor, withSize: CGSize.zero), for: .default)
        
        if hide {
            navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
}
