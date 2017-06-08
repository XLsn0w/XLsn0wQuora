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
}
