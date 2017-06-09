//
//  NSObject+Extension.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/28.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import Foundation

extension NSObject {
    //: 通过类名称创建对象
    class func objectInstatnce(withClassName name:String?) -> AnyObject? {
        
        //: 获取命名空间
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("获取命名空间失败")
            return nil
        }
        
        
        guard let className = NSClassFromString(nameSpace + "." + (name ?? ""))  else {
            print("\(nameSpace):下\(name)找不到!")
            return nil
        }
        
        //: 获取类型
        guard let classType = className as? NSObject.Type  else {
            print("获取类型失败，不能创建对象")
            return nil
        }
        
        return classType.init()
    }
}
