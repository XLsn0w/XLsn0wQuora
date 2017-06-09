//
//  SingleGiftSectionView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/21.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class SingleGiftSectionView: UICollectionReusableView {
//MARK: 属性
    var viewModel:SingleGiftSectionViewModel? {
        didSet{
            titleLabel.text = viewModel!.titleLabelText
        }
    }
//MARK: 懒加载
    lazy var titleLabel:UILabel = { () -> UILabel in
       let label = UILabel()
        label.textColor = UIColor.gray
        label.font = fontSize14
       return label
    }()
    
    lazy var leftLine:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = UIColor.gray
        
        return view
    }()
    
    lazy var rightLine:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = UIColor.gray
        
        return view
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSingleGiftSectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupSingleGiftSectionViewSubView()
    }
//MARK: 私有方法
    private func setupSingleGiftSectionView() {
        addSubview(titleLabel)
        addSubview(leftLine)
        addSubview(rightLine)
    }
    
    private func setupSingleGiftSectionViewSubView() {
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.left.equalTo(leftLine.snp.right).offset(margin)
            make.right.equalTo(rightLine.snp.left).offset(-margin)
            make.height.equalTo(21)
            make.width.equalTo(68)
        }
        
        leftLine.snp.makeConstraints { (make) in
            make.left.centerY.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        rightLine.snp.makeConstraints { (make) in
            make.right.centerY.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}
