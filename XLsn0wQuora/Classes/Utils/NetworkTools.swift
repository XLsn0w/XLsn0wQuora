//
//  NetworkTools.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/25.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import QorumLogs


typealias FinishedOperation = (_ success:Bool,_ result:JSON?,_ error:Error?) ->()

class NetworkTools: NSObject {
    static let shared = NetworkTools()

}

//MARK: 基本请求方法
extension NetworkTools {
    /** 
     handle处理响应结果
    
    - Parameters:
    - response: 响应对象
    - finished: 完成回调
    */
    fileprivate func handle(response: DataResponse<Any>, finished: @escaping FinishedOperation) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        switch response.result {
        case .success(let value):
            QL1(value)
            
            let json = JSON(value)
            if json["code"].intValue >= 4000 {
                // token失效 退出登录
                
                finished(false, json, nil)
            } else {
                
                finished(true, json, nil)
            }
        case .failure(let error):
            finished(false, nil, error as NSError?)
        }
        
    }
    
    /**
     GET请求
     
     - parameter urlString:  urlString
     - parameter parameters: 参数
     - parameter finished:   完成回调
     */
    func get(_ url:String,parameters:[String:Any?],finished:@escaping FinishedOperation) {
        //: 显示网络活动状态
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            self.handle(response: response, finished: finished)
        }
    }
    
    /**
     POST请求
     
     - parameter urlString:  urlString
     - parameter parameters: 参数
     - parameter finished:   完成回调
     */
    
    func post(_ url:String,parameters: [String : Any]?, finished: @escaping FinishedOperation ) {
        //: 显示网络活动状态
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers:nil).responseJSON { (response) in
            self.handle(response: response, finished: finished)
        }
    }
}
