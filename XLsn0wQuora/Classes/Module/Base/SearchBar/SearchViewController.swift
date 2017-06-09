//
//  SearchViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/21.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit
import QorumLogs

class SearchViewController: UIViewController {

//MARK: 属性
    fileprivate let searchIdentifer = "searchCell"
    var headerViewHeightConstraint:Constraint?
//MARK: 懒加载
    fileprivate lazy var searchBar:SearchBar = { () -> SearchBar in
        let bar = SearchBar()
        bar.customBorder(withColor: UIColor.white)
        bar.tintColor = SystemNavgationBarTintColor
        bar.bounds.size = CGSize(width: ScreenWidth - margin*6, height: 44)
        bar.delegate = self
        bar.showsBookmarkButton = true
        bar.placeholder = "快选一份礼物，送给亲爱的Ta吧"
        
        return bar
    }()
    lazy var searchHeaderView:SearchHeaderView = { () -> SearchHeaderView in
       
        let view = SearchHeaderView(withFinshedLayout: { [unowned self] (height) in
            self.searchHeaderView.bounds.size = CGSize(width: ScreenWidth, height: height)
            self.tableView.tableHeaderView = self.searchHeaderView
        })
        
        view.viewModel = SearchHeaderViewModel(withModel: SearchViewDataModel())
        view.delegate = self
    
        return view
    }()
    
    lazy var tableView:UITableView = { () -> UITableView in
       let view = UITableView(frame: CGRect.zero, style: .plain)
           view.backgroundColor = SystemGlobalBackgroundColor
           view.separatorStyle = .none
           view.sectionFooterHeight = 0.0001
           view.sectionHeaderHeight = 0.0001
           view.delegate = self
           view.dataSource = self
        
           view.register(SearchGiftCell.self, forCellReuseIdentifier: self.searchIdentifer)
        
        return view
    }()
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupSearchViewSubView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchViewBeforeViewAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        setupSearchViewBeforeViewDisappear()
    }
//MARK: 私有方法
    private func setupSearchView() {
        view.backgroundColor = SystemGlobalBackgroundColor
        navigationItem.titleView = searchBar
        
        tableView.tableHeaderView = searchHeaderView
        view.addSubview(tableView)
    }
    
    private func setupSearchViewSubView(){
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
    }
    
    private func setupSearchViewBeforeViewAppear() {
        searchBar.becomeFirstResponder()
        
    }
    
    private func setupSearchViewBeforeViewDisappear() {
        searchBar.resignFirstResponder()
    }

}
//MARK: 代理方法 
extension SearchViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: searchIdentifer, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return margin
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(SearchGiftViewController(), animated: true)
    }
}

//MARK: 代理方法 -> SearchHeaderViewDelegate
extension SearchViewController:SearchHeaderViewDelegate {
    func searchHeaderViewClickHotButton(button: UIButton) {
        searchBar.text = button.titleLabel?.text
    }
}

extension SearchViewController:UISearchBarDelegate {
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        QL2("语言搜索")
    }
    
}
