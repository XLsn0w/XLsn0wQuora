//
//  ClassifySingleListViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/23.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

fileprivate let ImageShowHeight:CGFloat = 150.0

class ClassifySingleListViewController: UIViewController {

    fileprivate let classifySingleIdentifier = "classifySingleCell"

//MARK: 懒加载
    lazy var navigationBarView:NavigationBar = { () -> NavigationBar in
        let bar = NavigationBar(frame: CGRect(x: 0, y: 0, width: self.navigationController!.navigationBar.bounds.width, height: self.navigationController!.navigationBar.bounds.height + 20.0))
        bar.leftButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        bar.backgroundView.backgroundColor = SystemNavgationBarTintColor
        bar.backgroundView.alpha = 0.0
        
        let label = UILabel()
        label.text = "不打烊的礼物店"
        label.textColor = UIColor.white
        label.font = fontSize17
        label.textAlignment = .center
        
        bar.titleView.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.center.equalTo(bar.titleView)
        })
        
        return bar
    }()
    lazy var sectionHeadView:ClassifySingleListSectionView = { () -> ClassifySingleListSectionView in
        let view = ClassifySingleListSectionView()
        view.bounds.size = CGSize(width: ScreenWidth, height: 50.0)
        return view
    }()
    
    lazy var headerView:ClassifySingleListHeadView = { () -> ClassifySingleListHeadView in
        let view = ClassifySingleListHeadView()
        view.backgroundColor = UIColor.white
        view.viewModel = ClassifySingleListHeadViewModel(withModel: ClassifySingleListHeadDataModel())
        view.bounds.size = CGSize(width: ScreenWidth, height: 250.0)
        return view
    }()
    
    lazy var tableView:UITableView = { () -> UITableView in
        let view = UITableView(frame: CGRect.zero, style: .grouped)
        
       
        view.backgroundColor = SystemGlobalBackgroundColor
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.sectionFooterHeight = 0.0001
        view.sectionHeaderHeight = 0.0001
        view.delegate = self
        view.dataSource = self
        
        view.register(ClassifySingleListCell.self , forCellReuseIdentifier: self.classifySingleIdentifier)
        
        return view
    }()
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupClassifySingleListView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        setupClassifySingleListViewSubView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
//MARK: 私有方法
    private func setupClassifySingleListView() {
        tableView.tableHeaderView = headerView
        view.addSubview(tableView)
        
        navigationBarView.leftButton.addTarget(self, action: #selector(navigationLeftBarButonItemClick), for: .touchUpInside)
        view.addSubview(navigationBarView)
    }

    private func setupClassifySingleListViewSubView(){
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
    }
//MARK: 内部响应
    @objc private func navigationLeftBarButonItemClick() {
        //: 返回值可选 解除警告⚠️：Expression of type "UIViewController?" is unused
       _ = navigationController?.popViewController(animated: true)
    }
}

//MARK: 代理方法
extension ClassifySingleListViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: classifySingleIdentifier, for: indexPath) as! ClassifySingleListCell
        
        cell.viewModel = ClassifySingleListCellViewModel(withModel: ClassifySingleListCellDataModel())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionHeadView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
//MARK: 代理方法
extension ClassifySingleListViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y - 20.0
        navigationBarView.backgroundView.alpha = offsetY/(ImageShowHeight - navigationBarView.bounds.height)
    }
}
