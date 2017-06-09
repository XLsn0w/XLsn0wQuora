//
//  HotViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/15.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import MJRefresh

class HotViewController: BaseGoodsViewController {

//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setupHotView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//MARK: 私有方法
    
    private func setupHotView() {
        view.backgroundColor = SystemGlobalBackgroundColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem("icon_navigation_search", target: self, action: #selector(searchButtonClick))
        
        let head = Refresh(refreshingTarget: self, refreshingAction: #selector(pullDownLoadData))
        mainView.mj_header = head
    }
//MARK: 内部响应
    @objc private func searchButtonClick() {
        
    }
    
    @objc private func pullDownLoadData() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.mainView.mj_header.endRefreshing()
        }
    }
}
