//
//  NSObject+KeyValue.swift
//  LSXPropertyTool
//
//  Created by 李莎鑫 on 2017/4/9.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//  字典，字典数组转模型底层处理。(仅支持swift3.+）工具使用如有问题，期待打脸QQ:120834064
//  邮箱：120834064@qq.com

import Foundation
import UIKit
import Messages

extension NSObject {
    //: 通过类名称创建控制器
    class func ojectInstatnce(withClassName name:String?) -> AnyObject? {
        
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
    
    class func model(withClassName modelClass:String, withKeyValue keyValue:Dictionary<String,Any>) -> Any?{
        
        let model = PropertyModel()
        
        guard let object = ojectInstatnce(withClassName: modelClass) else {
            return nil
        }
        
        let count = UnsafeMutablePointer<UInt32>.allocate(capacity: 0)
        

        //: 获取所有属性
        guard let ivars = class_copyIvarList(object_getClass(object), count) else {
            return nil
        }
        
      
        for i in 0..<Int(count[0]) {
            let ivar  = ivars[i]!
        
            var key =  String.init(utf8String: ivar_getName(ivar))
            var isUsingKeyWord:Bool = false
            if key == nil {
                print("属性名 不存在")
                continue
            }
            
            //: 判断属性是否为系统关键字特征前缀名词
            if (key?.hasPrefix(keyPreffix))! {
                print("\(object) 的属性\(key) 是系统关键字前缀名词，进行前缀剥离处理.")
                key = key?.substring(from: keyPreffix.endIndex)
                isUsingKeyWord = true
            }else{
                isUsingKeyWord = false
            }
            
            model.propertyName = key
        
            var value = keyValue[key!]
            
            //: 恢复系统关键字的转换
            if isUsingKeyWord {
                    key = keyPreffix + key!
            }
            
            
            if value != nil {
                
                if let property = class_getProperty(object_getClass(object), ivar_getName(ivar)) {
                
                    let propertyType = String.init(utf8String: property_getAttributes(property))
                    let array = propertyType!.components(separatedBy: "\"")
            
                    
                    //: 对象类型
                    if array.count > 1 {
                        if let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String {
                            //: 取得名词空间后的类型
                            var strType:String = "NULL"
                            var baseType:String = "NULL"
                            var isFromNameSpace:Bool = false
                            for i in 0..<array.count {
                                if array[i].contains(nameSpace) {
                                    isFromNameSpace = true
                                    strType = array[i]
                                }
                            
                                baseType = array[1]
                                
                            }
                           
                            
                           //: 字典类型对象
                           if isFromNameSpace {
                               if  strType != "NULL" {
                                    let types = strType.components(separatedBy: nameSpace)
                                    let length = types.last?.lengthOfBytes(using: .utf8)
                                
                                    if length! >  9 {
                                        model.propertyType = types.last?.substring(from: "00".endIndex)
                                    }else{
                                        model.propertyType = types.last?.substring(from: "0".endIndex)
                                    }
                        
                                
                                    //: 字典类型转换
                                    if let className = NSClassFromString(nameSpace + "." + model.propertyType!) {
                                        
                                        value = className.model(withClassName: model.propertyType!, withKeyValue: value as! Dictionary<String,Any>)
                                       
                                        print("\(key) \(value) \(model.propertyType)")
                                    }
                               }
                            }
                           //: 基本数据对象类型
                           else {
                                //: 数组类型
                                if  baseType == BaseArrayType {
                                    model.propertyType = baseType
                                    let classType = array.last!.substring(from: ",N,C,V".endIndex).capitalized
                                    
                                    let arrayData = value as! Array<Any>
             
                                    //: 注意数据数组必须是对象数组,不能是swift下的普通数组,解决数组的问题
                                    let arrayModel = NSMutableArray()
                
                                    for i  in 0..<Int(arrayData.count) {
                                        
                                        var data:Any?
                                        
                                        switch NSObject.propertyType(withValue: arrayData[i]) {
                                        //: 字典类型转换
                                        case swf3Dictionary:
                                            //: 一定是对象类型的数组字典
                                            if let className = NSClassFromString(nameSpace + "." + classType) {
                                                
                                                let dictonary  = arrayData[i] as! Dictionary<String,Any>
                                                
                                                 data = className.model(withClassName: classType, withKeyValue: dictonary)
                                            }
                                            //: 非对象类型当一字典
                                            else{
                                                
                                            }
                                        //: 嵌套数组
                                        case swf3Array:
            
                                             data = ExchangeToModel.model(withClassName: classType,withArray: arrayData[i] as? Array<Any> ) as Any
                                        
                                        //: 对象数据基本类型
                                        default:
                                             data = arrayData[i]
                                        }
                                        
                                        if data != nil {
                                            arrayModel.add(data!)
                                        }
                                    }
                                    
                                    value = arrayModel
                                    
                                }
                            }
                            
                        }
                    }
                    //: 基本数据类型
                    else {
                        print("基本数据类型")
                    }
                    
                    
                    if value != nil {
                        object.setValue(value! , forKey: key!)
                    }else{
                        print("\(object)中键值 \(key) 的值为nil!")
                    }
                }
                //: 基本数据类型未初始化
                else{
                    print("\(key)  基本数据类型未初始化分配空间，请赋初值！ ")
                }
            
            }else {
                print("\(object)中键值\(key) 的属性不存在")
            }

        }
        
        return object
    }
    
   
}
