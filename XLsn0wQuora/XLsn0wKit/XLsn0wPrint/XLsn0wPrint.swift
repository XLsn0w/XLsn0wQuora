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

func XLsn0wprint<T>(xlog: T,
              logError: Bool = false,
              file: String = #file,
              xlfunc: String = #function,
              line: Int = #line) {
    if logError {
        print("[文件:\((file as NSString).lastPathComponent)] [第\(line)行] [函数:\(xlfunc)] [日志:\(xlog)]")
    } else {
        #if DEBUG
            print("[文件:\((file as NSString).lastPathComponent)] [第\(line)行] [函数:\(xlfunc)] [日志:\(xlog)]")
        #endif
    }
}
