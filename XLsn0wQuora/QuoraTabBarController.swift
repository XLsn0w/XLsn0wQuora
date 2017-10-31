//
//  QUoraTabBarController.swift
//  XLsn0wQuora
//
//  Created by XLsn0w on 2017/6/9.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

import UIKit
import XLsn0wKit_swift

class QuoraTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addTabBarChildViewController()
    }
    
    /// 添加TabBar子控制器
    private func addTabBarChildViewController() {
        addChildViewController(controller: QuoraGiftViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(controller: QuoraLiveViewController(), title: "直播", imageName: "tabbar_gift")
        addChildViewController(controller: QuoraWebViewController(), title: "XLsn0w", imageName: "tabbar_me");
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
