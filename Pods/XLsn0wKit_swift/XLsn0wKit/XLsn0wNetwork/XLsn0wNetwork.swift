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
import Foundation
import UIKit
import Alamofire

enum RequestMethod {
    case get
    case post
}

//@escaping 表示是逃逸闭包

/*
 HTTP请求 (GET, POST)
 @args MethodType GET, POST
 @args URLString  URL链接
 @args parameters 拼接的参数
 
 @return JSON 服务器返回的JSON
*/
class XLsn0wNetwork {
    class func request(_ requestMethod : RequestMethod, URLString : String, parameters : [String : Any]? = nil, responseCallback :  @escaping (_ JSON : Any) -> ()) {
        let method = requestMethod == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            guard let JSON = response.result.value else {
                print(response.result.error ?? -1)
                return
            }
            responseCallback(JSON)
        }
    }
}

/*
 XLsn0wNetwork.request(.get, URLString:"http://192.168.0.218:8085/CityPark/upgrade/upgradeBundle", parameters: ["versionCode":1, "platform":2]) { (JSON) in
 //JSON即服务器返回的JSON
 print("\(JSON)")
 }
 
 {
 data =     {
 bundleSize = 1;
 downloadUrl = "";
 md5 = "";
 platform = 2;
 remark = "ios\U8d44\U6e90\U5305";
 status = 1;
 type = 2;
 updateTime = "2017-04-20 09:47:11.0";
 upgradeId = 3;
 upgradeLevel = 1;
 versionCode = 2;
 versionName = "1.0.1";
 };
 message = "\U5347\U7ea7html\U8d44\U6e90\U6210\U529f";
 result = 0;
 }
*/

/*!
 
 通用的基本访问接口
 
 - parameter Url:        请求的地址
 
 - parameter parameters: 参数集合
 
 */

 func generalNormalPostMethods(_ Url:NSString, requestParameters:NSDictionary, completion: @escaping (NSDictionary?, NSError?) ->Void)->Void{
    
    let url = URL.init(string: Url as String)
    
    var urlRequest = URLRequest(url: url!)
    
    urlRequest.httpMethod = "POST"
    
    do {
        
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: requestParameters, options: [])
        
    } catch {
        
        // No-op
        
    }
    
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    Alamofire.request(urlRequest as URLRequestConvertible)
        
        .validate(statusCode: 200..<300)
        
        .validate(contentType: ["application/json"])
        
        .responseJSON { response in
             print(response)
//            print(response.request)  // original URL request
//            
//            print(response.response) // URL response
//            
//            print(response.data)    // server data
            
            print(response.result)  // result of response serialization
            
            switch response.result {
                
            case .success:
                
                print("Validation Successful")
                
                if let JSON = response.result.value {
                    
                    print("JSON: \(JSON)")
                    
                }
                
                let JSON = response.result.value as?NSDictionary
                
                return completion(JSON,nil)
                
            case .failure(let error):
                
                print(error)
                
                return completion(nil,error as NSError?)
                
            }
            
    }
    
}

/*!
 
 上传图片接口（主要是头像）
 
 - parameter Url:        地址
 
 - parameter parameters: 图片以外的参数
 
 - parameter imageArr:  图片数组
 
 - parameter completion: 返回的闭包
 
 */

 func generalUpLoadImagePostMethods(_ Url:NSString, parameters:NSMutableDictionary, imageArr: NSArray, completion: @escaping (NSDictionary?, NSError?) ->Void)->Void{
    
    var theUrl = (Url as String) + "?"
    
    let allKey:NSArray = parameters.allKeys as NSArray
    
    for index in 0 ..< allKey.count{
        
        if index != allKey.count - 1 {
            
            let stringKey:NSString = allKey[index] as! NSString
            
            let stringValue:NSString = parameters.object(forKey: allKey[index])as! NSString
            
            let string = (stringKey as String) + "=" + (stringValue as String) + "&"
            
            theUrl = (theUrl as String) + string
            
        }else{
            
            let stringKey:NSString = allKey[index] as! NSString
            
            let stringValue:NSString = parameters.object(forKey: allKey[index])as! NSString
            
            let string = (stringKey as String) + "=" + (stringValue as String)
            
            theUrl = (theUrl as String) + string
            
        }
        
    }
    
    print(theUrl)
    
    Alamofire.upload(
        
        multipartFormData: { multipartFormData in
            
            for item in imageArr{
                
                multipartFormData.append(UIImagePNGRepresentation(item as! UIImage)!, withName: "headImg",fileName: "headimgad.png", mimeType: "image/png")
                
            }
            
    },
        
        to: theUrl,
        
        encodingCompletion: { encodingResult in
            
            switch encodingResult {
                
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    
                    debugPrint(response)
                    
                    if let JSON = response.result.value {
                        
                        print("JSON: \(JSON)")
                        
                    }
                    
                    let JSON = response.result.value as?NSDictionary
                    
                    return completion(JSON,nil)
                    
                }
                
            case .failure(let error):
                
                print(error)
                
                let errors = NSError(domain: "网络错误", code: 500, userInfo: nil)
                
                return completion(nil,errors)
                
            }
            
    }
        
    )
    
}



