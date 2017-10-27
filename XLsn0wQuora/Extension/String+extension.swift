//
//  String+.swift
//  Timi
//
//  Created by 田子瑶 on 16/8/30.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit


extension String {
    
    var length:Int{
        get {
            return characters.count
        }
    }
    
    public static func createFilePathInDocumentWith(_ fileName:String) -> String? {
        //返回的paths可能不存在
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let docPath = paths.firstObject as? NSString
        return docPath?.appendingPathComponent(fileName)
    }
    
    //添加方法
    public static func createDirectoryInDocumentWith(_ directoryName:String) -> String?{
        let directoryPath = String.createFilePathInDocumentWith(directoryName) ?? ""
        //在沙盒中创建目录
        if(FileManager.default.fileExists(atPath: directoryPath) == false){
            do{
                try FileManager.default.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
            }catch {
                print("Could not create the DatabaseDoc directory")
            }
        }
        return directoryName
    }
    
    //MARK: 判断字符串中是否含有表情
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case
            0x00A0...0x00AF,
            0x2030...0x204F,
            0x2120...0x213F,
            0x2190...0x21AF,
            0x2310...0x329F,
            0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }
    
}
