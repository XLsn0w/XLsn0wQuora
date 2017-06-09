//
//  PropertyCodeMake.swift
//  LSXPropertyTool
//
//  Created by 李莎鑫 on 2017/4/9.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//  属性代码生成工具 (仅支持swift3.+）工具使用如有问题，期待打脸QQ:120834064
//  邮箱：120834064@qq.com

import UIKit

open class PropertyCodeMake: NSObject {
    
    //: plist 文件生成属性
    open class func propertyCodeMake(withPlist plist:String ,valueKey key:String ,fileName name:String ,filePath path:String) {
        guard let file = Bundle.main.path(forResource: plist, ofType: nil) else {
            return
        }
        
        let data = (NSDictionary(contentsOfFile: file) as! Dictionary<String, Any>)
        
        guard let array = data[key]  else {
            return
        }
        
        propertyCodeMake(withDictionaryArray: array as! Array, fileName: name, filePath: path)
    }
    
    
    //: json数组生成属性
    open class func propertyCodeMake(withDictionaryArray array:Array<Any>,fileName name:String,filePath path:String) {
 
        var file = String()
        let oldfile = String()
        var propertys = [String]()
        let outfile = path.appending(PropertyModel.propertyPathAppendingFileName(fileName: name))
       
        if FileManager.default.fileExists(atPath: outfile) {
            do{
                
                file = try String.init(contentsOfFile: outfile)
                
            }catch{
                print("read File error")
            }
            
            for i in 0..<array.count {
                
                //: 文件展开属性一定是键值对
                if NSObject.propertyClassType(withValue: array[i]) == BaseDictionaryType {
        
                    let dictionary = array[i] as! Dictionary<String,Any>
                    
                    let result = propertyCodeMakeOption(withFile: file, withDictionary: dictionary, withPropertys: propertys, withPath: path,update:{ (newfile) in
                        //: 更新文件
                        file = newfile
                    }, process: { (name) in
                        propertys.append(name)
                    })
                    
                    if result == "new" {
                        print(result)
                    }
                }
            }
            
            //: 文件管理器更新
            if oldfile.compare(file) == .orderedAscending {
                do{
                    try file.write(toFile: outfile, atomically: true, encoding: .utf8)
                }catch{
                    print("\(name) write to file error!")
                }
            }
            
        }else{
            var code = String()
            
            //: 创建文件
            code.append(creaatePropertyCodeFile(withFileName: name))
            for i in 0..<array.count {
                
                //: 文件展开属性一定是键值对
                if NSObject.propertyClassType(withValue: array[i]) == BaseDictionaryType {
                    let dictionary = array[i] as! Dictionary<String,Any>
                    code.append(propertyCodeMakeOption(withFile: file, withDictionary: dictionary, withPropertys: propertys, withPath: path,update: nil, process: { (name) in
                        propertys.append(name)
                    }))
                }
                
            }
            
            code.append(PropertyModel.propertyFileClassExit())
            
            //: 文件管理器,避免重复创建
            do{
                try code.write(toFile: outfile, atomically: true, encoding: .utf8)
            }catch{
                print("\(name) write to file error!")
            }
        }
        
    }
    
    //: 字典生成属性
    open class func propertyCodeMake(withDictionary dictionary:Dictionary<String,Any>,fileName name:String,filePath path:String) {
        
        var file = String()
        var oldfile = String()
        var propertys = [String]()
        
        let outfile = path.appending(PropertyModel.propertyPathAppendingFileName(fileName: name))
        
        //: 判断文件是否存在
        if FileManager.default.fileExists(atPath: outfile) {
            do{
                //: 读取文件
                file = try String.init(contentsOfFile: outfile)
                oldfile = file
                
            }catch{
                print("read File error")
            }
            
            let result = propertyCodeMakeOption(withFile: file, withDictionary: dictionary, withPropertys: propertys, withPath: path,update:{ (newfile) in
                file = newfile
            }, process: { (name) in
                propertys.append(name)
            })
            
            if result == "new" {
                print(result)
            }
            //: 文件管理器更新
            if oldfile.compare(file) == .orderedAscending {
                do{
                    try file.write(toFile: outfile, atomically: true, encoding: .utf8)
                }catch{
                    print("\(name) write to file error!")
                }
            }
        }else{
            var code = String()
            //: 创建文件
            code.append(creaatePropertyCodeFile(withFileName: name))
            
            code.append(propertyCodeMakeOption(withFile: file, withDictionary: dictionary, withPropertys: propertys, withPath: path,update: nil,process: { (name) in
                propertys.append(name)
            }))
            
            code.append(PropertyModel.propertyFileClassExit())
            
            //: 文件管理器写入
            do{
                try code.write(toFile: outfile, atomically: true, encoding: .utf8)
            }catch{
                print("\(name) write to file error!")
            }
        }
    }
    
    //: 属性检查
    fileprivate class func properyCodeMakeCheck(propertyName name:String,propertyType type:String,propertyValue value:Any,subfilePath path:String) -> Bool {
        
        //: 内嵌数组类型
        if type == swf3Array {
           
            let data = value as! NSArray
              //: 如果下面有内容继续转换生成
            if data.count != 0 {
                if propertyClassType(withValue: data[0]) == BaseDictionaryType {
                   propertyCodeMake(withDictionaryArray: data as! Array<Any>, fileName: name.capitalized, filePath: path)
                }
            }
            
        }
        //: 内嵌字典类型
        else if type == swf3Dictionary {
            let data = value as! NSDictionary
            //: 如果下面有内容继续转换生成
            if data.count != 0 {
                propertyCodeMake(withDictionary: value as! Dictionary<String,Any>, fileName: name.capitalized, filePath: path)
            }
        }
        
        return true
    }
    
    fileprivate class func propertyCodeMakeOption(withFile file:String,withDictionary dictionary:Dictionary<String,Any>,withPropertys propertys:Array<String>,withPath path:String,update:((_ newData:String) ->Void)?,process: @escaping (_ propertyName:String)-> Void) ->String {
        
       return NSObject.propertyCode(withFile: file,withDictionary: dictionary,update: update, option: { (name, type, value) -> Bool in
            guard name != "" else{
                return false
            }
            
            guard type != "" else{
                return false
            }
            
            guard value != nil else{
                return false
            }
            
            
            for i in 0..<propertys.count {
                let str = propertys[i]
                if str == name {
                    return false
                }
            }
            
            process(name!)
            
            return properyCodeMakeCheck(propertyName: name!, propertyType: type!, propertyValue: value!, subfilePath: path)
        })
    }
    
    //: 创建文件
    fileprivate class func creaatePropertyCodeFile(withFileName name:String) -> String{
        var code = String()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let project = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
        
        //: 文件头
        code.append(PropertyModel.propertyHeadFile(fileName: name, projectName: project, authorName: "sunshine.lee", systemTime: formatter.string(from: Date()), DateYear: formatter.string(from: Date()).substring(to: "yyyy".endIndex)))
        
        code.append(PropertyModel.propertyFileImport(fileName: "UIKit"))
        code.append(PropertyModel.propertyFileClassEntery(className: name))
        
        
        return code
    }
}
