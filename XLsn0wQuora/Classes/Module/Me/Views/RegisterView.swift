//
//  RegisterView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/25.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class RegisterView: UIView {

    //MARK: 属性
    weak var delegate:RegisterViewDelegate?
    //MARK: 懒加载
    lazy var backgroundImage:UIImageView = UIImageView(image: #imageLiteral(resourceName: "login_bg"))
    lazy var backButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "btnBack"), for: .normal)
        
        return button
    }()
    
    lazy var registerButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setTitle("注册", for: .normal)
        button.titleLabel?.font = fontSize15
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .disabled)
        button.setBackgroundImage(UIImage.image(withColor: SystemNavgationBarTintColor, withSize: CGSize.zero), for: .normal)
        button.setBackgroundImage(UIImage.image(withColor: SystemTintDisableColor, withSize: CGSize.zero), for: .disabled)
        button.isEnabled = false
        button.layer.cornerRadius = margin * 0.5
        button.layer.masksToBounds = true
        return button
    }()
    
    
    lazy var passwdIconButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "icon_signin_password"), for: .normal)
        
        return button
        
    }()
    
    lazy var phoneIconImage:UIImageView = UIImageView(image: #imageLiteral(resourceName: "icon_signin_cellphone"))
    
    lazy var phoneText:UITextField = { () -> UITextField in
        let field = UITextField()
        field.font = fontSize14
        field.placeholder = "请输入手机号/用户名"
        field.tintColor = SystemNavgationBarTintColor
        
        return field
    }()
    
    lazy var passwordText:UITextField = { () -> UITextField in
        let field = UITextField()
        field.font = fontSize14
        field.placeholder = "输入密码"
        field.tintColor = SystemNavgationBarTintColor
        field.isSecureTextEntry = true
        
        return field
    }()
    
    lazy var phoneInputBottomLine:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = UIColor.gray
        
        return view
    }()
    lazy var paswordBottomLine:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    
    //MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupRegisterView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupRegisterViewSubView()
    }
    //MARK: 私有方法
    private func setupRegisterView() {
        
        backgroundColor = SystemGlobalBackgroundColor
        
        addSubview(backgroundImage)
        addSubview(backButton)
        addSubview(registerButton)
        addSubview(passwdIconButton)
        addSubview(phoneIconImage)
        addSubview(passwordText)
        addSubview(phoneText)
        addSubview(phoneInputBottomLine)
        addSubview(paswordBottomLine)
   
        
        
        backButton.addTarget(self, action: #selector(backRegisterView), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonClick), for: .touchUpInside)
        
        phoneText.addTarget(self, action: #selector(textFieldValueDidChange), for: .editingChanged)
        passwordText.addTarget(self, action: #selector(textFieldValueDidChange), for: .editingChanged)
    }
    
    private func setupRegisterViewSubView() {
        
        backgroundImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.top.equalToSuperview().offset(margin*1.5)
            make.width.height.equalTo(margin*3.6)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(margin*4)
            make.right.equalToSuperview().offset(-(margin*4))
            make.height.equalTo(margin*4)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.left.equalTo(registerButton)
            make.top.equalTo(registerButton.snp.bottom).offset(margin*1.5)
        }
        
        
        passwdIconButton.snp.makeConstraints { (make) in
            make.left.equalTo(registerButton.snp.left)
            make.bottom.equalTo(registerButton.snp.top).offset(-(margin*3))
            make.size.equalTo(CGSize(width: 14, height: 16))
        }
        
        passwordText.snp.makeConstraints { (make) in
            make.left.equalTo(passwdIconButton.snp.right).offset(margin)
            make.bottom.equalTo(registerButton.snp.top).offset(-(margin*2))
            make.right.equalTo(registerButton)
            make.height.equalTo(margin*3.5)
        }
        
        paswordBottomLine.snp.makeConstraints { (make) in
            make.left.width.equalTo(passwordText)
            make.top.equalTo(passwordText.snp.bottom)
            make.height.equalTo(0.8)
        }
        
        phoneIconImage.snp.makeConstraints { (make) in
            make.left.size.equalTo(passwdIconButton)
            make.bottom.equalTo(passwdIconButton.snp.top).offset(-(margin*2.5))
        }
        
        phoneText.snp.makeConstraints { (make) in
            make.left.width.equalTo(passwordText)
            make.bottom.equalTo(passwordText.snp.top).offset(-margin)
            make.height.equalTo(margin*3)
        }
        
        phoneInputBottomLine.snp.makeConstraints { (make) in
            make.left.width.equalTo(phoneText)
            make.top.equalTo(phoneText.snp.bottom)
            make.height.equalTo(paswordBottomLine)
        }
        
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
        
    }
    //MARK: 内部响应
    @objc private func backRegisterView() {
        delegate?.registerViewBackButtonClick()
    }
    
    @objc private func registerButtonClick() {
        delegate?.registerViewRegisterButtonClick(withPhone: phoneText.text, withPassword: phoneText.text)
    }
  
    
    @objc private func textFieldValueDidChange() {
        registerButton.isEnabled = !passwordText.text!.isEmpty && !phoneText.text!.isEmpty
    }

}

//MARK: 协议
protocol RegisterViewDelegate:NSObjectProtocol {
    func registerViewBackButtonClick()
    func registerViewRegisterButtonClick(withPhone text:String?,withPassword passwd:String?)
}
