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
import XLsn0wKit_swift

let BaseURL:String = "http://news-at.zhihu.com/api/"

class XLsn0wQuoraRequest: NSObject {
    /// 根据知乎日报二次封装的一个网络请求
    ///
    /// - Parameters:
    ///   - url:            当前接口需要的 URL
    ///   - requestName:    请求名称
    ///   - delegate:       处理网络请求成功和失败的代理
    ///   - param:          请求参数                    可选参数，默认为nil
    ///   - method:         网络请求类型                 可选参数，默认为 Get 请求方式
    class func WRRequest(url:String, requestName:String, delegate:XLsn0wNetworkingDelegate, param:NSDictionary? = nil, method: HTTPMethod? = .get) {
        XLsn0wNetworking.requestDelegate(method: .get, url: url, requestName: requestName, parameters: nil, delegate: delegate)
    }
}


// MARK: - 所有接口的集合
extension XLsn0wQuoraRequest {
    // 启动页闪屏
    class func requestSplashImage(reqName:String, delegate:XLsn0wNetworkingDelegate) {
        let curURL = BaseURL.appending("7/prefetch-launch-images/1080*1920")
        WRRequest(url: curURL, requestName: reqName, delegate: delegate)
    }
    
    // App版本检测
    class func requestAppVersion(reqName:String, delegate:XLsn0wNetworkingDelegate) {
        let curURL = BaseURL.appending("7/version/ios/2.3.0")
        WRRequest(url: curURL, requestName: reqName, delegate: delegate)
    }
    
    // 最新消息
    class func requestLatestNews(reqName:String, delegate:XLsn0wNetworkingDelegate) {
        let curURL = BaseURL.appending("4/news/latest")
        WRRequest(url: curURL, requestName: reqName, delegate: delegate)
    }
}





