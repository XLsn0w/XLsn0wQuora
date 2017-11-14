
import UIKit
import QorumLogs

class AccountModel: NSObject,NSCoding {
    
    var id: Int = 0
    //: 用户id
    var uid: String?
    //: 昵称
    var nickname:String?
    //: 头像
    var avatar:String?
    //: 心情寄语
    var say:String?
    //: 性别
    var sex: Int = 0
    //: 账户单例
    static func shareAccount() -> AccountModel? {
        if userAccount == nil {
            userAccount = NSKeyedUnarchiver.unarchiveObject(withFile: AccountModel.filePath) as? AccountModel
            
            return userAccount
        }
        else {
            return userAccount
        }
    }
    
    //: 构造方法
    override init() {
        super.init()
    }
    
    
    //: 判断用户是否登陆
    class func isLogin() -> Bool {
        return AccountModel.shareAccount() != nil
    }
    
    //: 注销登录
    class func logout() {
        
        //: 取消第三方登录授权
//        ShareSDK.cancelAuthorize(SSDKPlatformType.typeQQ)
//        ShareSDK.cancelAuthorize(SSDKPlatformType.typeSinaWeibo)
//        ShareSDK.cancelAuthorize(SSDKPlatformType.typeWechat)
        
        // 清除内存中的账户数据和归档中的数据
        AccountModel.userAccount = nil
        do {
            try FileManager.default.removeItem(atPath: AccountModel.filePath)
        } catch {
            QL4("退出异常")
        }
    }
    
    func saveAccountInfo() {
        AccountModel.userAccount = self
        
        saveAccount()
    }
    
    fileprivate func saveAccount() {
        //: 归档
        NSKeyedArchiver.archiveRootObject(self, toFile: AccountModel.filePath)
    }
    
    // 持久保存到内存中
    fileprivate static var userAccount: AccountModel?
    
    //: 归档账号的路径
    static let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! + "/Account.plist"

    //: 实现归解档的NSCoding代理方法
    func encode(with aCoder: NSCoder){
        aCoder.encode(uid, forKey: "uid_key")
        aCoder.encode(nickname, forKey: "nickname_key")
        aCoder.encode(avatar, forKey: "avatar_key")
        aCoder.encode(say, forKey: "say_key")
        aCoder.encode(sex, forKey: "sex_key")
    }
    
    required  init?(coder aDecoder: NSCoder) {
       uid = aDecoder.decodeObject(forKey: "uid_key") as? String
       nickname = aDecoder.decodeObject(forKey: "nickname_key") as? String
       avatar = aDecoder.decodeObject(forKey: "avatar_key") as? String
       say = aDecoder.decodeObject(forKey: "say_key")  as? String
       sex = aDecoder.decodeInteger(forKey: "sex_key") as Int
    }
    
    //: 账户模型转对外数据模型
    func toUserModel() -> UserModel{
        assert(AccountModel.isLogin(), "用户登陆后才可以获取用户信息！")
        
        let user = UserModel()
        
        user.uid = uid
        user.avatarUrl = avatar
        user.nickname = nickname
        
        return user
    }
}

//MARK: 登陆相关
extension AccountModel {
    /**
     第三方登录
     
     - parameter type:     类型 qq weibo wechat
     - parameter openid:   uid
     - parameter token:    token
     - parameter nickname: 昵称
     - parameter avatar:   头像
     - parameter sex:      性别 0:女 1:男
     - parameter finished: 完成回调
     */
    class func thirdAccountLogin(_ type: String, openid: String, token: String
        , nickname: String, avatar: String, sex: Int
        , finished: @escaping (_ success: Bool, _ tip: String) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "type" : type as AnyObject,
            "identifier" : openid as AnyObject,
            "token" : token as AnyObject,
            "nickname" : nickname as AnyObject,
            "avatar" : avatar as AnyObject,
            "sex" : sex as AnyObject
        ]
        
    
        
//        NetworkTools.shared.get(LOGIN, parameters: parameters) { (isSucess, result, error) in
//
//            guard let result = result else {
//                finished(false, "您的网络不给力哦")
//                return
//            }
//
//            if result["status"] == "success" {
//
//                //: 字典转模型
////                let account = ExchangeToModel.model(withClassName: "AccountModel", withDictionary: result["result"].dictionaryObject!) as! AccountModel
////                //: 存储用户信息
////                account.saveAccountInfo()
//
//                finished(true,"登陆成功")
//            }
//            else {
//                finished(false,result["message"].stringValue)
//            }
//        }
        
    }

}
