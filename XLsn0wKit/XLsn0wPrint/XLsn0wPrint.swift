//
//  XLsn0wPrint.swift
//  XLsn0w
//
//  Created by XLsn0w on 2017/4/28.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

import UIKit

class XLsn0wPrint: NSObject {

}

public func XLsn0wLog<T>(printObject: T,
              logError: Bool = false,
              logFile: String = #file,
              logFunc: String = #function,
              logLine: Int = #line) {
    if logError {
        print("[文件:\((logFile as NSString).lastPathComponent)] [第\(logLine)行] [函数:\(logFunc)] [日志:\(printObject)]")
    } else {
        #if DEBUG
            print("[文件:\((logFile as NSString).lastPathComponent)] [第\(logLine)行] [函数:\(logFunc)] [日志:\(printObject)]")
        #endif
    }
}
