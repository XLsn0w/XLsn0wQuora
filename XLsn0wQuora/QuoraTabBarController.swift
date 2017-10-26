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
        addChildViewController()
    }
    
    private func addChildViewController() {
        addChildViewController(controller: GiftHomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(controller: NDHomePageViewController(), title: "直播", imageName: "tabbar_gift")
        addChildViewController(controller: LoadWebViewController(), title: "XLsn0w", imageName: "tabbar_me");
    }
    
    private func addChildViewController(controller: UIViewController, title: String, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName)
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        controller.title = title
        
        let nav = NavigationController()
        nav.addChildViewController(controller)
        addChildViewController(nav)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
