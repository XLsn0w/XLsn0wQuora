//
//  PropertyModel.swift
//  LSXPropertyTool
//
//  Created by 李莎鑫 on 2017/4/8.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//  属性文件描述 (仅支持swift3.+）工具使用如有问题，期待打脸QQ:120834064
//  邮箱：120834064@qq.com

import UIKit

//MARK: 属性只支持swift 3.0 特性（swift 2.3不支持）
//: 系统关键字列表
let maskKeyword = ["class","let","var","import","func","return","switch","if","else","extension","protocol","guard","case","continue","break","while","do","catch"
,"try","description"]

//: 转义前缀
let keyPreffix = "Pref_"

let maxStringRange = 4400
//: 尾部追加位置
let updateEndIndex  = 6

let String_Type     = "__NSCFString"
let Number_Type     = "__NSCFNumber"
let Bool_Type       = "__NSCFBoolean"
let Array_Type      = "__NSCFArray"
let Dictionary_Type = "__NSCFDictionary"

let BaseNullType    = "NSNull"
let BaseArrayType   = "NSArray"
let BaseStringType  = "NSString"
let BaseNumberType  = "NSNumber"
let BaseDictionaryType = "NSDictionary"

let swf3String      = "String"
let swf3Number      = "Int"
let swf3Bool        = "Bool"
let swf3Array       = "Array"
let swf3Dictionary  = "Dictionary"
let swf3AnyObject   = "AnyObject"
let swf3Any         = "Any"

let DictionaryActiveType = "<String,Any>"
let ArrayActiveType = "<Any>"

class PropertyModel: NSObject {
//MARK: 属性
    var propertyName:String?
    var propertyType:String?
    
//MARK: 外部接口方法
    class func propertyHeadFile(fileName file:String,projectName project:String,authorName author:String,systemTime time:String,DateYear year:String) -> String {
        return "//\n//  \(file).swift\n//  \(project)\n//\n//  Created by \(author) on \(time).\n//  Copyright © \(year)年 \(author). All rights reserved.\n//\n\n"
    }
    
    class func propertyFileImport(fileName file:String) -> String{
        return "\nimport  \(file)\n"
    }
    
    class func propertyPathAppendingFileName(fileName file:String) -> String{
        return "/\(file).swift"
    }
    
    class func propertyFileClassEntery(className name:String) -> String {
        return "\nclass \(name):NSObject {\n"
    }
    
    class func propertyFileClassExit() -> String {
        return "\n}\n"
    }
    
    class func propertyNoteMake(markString mark:String) -> String {
        return "\n//MARK:  \(mark)"
    }
    
    class func propertyNote(noteString note:String) -> String{
        return "\n    //:  \(note)"
    }
    
    class func propertyCodeObject(propertyName name:String,popertyType type:String) -> String {
        return "\n    var \(name) : \(type)?\n"
    }
    
    class func propertyCodeBool(propertyName name:String,popertyType type:String) -> String {
        return "\n    var \(name) : \(type) = false\n"
    }
    
    class func propertyCodeSpecialArray(propertyName name:String,popertyType type:String) -> String {
        return "\n    var \(name) : \(type)<\(name.capitalized)>?\n"
    }
    
    class func propertyCodeArray(propertyName name:String,popertyType type:String,subPropertyType subType:String) -> String {
        return "\n    var \(name) : \(type)<\(subType)>?\n"
    }
  
    class func propertyCode(propertyName name:String,popertyType type:String) -> String {
        return "\n    var \(name) : \(type) = 0\n"
    }
}
