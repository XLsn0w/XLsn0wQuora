
import UIKit

open class XLsn0wRequest: NSObject {
/**************************************************************************************************/
/**************************************************************************************************/
/**************************************************************************************************/
    /// HTTP Request GET Method
    ///
    /// - Parameters:
    ///   - urlString: 请求链接
    ///   - args:      请求参数
    ///   - success:   请求成功
    ///   - failure:   请求失败
    open class func GET(url urlString: String,
                                 args: [String : String]?,
                              success: @escaping ((_ responseObject: [String : AnyObject]?) -> ()),
                              failure: @escaping ((_ error: Error?) -> ())) {
        let Url = URL.init(string: urlString)
        
        var request = URLRequest.init(url: Url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10.0)
        request.allHTTPHeaderFields = ["Content-Type":"application/json"]
        request.httpMethod = "GET"
        
        
        if (args != nil) {
            let paramters_temp : [String : String] = args!
            //if (JSONSerialization.isValidJSONObject(paramters_temp)) {
            let body = try? JSONSerialization.data(withJSONObject: paramters_temp, options: .prettyPrinted)
            // let body = try? JSONSerialization.data(withJSONObject: paramters!, options: .prettyPrinted)
            
            if (body != nil){
                request.httpBody = body
            }
            //}
        }
        
        let session : URLSession = URLSession.shared
        
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if (error != nil) {
                NSLog((error?.localizedDescription)!)
                failure(error!)
            }else if let data_copy = data {
                if let result = try? JSONSerialization.jsonObject(with: data_copy, options: []) as? [String:AnyObject] {
                    success(result)
                }else{
                    assert(false, "JSON解析出错,Code:0700")
                }
            }
        })
        
        dataTask.resume()
    }
/**************************************************************************************************/
/**************************************************************************************************/
/**************************************************************************************************/
    /// HTTP Request POST Method
    ///
    /// - Parameters:
    ///   - urlString: 请求链接
    ///   - args:      请求参数
    ///   - success:   请求成功
    ///   - failure:   请求失败
    open class func POST(url urlString: String,
                                    args: [String : String]?,
                                 success: @escaping((_ responseObject: [String : AnyObject]?) -> ()),
                                 failure: @escaping((_ error: Error?) -> ())) {
        let Url = URL.init(string: urlString)
        
        var request = URLRequest.init(url: Url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        request.httpMethod = "POST"
        
        let mutStr = NSMutableString.init()
        
        if (args != nil) {
            for (key,value) in args!{
                let newVlaue = value.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                mutStr.appendFormat("&%@=%@", key, newVlaue!);
            }
            let body = (mutStr.copy() as! String).data(using: .utf8)
            request.httpBody = body
        }
        //request.allHTTPHeaderFields = ["Content-Type":"application/json"]
        
        let session = URLSession.shared
        
        
        let dataTask = session.dataTask(with: request) { (data, responce, error) in
            if (error != nil) {
                NSLog((error?.localizedDescription)!)
                failure(error!)
            }else if let data_copy = data {
                if let result = try? JSONSerialization.jsonObject(with: data_copy, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:AnyObject] {
                    success(result)
                }else{
                    assert(false, "JSON解析出错,Code:0701")
                }
            }
        }
        dataTask.resume()
    }
/**************************************************************************************************/
/**************************************************************************************************/
/**************************************************************************************************/
}
