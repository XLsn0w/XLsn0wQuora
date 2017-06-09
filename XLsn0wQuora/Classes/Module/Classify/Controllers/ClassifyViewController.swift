//
//  ClassifyViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/15.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class ClassifyViewController: UIViewController {

//MARK: 懒加载
    lazy var titleView:TitleView = { () -> TitleView in
       let view = TitleView()
        view.delegate = self
       return view
    }()
    
    lazy var searchBar:SearchBar = { () -> SearchBar in
        let bar = SearchBar()
        bar.customBorder(withColor: SystemNavgationBarTintColor)
        bar.tintColor = SystemNavgationBarTintColor
        bar.delegate = self
        bar.placeholder = "快选一份礼物，送给亲爱的Ta吧"

        
        return bar
    }()
    
    lazy var scrollView:UIScrollView = { () -> UIScrollView in
        let view = UIScrollView()
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        return view
    }()
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setupClassifyView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupClassifyViewSubView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupClassifyViewDidLayoutSubViews()
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        setupClassifyViewBeforeViewDisappear()
    }
//MARK: 私有方法
    
    private func setupClassifyViewBeforeViewDisappear() {
        
        searchBar.resignFirstResponder()
    }
    
    private func setupClassifyViewDidLayoutSubViews() {
        scrollViewDidScroll(scrollView)
    }
    
    private func setupClassifyView() {
        
        view.backgroundColor = SystemGlobalBackgroundColor
        navigationItem.titleView = titleView
        navigationItem.rightBarButtonItem = UIBarButtonItem("选礼神器", UIColor.white, fontSize15, target: self, action: #selector(searchGiftButtonClick))
        navigationItem.rightBarButtonItem?.customView?.alpha = 0
        view.addSubview(searchBar)
        view.addSubview(scrollView)
        
        let strategyControl = StrategyViewController()
        scrollView.addSubview(strategyControl.view)
        addChildViewController(strategyControl)
        
        let singleGiftControl = SingleGiftViewController()
        scrollView.addSubview(singleGiftControl.view)
        addChildViewController(singleGiftControl)
        
    }
    
    private func setupClassifyViewSubView() {
        DispatchQueue.once(token: "ClassifyView") {
             self.titleView.bounds = CGRect(origin: CGPoint(x: 0, y: 0) , size: CGSize(width: 120, height: 44))
//Warrning: 工具栏上的View不能使用自动布局，否则报错：reason: 'Cannot modify constraints for UINavigationBar managed by a controller
//            self.titleView.snp.makeConstraints({ (make) in
//                make.left.top.equalToSuperview()
//                make.size.equalTo(CGSize(width: 120, height: 44))
//            })
            
            self.searchBar.snp.makeConstraints({ (make) in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(44)
            })
            self.scrollView.snp.makeConstraints({ (make) in
                make.left.right.bottom.equalToSuperview()
                make.top.equalTo(self.searchBar.snp.bottom)
                
            })
            
            self.scrollView.contentSize = CGSize(width: ScreenWidth * 2, height: self.scrollView.bounds.height)
            
            for i in 0..<self.scrollView.subviews.count {
                let view = self.scrollView.subviews[i]
                 view.frame = CGRect(x:ScreenWidth * CGFloat(i), y: 0, width: self.scrollView.bounds.width, height: self.scrollView.bounds.height)
            }
            
           
        }
        
        
    }
//MARK: 内部响应
    @objc private func searchGiftButtonClick() {
        navigationController?.pushViewController(SearchGiftViewController(), animated: true)
    }
}

//MARK: 代理方法 -> TitleViewDelegate
extension ClassifyViewController:TitleViewDelegate {
    func selectedOptionAtItem(item: Int) {
        scrollView.setContentOffset(CGPoint(x: CGFloat(item) * scrollView.bounds.width, y: 0), animated: true)
    }
}

//MARK: 代理方法 -> UISearchBarDelegate
extension ClassifyViewController:UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        navigationController!.pushViewController(SearchViewController(), animated: true)
    }
}

//MARK: 代理方法 -> 
extension ClassifyViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationItem.rightBarButtonItem?.customView?.alpha = scrollView.contentOffset.x/scrollView.bounds.width
        titleView.scrollLine(withOffsetX: scrollView.contentOffset.x)
    }
}
