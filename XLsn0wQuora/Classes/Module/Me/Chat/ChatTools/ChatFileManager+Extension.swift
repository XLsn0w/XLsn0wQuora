//
//  ChatFileManager+Extension.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/27.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import Foundation
import QorumLogs

extension FileManager {
    class func userAvatarPath(avatarName name:String) -> String {
        let path = "\(FileManager.documents())/User/\(AccountModel.shareAccount()!.uid!)/Chat/Avatar/"
        if !FileManager.default.fileExists(atPath: path) {
            do{
               try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }
            catch{
                QL4("File Create Failed: %@", path)
            }
        }
        
        return path.appending(name)
    }
    
    class func userChatVoicePath(voiceName name:String) -> String {
        let path = "\(FileManager.documents())/User/\(AccountModel.shareAccount()!.uid!)/Chat/Voice/"
        if !FileManager.default.fileExists(atPath: path) {
            do{
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }
            catch{
                QL4("File Create Failed: %@", path)
            }
        }
        
        return path.appending(name)
    }
    
    class func expressionPath(groupID id:String) -> String {
        let path = "\(FileManager.documents())/Expression/\(id)/"
        if !FileManager.default.fileExists(atPath: path) {
            do{
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }
            catch{
                QL4("File Create Failed: %@", path)
            }
        }
        
        return path
    }
    
//MARK: 基本路径
    class func documents() -> String {
        return self.directory(directory: .documentDirectory)
    }
    
    class func librarys() -> String {
        return self.directory(directory: .libraryDirectory)
    }
    
    class func caches() -> String {
        return self.directory(directory: .cachesDirectory)
    }
    
    
    class func directory(directory:SearchPathDirectory) -> String {
        return NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first!
    }
}
