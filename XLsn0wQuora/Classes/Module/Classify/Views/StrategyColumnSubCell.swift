//
//  StrategyColumnSubCell.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/21.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class StrategyColumnSubCell: UICollectionViewCell {
//MARk: 属性
    var viewModel:StrategyColumnSubCellViewModel? {
        didSet{
            photoImage.image = viewModel!.photoImage
            titleLabel.text =  viewModel!.titleLabelText
            detialLabel.text = viewModel!.detialLabelText
            nameLabel.text =  viewModel!.nameLabelText
        }
    }
//MARK: 懒加载
    lazy var photoImage:UIImageView = { () -> UIImageView in
        let view = UIImageView()
        return view
    }()
    
    lazy var titleLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = fontSize16
        label.contentMode = .left
        return label
    }()
    
    lazy var detialLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = fontSize12
        label.contentMode = .left
        return label
    }()
    
    lazy var nameLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = fontSize12
        label.contentMode = .left
        return label
    }()
    
    lazy var coverView:UIView = { () ->UIView in
       let view = UIView()
        view.backgroundColor = UIColor.white
        view.addSubview(self.allButton)
        view.isHidden = true
        return view
    }()
    
    lazy var allButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.isUserInteractionEnabled = false
        button.titleLabel?.font = fontSize15
        button.layer.cornerRadius = 2.0
        button.layer.masksToBounds = true
        button.layer.borderColor = SystemNavgationBarTintColor.cgColor
        button.layer.borderWidth = 0.5
        button.setTitle("点击查看全部", for: .normal)
        button.setTitleColor(SystemNavgationBarTintColor, for: .normal)

        return button
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStrategyColumnSubCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        photoImage.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(titleLabel.snp.width)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(photoImage.snp.right).offset(margin - 2)
            make.top.equalToSuperview().offset(margin)
            make.right.equalToSuperview().offset(-(margin - 2))
        }
        
        detialLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(margin*0.5)
            make.width.equalTo(titleLabel.snp.width)
            make.right.equalToSuperview().offset(-(margin - 2))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(detialLabel.snp.bottom).offset(2)
            make.width.equalTo(detialLabel.snp.width)
            make.right.equalToSuperview().offset(-(margin - 2))
        }
        
        coverView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        allButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalTo(photoImage)
            make.width.equalTo(photoImage.bounds.width - margin)
            make.height.equalTo(40)
        }
        
    }
//MARK: 私有方法
    private func setupStrategyColumnSubCell() {
        addSubview(photoImage)
        addSubview(titleLabel)
        addSubview(detialLabel)
        addSubview(nameLabel)
        addSubview(coverView)
    }
}
