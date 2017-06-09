//
//  ClassifySingleListHeadView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/23.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class ClassifySingleListHeadView: UIView {

//MARK: 属性
    var viewModel:ClassifySingleListHeadViewModel? {
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
        label.textColor = UIColor.gray
        label.font = fontSize15
        return label
    }()
    
    lazy var sperateLine:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = SystemGlobalBackgroundColor
        return view
    }()
    
    lazy var detialLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = fontSize14
        label.numberOfLines = 0
        return label
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupClassifySingleListHeadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupClassifySingleListHeadViewSubView()
    }
//MARK: 私有方法
    private func setupClassifySingleListHeadView() {
        addSubview(photoImage)
        addSubview(titleLabel)
        addSubview(sperateLine)
        addSubview(detialLabel)
    }
    
    private func setupClassifySingleListHeadViewSubView() {
        photoImage.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(150.0)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.top.equalTo(photoImage.snp.bottom).offset(margin)
            make.height.equalTo(18.0)
        }
        
        sperateLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(margin*0.5)
            make.height.equalTo(0.5)
        }
        
        detialLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.top.equalTo(sperateLine.snp.bottom).offset(margin*0.5)
            make.right.bottom.equalToSuperview().offset(-margin)
        }
    }
    
}
