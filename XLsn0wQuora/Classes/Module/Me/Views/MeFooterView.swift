//
//  MeFooterView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/25.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

fileprivate let LabelColor = UIColor(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0, alpha: 1.0)

class MeFooterView: UIView {
//MARK: 属性
    var viewModel:MeFooterViewModel? {
        didSet{
            tipLabel.text = viewModel?.tipLabelText
            
            if let image = viewModel?.iconImage {
                iconView.image = image
                iconView.isHidden = false
            }
            else{
                iconView.isHidden = true
            }
        }
    }
    weak var delegate:MeFooterViewDelegate?
//MARK 懒加载
    lazy var iconView:UIImageView = UIImageView(image: #imageLiteral(resourceName: "me_blank"))
    lazy var tipLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = LabelColor
        label.font = fontSize16

        return label
    }()
    lazy var loginButton:UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.clear
        return button
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMeFooterView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupMeFooterViewSubView()
    }
    
//MARK: 私有方法
    private func setupMeFooterView() {
        backgroundColor = UIColor.white
        addSubview(iconView)
        addSubview(tipLabel)
        addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
    }
    
    private func setupMeFooterViewSubView() {
        iconView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(margin)
            make.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
//MARK: 内部响应
    @objc private func loginButtonClick() {
        delegate?.meFooterViewLoginButtonClick()
    }
}

//MARK: 协议
protocol MeFooterViewDelegate:NSObjectProtocol {
    func meFooterViewLoginButtonClick()
}
