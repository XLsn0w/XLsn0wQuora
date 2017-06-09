//
//  SettingViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/25.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {

//MARK: 属性
    fileprivate let setIdentifier = "settingCell"
//MARK: 懒加载
    lazy var footerView:SettingFooterView = SettingFooterView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 200))
    lazy var tableView:UITableView = { () -> UITableView in
        
        let view = UITableView(frame: CGRect.zero, style: .grouped)
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: self.setIdentifier)
        
        return view
        
    }()
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSettingView()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupSettingViewSubView()
    }
//MARK: 私有方法
    private func setupSettingView() {
        title = "设置"
        view.backgroundColor = SystemGlobalBackgroundColor
        
        
        //: 如果登录了显示退出按钮
        if AccountModel.isLogin() {
            tableView.tableFooterView = footerView
            footerView.delegate = self
        }
        
        view.addSubview(tableView)
    }
    
    private func setupSettingViewSubView() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
    
}

//MARK: 代理方法
extension SettingViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: setIdentifier, for: indexPath)
         cell.textLabel?.text = "关于作者"
        return cell
    }

}

extension SettingViewController:SettingFooterViewDelegate {
    func settingFooterViewLogoutButtonClick() {
            let alert = UIAlertController(title: "确定注销登录状态？", message: nil, preferredStyle: .actionSheet)
            
            let actionSure = UIAlertAction(title: "确定", style: .destructive) { (_) in
                AccountModel.logout()
                ProgressHUD.showSuccess(withStatus: "退出成功")
                _ = self.navigationController?.popViewController(animated: true)
            }
            
            let actionCancel = UIAlertAction(title: "取消", style: .cancel) { (_) in
                
            }
        
            alert.addAction(actionSure)
            alert.addAction(actionCancel)
            present(alert, animated: true, completion: nil)
    }
}
