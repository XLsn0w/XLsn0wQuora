//
//  RegisterViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/25.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit


class RegisterViewController: UIViewController {

//MARK: 懒加载
    lazy var mainView:RegisterView = RegisterView()
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setupRegisterView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupRegisterViewSubView()
    }
//MARK: 私有方法
    private func setupRegisterView() {
        mainView.delegate = self
        view.addSubview(mainView)
    }
    
    private func setupRegisterViewSubView() {
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }

}

//MARK: 代理方法
extension RegisterViewController:RegisterViewDelegate {
    func registerViewBackButtonClick() {
        dismiss(animated: true, completion: nil)
    }
    
    func registerViewRegisterButtonClick(withPhone text: String?, withPassword passwd: String?) {
        
    }
}
