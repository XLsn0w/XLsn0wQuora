/*
 RunLoop
 -UIButton
 --UIView
 ----UIViewController
 ------UIWindow
 --------UIApplication
 ----------AppDelegate
 
 变量名是给编译器看的，编译器根据变量是局部还是全局分配内存地址或栈空间，所谓的变量名在内存中不存在，操作时转换成地址数存放在寄存器中了

 程序的内存分配
 1、栈区（stack）——由编译器自动分配释放 ，存放函数的参数值，局部变量的值等。其操作方式类似于数据结构中的栈。
 2、堆区（heap）—— 一般由程序员分配（如new、malloc）和释放（delete，free）， 若程序员不释放，程序结束时可能由OS回收，但这样会导致内存泄露，严重的导致系统崩溃， 如一个程序是长期运行的，申请的变量永远都得不到释放，系统内存会耗尽。注意它与数据结构中的堆是两回事，分配方式倒是类似于链表。
 3、全局区（静态区）（static）——全局变量和静态变量的存储是放在一块的，初始化的全局变量和静态变量在一块区域， 未初始化的全局变量和未初始化的静态变量在相邻的另一块区域。 程序结束后由系统释放。
 4、文字常量区 —— 常量字符串就是放在这里的。 程序结束后由系统释放 。
 5、程序代码区 —— 存放函数体的二进制代码。
 
 堆区就就是就是存放new出来的变量的(objc里面就是创建出来的对象[NSString new])
 
 计算机中的内存是以字节为单位的连续的存储空间,每个字节都有一个唯一的编号,这个编号就称为内存地址;
 
 因为内存的存储空间是连续的,所以,内存字节的地址编号也是连续的,并用二进制或十六进制数来表示;
 
 
 如何创建OC中的对象:
 
 开辟空间(堆区空间):  通过消息发送机制 [Class alloc] 开辟空间时需要一个该类的指针变量来接收. 而在堆
 区开辟的空间才是真正的对象,只不过对于指针变量存储着堆区的首地址,通过它才能访问对象,所以把指针变量叫做对象.
 
 对象创建过程:
 1.将代码读取到内存中的代码区(二进制)
 2.在堆中由系统自动创建该类的类对象,类对象中包含这个类所有的方法
 3.然后在堆中创建该类的实例对象,实例对象中包含这个类的所有属性,还有isa指针(这个指针指向类对象Class)  alloc,init.因为没有重写init方法,所以所有属性设为默认值.
 4.返回实例对象的地址给栈中的引用 person
 Person *person = [Person new];
 
 通过person引用找到类实例,然后通过类实例的isa指针找到类对象,在类对象中找到eat方法进行调用.
 [person eat:"milk"];
 通过Person类调用,会直接到堆中去找Person类的类对象,然后进行调用.
 [Person show];
*/

import UIKit
import SwiftyJSON
import Kingfisher
import SnapKit
import XLsn0wKit_swift
import QorumLogs
import XLsn0wKit_objc

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //全局变量
    var window: UIWindow?
    
    let requestSplashImage = "requestSplashImage"
    var bgImageView:UIImageView? = UIImageView(frame: UIScreen.main.bounds)
    var advImageView:UIImageView?
    let jumpBtn = UIButton()
    let SPLASHIMAGE = "SPLASHIMAGE"
    let drawerController = DrawerController()

    //入口函数
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        addWindow()
//        XLsn0wQuoraRequest.requestSplashImage(reqName: requestSplashImage, delegate: self)
//        addAdvertisement()
//        removeAdvertisement()
//        setupPrintLog()
//        setupRootViewController()
//        setupGlobalStyle()
//        setupGlobalNotice()
      //NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
        NSSetUncaughtExceptionHandler(objc_UncaughtExceptionHandler());
        return true
    }
}

/// 捕获崩溃信息
func objc_UncaughtExceptionHandler() -> @convention(c) (NSException) -> Void {
    return { (exception) -> Void in
        let callStackSymbols = exception.callStackSymbols//得到当前调用栈信息
        let reason = exception.reason//非常重要，就是崩溃的原因
        let name = exception.name//异常类型
        
        XLsn0wLog(reason)
        XLsn0wLog(name)
        XLsn0wLog(callStackSymbols)
        //NSLog("exception type : \(name) \n crash reason : \(String(describing: reason)) \n call stack info : \(callStackSymbols)");
    }
}

// MARK: - AppDelegate extension
extension AppDelegate {

