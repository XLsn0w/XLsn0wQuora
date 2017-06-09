//
//  ClassifySingleListSectionView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/23.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class ClassifySingleListSectionView: UIView {

//MARK: 懒加载
    lazy var topSperateLine:UIView = { () -> UIView in
       let view = UIView()
        view.backgroundColor = SystemGlobalLineColor
        return view
    }()
    
    lazy var bottomSperateLine:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = SystemGlobalLineColor
        return view
    }()
    
    lazy var titleLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = fontSize15
        label.text = "列表"
        return label
    }()
    
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupClassifySingleListSectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupClassifySingleListSectionViewSubView()
    }
//MARK: 私有方法
    private func setupClassifySingleListSectionView() {
        addSubview(topSperateLine)
        addSubview(bottomSperateLine)
        addSubview(titleLabel)
    }
    
    private func setupClassifySingleListSectionViewSubView() {
        topSperateLine.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(margin)
        }
        
        bottomSperateLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-margin)
        }
        
    }
}
