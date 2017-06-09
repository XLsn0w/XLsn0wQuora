//
//  navigationBar.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/23.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class NavigationBar: UIView {

//MARK: 属性
    lazy var backgroundView:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 1.0, alpha: 0.6)
        return view
    }()
    lazy var leftButton:UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    lazy var rightButton:UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    lazy var titleView:UIView = {
        let view = UIView()
        
        return view
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNaivgationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupNaivgationBarSubView()
    }
//MARK: 私有方法
    private func setupNaivgationBar() {
        backgroundColor = UIColor.clear
        addSubview(backgroundView)
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(titleView)
        
    }
    
    private func setupNaivgationBarSubView() {
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        leftButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.centerY.equalToSuperview().offset(margin)
            make.width.height.equalTo(ItemWidth)
        }
        
        rightButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(margin)
            make.right.equalToSuperview().offset(-margin)
            make.width.height.equalTo(ItemWidth)
        }
        
        titleView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(margin)
            make.left.equalTo(leftButton.snp.right).offset(margin)
            make.right.equalTo(rightButton.snp.left).offset(-margin)
        }
    }
}

//MARK:
