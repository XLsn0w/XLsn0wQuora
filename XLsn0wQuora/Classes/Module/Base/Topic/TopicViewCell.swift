//
//  TopicViewCell.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/20.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class TopicViewCell: UICollectionViewCell {
//MARK: 属性
    var viewModel:TopicViewModel? {
        didSet{
            imageView.image = viewModel?.image
        }
    }
//MARK: 懒加载
    lazy var imageView:UIImageView = UIImageView()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTopicViewCell()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupTopicViewSubView()
    }
//MARK: 私有方法
    private func setupTopicViewCell() {
        addSubview(imageView)
    }
    
    private func setupTopicViewSubView() {
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
}
