//
//  NavigationController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/15.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
//MARK: 懒加载
    lazy var backBtn: UIButton = UIButton(backTarget: self, action: #selector(NavigationController.backBtnAction))
    
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//MARK: 私有方法
    private func setupNavigationBar() {
        self.interactivePopGestureRecognizer!.delegate = nil;
        
        let appearance = UINavigationBar.appearance()
        appearance.isTranslucent = false

        appearance.setBackgroundImage(UIImage.image(withColor: SystemNavgationBackgroundColor, withSize: CGSize(width: 1, height: 1)), for: UIBarMetrics.default)
  
        
        var textAttrs: [String : AnyObject] = Dictionary()
        textAttrs[NSForegroundColorAttributeName] = UIColor.white
        textAttrs[NSFontAttributeName] = UIFont.systemFont(ofSize: 16)
        appearance.titleTextAttributes = textAttrs
    }
    
    
    func backBtnAction() {
        self.popViewController(animated: true)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