    fileprivate func setupPrintLog() {
        QorumLogs.enabled = true
        QorumLogs.minimumLogLevelShown = 1
    }
    //: 配置主界面流程
    fileprivate func setupRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = GiftMainViewController()
    }
    
    //: 设置主题样式
    fileprivate func setupGlobalStyle() {
        UITabBar.appearance().tintColor = SystemTabBarTintColor
        UINavigationBar.appearance().tintColor = UIColor.white
        
        ProgressHUD.setupProgressHUD()
        
    }
    //: 注册系统通知
    fileprivate func setupGlobalNotice() {
        //: 注册系统通知
        NotificationCenter.default.addObserver(self, selector: #selector(changeDefaultRootViewController(notification:)), name: NSNotification.Name(rawValue: SystemChangeRootViewControllerNotification), object: nil)
        
    }

    //MARK: 登陆业务逻辑
    //: 新特性
    func isNewFeatureVersion() -> Bool {
        
        let newVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        
        
        //: 旧版本到新版本为升序
        guard let sanboxVersion = UserDefaults.standard.object(forKey: "APPVersion") as? String , sanboxVersion.compare(newVersion) != .orderedAscending else {
            //: 跟新版本
            UserDefaults.standard.set(newVersion, forKey: "APPVersion")
            return true
        }
        
        
        return false
    }
    
    func defaultRootViewController() -> UIViewController {
        
        return MainViewController()
        //: 没有登陆跳转到系统主界面
        //        guard LSXUserAccountModel.isLogin() else {
        //            return MainViewController()
        //        }
        //
        //        //: 判断是否新版本
        //        if isNewFeatureVersion() {
        //            return LSXNewFeatureViewController()
        //        }
        //
        //        //: 跳转到欢迎主界面
        //        return LSXWelcomeViewController()
    }
    
    func changeDefaultRootViewController(notification:Notification) {
        
        QL2(notification.userInfo?[ToControllerKey])
        
        
        guard let controllerName = notification.userInfo?[ToControllerKey] as? String else {
            QL4("跳转根控制器失败，传入的控制器名称为空")
            return
        }
        
        guard let controller = UIViewController.controller(withName: controllerName) else {
            QL4("创建控制器失败")
            return
        }
        
        window?.rootViewController = controller
    }
    
    
    /// 添加广告
    fileprivate func addAdvertisement() {
        bgImageView?.image = UIImage(named: "backImage")
        window!.addSubview(bgImageView!)
        if (IS_SCREEN_4_INCH) {
            advImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 100))
        } else if (IS_SCREEN_47_INCH) {
            advImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 115))
        } else {
            advImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 130))
        }
        bgImageView?.addSubview(advImageView!)
        if let data = UserDefaults.standard.object(forKey: SPLASHIMAGE) as? Data
        {
            advImageView?.image = UIImage(data: data)
        }
        
        bgImageView?.isUserInteractionEnabled = true
        advImageView?.isUserInteractionEnabled = true
        jumpBtn.setTitle("跳过", for: .normal)
        jumpBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        jumpBtn.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        jumpBtn.setTitleColor(UIColor.white, for: .normal)
        advImageView?.addSubview(jumpBtn)
        jumpBtn.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(25)
            make.top.equalTo(self.advImageView!).offset(30)
            make.right.equalTo(self.advImageView!).offset(-30)
        }
        jumpBtn.layer.cornerRadius = 6
        jumpBtn.layer.masksToBounds = true
        //        jumpBtn.setTapActionWithBlock { [weak self] in
        //            if let weakSelf = self
        //            {
        //                weakSelf.bgImageView?.removeFromSuperview()
        //                weakSelf.bgImageView = nil
        //                weakSelf.drawerController.checkAppVersion()
        //            }
        //        }
        jumpBtn.isHidden = true
    }
    
    /// 移除广告
    fileprivate func removeAdvertisement() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:
            {
                UIView.animate(withDuration: 1.0, animations:
                    {
                        self.advImageView?.alpha = 0
                        self.bgImageView?.alpha = 0
                },completion: { (finish) in
                    self.bgImageView?.removeFromSuperview()
                    if self.bgImageView != nil {
                        self.drawerController.checkAppVersion()
                    }
                    self.bgImageView = nil
                })
        })
    }
    

    func set_statusBarStyle() -> () {
        //默认的黑色（UIStatusBarStyleDefault） .default
        //白色（UIStatusBarStyleLightContent） .lightContent
        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.shared.statusBarStyle = .default
    }
    
    func addWindow() -> Void {
        window? = UIWindow(frame: UIScreen.main.bounds)//init
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        window?.rootViewController = QuoraTabBarController()
        //window?.rootViewController = UINavigationController.init(rootViewController: QuoraAnimationTableViewController())
    }
}


///Swift 的扩展 extension 可以用来继承协议,实现代码隔离，便于维护
extension AppDelegate: XLsn0wNetworkingDelegate {
    func netWortDidSuccess(result: AnyObject, requestName: String, parameters: NSDictionary?)
    {
        if (requestName == requestSplashImage)
        {
            let json = JSON(result)
            //            let dict = json.dictionaryValue
            //            let creatives = dict["creatives"]
            //            let url = creatives?[0]["url"].string
            
            let splashUrl = json.dictionaryValue["creatives"]?[0]["url"].string
            
            // 对喵神的 Kingfisher 修改了一下，解决了当placeholder为nil的时候，如果原图片框中已有图片，则会闪一下的问题
            // https://github.com/wangrui460/Kingfisher
            advImageView?.kf.setImage(with: URL(string: splashUrl!), completionHandler:
                { [weak self] (image, error, cachtType, url) in
                    if let weakSelf = self
                    {
                        weakSelf.jumpBtn.isHidden = false
                        let data = UIImagePNGRepresentation(image!)
                        UserDefaults.standard.set(data, forKey: weakSelf.SPLASHIMAGE)
                    }
            })
            return
        }
    }
    
    func netWortDidFailed(result: AnyObject, error:Error?, requestName: String, parameters: NSDictionary?) {
        print("\(requestName)---\(error)---")
    }
}



