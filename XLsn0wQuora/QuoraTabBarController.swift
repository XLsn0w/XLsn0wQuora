//
//  QUoraTabBarController.swift
//  XLsn0wQuora
//
//  Created by XLsn0w on 2017/6/6.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

import UIKit
import XLsn0wKit_swift

class QuoraTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addTabBarChildViewController()
        addEmitterAnimation()
    }
    
    private func addEmitterAnimation() {
        let heartEmitter =  CAEmitterLayer.initAtPosition(position: CGPoint(x: ScreenWidth/2, y: ScreenHeight/2), size: CGSize(width: 30, height: 30))
        view.layer.addSublayer(heartEmitter)
        let heartsBasicAnimation = CABasicAnimation(keyPath: "emitterCells.heart.birthRate")
        heartsBasicAnimation.fromValue = 150
        heartsBasicAnimation.toValue = 1
        heartsBasicAnimation.duration = 5.0
        heartsBasicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        heartEmitter.add(heartsBasicAnimation, forKey: "heartsBurst")
    }
    
    /// 添加TabBar子控制器
    private func addTabBarChildViewController() {
        addChildViewController(controller: QuoraGiftViewController(), title: "主页", imageName: "tabbar_home")
        addChildViewController(controller: QuoraLiveViewController(), title: "直播", imageName: "tabbar_gift")
        addChildViewController(controller: QuoraWebViewController(),  title: "我的", imageName: "tabbar_me");
    }
    
    private func addChildViewController(controller: UIViewController, title: String, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName)
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        controller.title = title
        
        let navController = NavigationController()
        navController.addChildViewController(controller)
        addChildViewController(navController)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
