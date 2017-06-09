//
//  BaseClassifyViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/18.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class BaseClassifyViewController: UIViewController {
//MARK: 属性
    fileprivate let identifier:String = "baseClassify"
//MARK: 懒加载
    lazy var tableView:UITableView = { () -> UITableView in
        let view = UITableView(frame: CGRect.zero, style: .grouped)
        view.backgroundColor = SystemGlobalBackgroundColor
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.separatorStyle = .none
        view.sectionFooterHeight = 10
        view.sectionHeaderHeight = 10
        
    
        
        view.delegate = self
        view.dataSource = self
        
        view.register(BaseClassifyViewCell.self, forCellReuseIdentifier: self.identifier)
        
        return view
    }()
//MARK: 系统方法

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBaseClassifyView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupBaseClassifyViewSubView()
    }
//MARK: 私有方法
    private func setupBaseClassifyView() {
        view.addSubview(tableView)
        
    }

    private func setupBaseClassifyViewSubView() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
}

//MARK: 代理方法 -> 
extension BaseClassifyViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! BaseClassifyViewCell
        cell.viewModel = BaseClassifyViewModel(withModel: BaseClassifyDataModel())
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260.0
    }
}
