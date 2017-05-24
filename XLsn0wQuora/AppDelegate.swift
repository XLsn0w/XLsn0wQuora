//
//  AppDelegate.swift
//  XLsn0wQuora
//
//  Created by XLsn0w on 2017/5/23.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let requestSplashImage = "requestSplashImage"
    var bgImageView:UIImageView? = UIImageView(frame: UIScreen.main.bounds)
    var advImageView:UIImageView?
    let jumpBtn = UIButton()
    let SPLASHIMAGE = "SPLASHIMAGE"
    let drawerController = DrawerController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.statusBarStyle = .lightContent
        WRApiContainer.requestSplashImage(reqName: requestSplashImage, delegate: self)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = drawerController
        window?.makeKeyAndVisible()
        
        addAdvertisement()
        removeAdvertisement()
        
        XLsn0wLog(printObject: self)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


//////////////////////////////////////////////////////////////////////////////////////////
// MARK: - 启动闪屏广告相关
extension AppDelegate
{
    /// 添加广告
    fileprivate func addAdvertisement()
    {
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
        jumpBtn.setTapActionWithBlock { [weak self] in
            if let weakSelf = self
            {
                weakSelf.bgImageView?.removeFromSuperview()
                weakSelf.bgImageView = nil
                weakSelf.drawerController.checkAppVersion()
            }
        }
        jumpBtn.isHidden = true
    }
    
    /// 移除广告
    fileprivate func removeAdvertisement()
    {
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
}


//////////////////////////////////////////////////////////////////////////////////////////
// MARK: - WRNetWrapperDelegate
extension AppDelegate: WRNetWrapperDelegate
{
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
    
    func netWortDidFailed(result: AnyObject, error:Error?, requestName: String, parameters: NSDictionary?)
    {
        print("\(requestName)---\(error)---")
    }
}



