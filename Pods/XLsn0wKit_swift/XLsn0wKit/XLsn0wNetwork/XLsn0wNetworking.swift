/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
import UIKit
import Alamofire

let timeoutIntervalForRequest:Double = 10//默认10s 网络请求超时时间

@objc protocol XLsn0wNetworkingDelegate:NSObjectProtocol {
    @objc optional func netWortDidSuccess(result:AnyObject, requestName:String, parameters:NSDictionary?);
    @objc optional func netWortDidFailed (result:AnyObject, error:Error?, requestName:String, parameters:NSDictionary?);
}

class XLsn0wNetworking: NSObject {
    var delegate:XLsn0wNetworkingDelegate?
    static var sessionManager:SessionManager?
    /**********************************************************************************************/
    /**********************************************************************************************/
    /**********************************************************************************************/
    /// 闭包回调请求(类方法)
    ///
    /// - Parameters:
    ///   - method: 请求方式 get、post...
    ///   - url: 可以是字符串，也可以是URL
    ///   - parameters: 参数字典
    ///   - finishedCallback: 完成请求的回调
    class func request(method:HTTPMethod, url:String, parameters:NSDictionary?, finishedCallback:  @escaping (_ result : AnyObject, _ error: Error?) -> ()) {
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = timeoutIntervalForRequest
        sessionManager = SessionManager(configuration: config)
        
        Alamofire.request(url, method: method, parameters: parameters as? Parameters).responseJSON { (response) in
            let data = response.result.value
            if (response.result.isSuccess) {
                finishedCallback(data as AnyObject, nil)
            } else {
                finishedCallback(data as AnyObject,response.result.error)
            }
        }
    }
    /**********************************************************************************************/
    /**********************************************************************************************/
    /**********************************************************************************************/
    /// 代理方法请求(类方法)
    ///
    /// - Parameters:
    ///   - method: 请求方式 get、post...
    ///   - url: 可以是字符串，也可以是URL
    ///   - requestName: 请求名字，一个成功的代理方法可以处理多个请求，所以用requestName来区分具体请求
    ///   - parameters: 参数字典
    ///   - delegate: 代理对象
    class func requestDelegate(method:HTTPMethod, url:String, requestName:String, parameters:NSDictionary?, delegate:AnyObject) {
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = timeoutIntervalForRequest
        sessionManager = SessionManager(configuration: config)
        Alamofire.request(url, method: method, parameters: parameters as? Parameters).responseJSON { (response) in
            let data = response.result.value
            if (response.result.isSuccess) {
                delegate.netWortDidSuccess?(result: data as AnyObject, requestName: requestName, parameters: parameters)
            } else {
                delegate.netWortDidFailed?(result: data as AnyObject, error:response.error, requestName: requestName, parameters: parameters)
            }
        }
    }
    /**********************************************************************************************/
    /**********************************************************************************************/
    /**********************************************************************************************/
}
