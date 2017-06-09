//
//  SettingFooterView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/26.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class SettingFooterView: UIView {

//MARK: 属性
    weak var delegate:SettingFooterViewDelegate?
//MAKR: 懒加载
    lazy var logoutButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setTitle("退出登陆", for: .normal)
        button.titleLabel?.font = fontSize17
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .disabled)
        button.setBackgroundImage(UIImage.image(withColor: SystemNavgationBarTintColor, withSize: CGSize.zero), for: .normal)
        button.setBackgroundImage(UIImage.image(withColor: SystemTintDisableColor, withSize: CGSize.zero), for: .highlighted)
        button.layer.cornerRadius = margin * 0.5
        button.layer.masksToBounds = true
        return button
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSettingFooterView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupSettingFooterViewSubView()
    }
//MARK: 私有方法
    private func setupSettingFooterView() {
        addSubview(logoutButton)
        
        logoutButton.addTarget(self, action: #selector(logoutButtonClick), for: .touchUpInside)
    }
    
    private func setupSettingFooterViewSubView() {
        logoutButton.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(margin)
            make.right.equalToSuperview().offset(-margin)
            make.height.equalTo(margin*5)
        }
    }
//MARK: 内部响应
    @objc private func logoutButtonClick() {
        delegate?.settingFooterViewLogoutButtonClick()
    }

}

//MARK: 协议
protocol SettingFooterViewDelegate:NSObjectProtocol {
    func settingFooterViewLogoutButtonClick()
}
