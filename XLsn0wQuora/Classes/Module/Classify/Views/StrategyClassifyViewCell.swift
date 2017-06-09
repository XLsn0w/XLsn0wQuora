//
//  StrategyClassifyViewCell.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/21.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class StrategyClassifyViewCell: UICollectionViewCell {
//MARK: 属性
    var viewModel:StrategyClassifyViewCellViewModel? {
        didSet{
            photoImage.image = viewModel!.photoImage
            titleLabel.text = viewModel!.titleLabelText
            detialLabel.text = viewModel!.detialLabelText
        }
    }
//MARK: 懒加载
    lazy var photoImage:UIImageView = UIImageView()
    lazy var titleLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = fontSize18
        return label
    }()
    
    lazy var detialLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = normalColor
        label.font = fontSize14
        label.numberOfLines = 0
        return label
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStrategyClassifyViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        photoImage.snp.makeConstraints { (make) in
            make.centerX.top.equalToSuperview()
            make.left.equalToSuperview().offset(margin)
            make.right.equalToSuperview().offset(-margin)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(photoImage)
            make.top.equalTo(photoImage.snp.bottom).offset(margin*0.5)
        }
        
        detialLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(margin*0.5)
        }
        
    }
//MARK: 私有方法
    private func setupStrategyClassifyViewCell() {
        addSubview(photoImage)
        addSubview(titleLabel)
        addSubview(detialLabel)
    }
}
