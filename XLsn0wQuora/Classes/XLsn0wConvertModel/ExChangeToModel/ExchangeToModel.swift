//
//  ExchangeToModel.swift
//  LSXPropertyTool
//
//  Created by 李莎鑫 on 2017/4/9.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//  字典，数组字典，json数据转模型 (仅支持swift3.+）工具使用如有问题，期待打脸QQ:120834064
//  邮箱：120834064@qq.com

import UIKit

open class ExchangeToModel: NSObject {
    open class func model(withClassName className:String,withPlist plist:String,withDataKey key:String) -> Array<Any>?{
        
        guard let path = Bundle.main.path(forResource: plist, ofType: nil) else {
            return nil
        }
        
        guard let data = NSDictionary.init(contentsOfFile: path) as? Dictionary<String, Any> else {
            return nil
        }
        
        guard let array  = data[key] as? Array<Any> else {
            return nil
        }
    
        return model(withClassName: className, withArray: array)
    }
    
    open class func model(withClassName className:String,withArray array:Array<Any>?) -> Array<Any>? {
        
        var modelArray = Array<Any>()
        
        guard let data = array as Array<Any>? else {
            return nil
        }
        
        for i in 0..<data.count {
            let dictionary  = data[i] as! Dictionary <String,Any>
            
            let object = NSObject.model(withClassName: className, withKeyValue: dictionary)
            
            if object != nil {
                modelArray.append(object!)
            }
        
        }
        
        return modelArray
    }
    
    open class func model(withClassName className:String,withDictionary dictionary:Dictionary<String,Any>) -> Any?{
        return NSObject.model(withClassName: className, withKeyValue: dictionary)
    }
}
