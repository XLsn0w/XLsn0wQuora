//
//  mainClassifyViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/18.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

let  bannerCarouselViewHeight = 160
let  topicViewHeight = 120

class mainClassifyViewController: BaseClassifyViewController {

//MARK: 懒加载
    lazy var headView:UIView = UIView()
    lazy var bannerCarousel:BannerCarouselView = BannerCarouselView(frame: CGRect.zero, collectionViewLayout: BannerCaruselLayout())
    lazy var topicView:TopicCollectionView = TopicCollectionView(frame: CGRect.zero, collectionViewLayout: TopicFlowLayout())
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMainClassifyView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        headView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(bannerCarouselViewHeight + topicViewHeight + 10)
        }

        bannerCarousel.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(bannerCarouselViewHeight)
        }
        
        topicView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(bannerCarousel.snp.bottom)
            make.height.equalTo(topicViewHeight)
        }
        
        tableView.tableHeaderView = headView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bannerCarousel.startAutoCarousel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        bannerCarousel.stopAutoCarousel()
    }
//MARK: 私有方法
    private func setupMainClassifyView() {
        headView.addSubview(bannerCarousel)
        headView.addSubview(topicView)
        tableView.tableHeaderView = headView
        
    }
}


