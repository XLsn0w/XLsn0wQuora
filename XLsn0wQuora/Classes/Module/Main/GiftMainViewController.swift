//
//  MainViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/15.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class GiftMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //: 添加子控制器
        addChildViewController()
    }

    private func addChildViewController(){
        
        addChildViewController(controller: HomeViewController(), title: "小礼品", imageName: "tabbar_home")
        addChildViewController(controller: HotViewController(), title: "热门", imageName: "tabbar_gift")
        addChildViewController(controller: ClassifyViewController(), title: "分类", imageName: "tabbar_category")
        addChildViewController(controller: MeViewController(), title: "我", imageName: "tabbar_me")
    }
    
    private func addChildViewController(controller: UIViewController, title: String, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName)
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        controller.title = title
        
        let nav = NavigationController()
        nav.addChildViewController(controller)
        addChildViewController(nav)
    }

}
