//
//  loginViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/25.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit
//import LSXPropertyTool
import QorumLogs

class loginViewController: UIViewController {

//MARK: 懒加载
    lazy var mainView:LoginView = LoginView()
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLoginView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupLoginViewSubView()
        
    }
//MARK: 私有方法
    private func setupLoginView() {
//        mainView.delegate = self
        view.addSubview(mainView)
    }
    
    private func setupLoginViewSubView() {
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
}


