//
//  SingleGiftCell.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/21.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class SingleGiftCell: UICollectionViewCell {

//MARk: 属性
    var viewModel:SingleGiftCellViewModel? {
        didSet{
            photoImage.image = viewModel!.photoImage
            titleLabel.text = viewModel!.titleLabelText
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
        label.font = fontSize14
        return label
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSingleGiftCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupSingleGiftCellSubView()
    }
//MARK: 私有方法
    private func setupSingleGiftCell() {
        addSubview(photoImage)
        addSubview(titleLabel)
    }
    
    private func setupSingleGiftCellSubView() {
        photoImage.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(photoImage.snp.bottom).offset(margin*2)
            make.height.equalTo(17)
        }
    }
}
