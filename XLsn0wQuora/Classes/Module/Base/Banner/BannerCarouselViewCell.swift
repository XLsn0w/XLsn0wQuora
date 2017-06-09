//
//  BannerCarouselViewCell.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/18.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//  图片轮播器cell

import UIKit
import SnapKit

class BannerCarouselViewCell: UICollectionViewCell {
//MARK: 属性
    var viewModel:BannerCarouseViewModel? {
        didSet {
            pageView.image = viewModel?.pageImage
        }
    }
//MARK: 懒加载
    private lazy var pageView:UIImageView = { () -> UIImageView in
       let view =  UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBannerCarouselViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
//MARK: 私有方法
    private func setupBannerCarouselViewCell() {
        addSubview(pageView)
    }
}
