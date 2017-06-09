//
//  SearchGiftViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/23.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit


fileprivate let SortViewWidth:CGFloat = 150.0
fileprivate let SortViewHeight:CGFloat = 200.0

class SearchGiftViewController: BaseGoodsViewController {

//MARK: 懒加载
    lazy var popoverSortView:PopoverSortView = PopoverSortView(frame: CGRect(x: ScreenWidth - SortViewWidth, y: 0, width: SortViewWidth, height: SortViewHeight))
    lazy var popoverSortClassifyView:PopoverSortClassifyView = { () -> PopoverSortClassifyView in
        let view = PopoverSortClassifyView()
        view.viewModel = PopoverSortClassifyViewModel()
        return view
    }()
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchGiftView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupSearchGiftViewSubView()
    }
//MARK: 私有方法
    private func setupSearchGiftView() {
        title = "选礼神器"
        view.backgroundColor = SystemGlobalBackgroundColor
        navigationItem.rightBarButtonItem = UIBarButtonItem("icon_sort", target: self, action: #selector(navigationRightBarButonItemClick))
        
        view.addSubview(popoverSortClassifyView)
        view.addSubview(popoverSortView)
    }
    
    private func setupSearchGiftViewSubView() {
        
        popoverSortClassifyView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: view.bounds.width,height: ItemWidth))
        
        mainView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(popoverSortClassifyView.snp.bottom)
            make.height.equalTo(view.bounds.height - ItemWidth)
        }
        
    }
//MARK: 内部响应
    @objc private func navigationRightBarButonItemClick() {
        
        if popoverSortView.isHidden {
            popoverSortView.show()
        }
        else {
            popoverSortView.hide()
        }
        
    }
}
