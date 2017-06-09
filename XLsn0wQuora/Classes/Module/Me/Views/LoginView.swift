//
//  LoginView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/25.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let defaultValue:CGFloat = 60.0
class LoginView: UIView {

    
//MARK: 属性
    weak var delegate:LoginViewDelegate?
    //: 定时器
    private var timer:Timer?
    fileprivate static var second:CGFloat = defaultValue

//MARK: 懒加载
    lazy var backgroundImage:UIImageView = UIImageView(image: #imageLiteral(resourceName: "login_bg"))
    lazy var closeButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "btn_close"), for: .normal)

        return button
    }()
    
    lazy var loginButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setTitle("登陆", for: .normal)
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
    
    lazy var registerButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setTitle("没有账号", for: .normal)
        button.setTitleColor(SystemNavgationBarTintColor, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.titleLabel?.font = fontSize12
        return button
    }()
    
    lazy var usingPasswdButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setTitle("使用密码", for: .normal)
        button.tag = LoginType.verifyCode.rawValue
        button.setTitleColor(SystemNavgationBarTintColor, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.titleLabel?.font = fontSize12
        return button
    }()
    
    lazy var passwdIconButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "icon_signin_message"), for: .normal)
        
        return button
        
    }()
    
    lazy var verifyCodeButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setTitle("获取验证码", for: .normal)
        button.titleLabel?.font = fontSize10
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage.image(withColor: UIColor.gray, withSize: CGSize.zero), for: .normal)
        button.setBackgroundImage(UIImage.image(withColor: UIColor.lightGray, withSize: CGSize.zero), for: .selected)
        
        return button
    }()
    
    lazy var phoneIconImage:UIImageView = UIImageView(image: #imageLiteral(resourceName: "icon_signin_cellphone"))
    
    lazy var phoneText:UITextField = { () -> UITextField in
        let field = UITextField()
        field.font = fontSize14
        field.placeholder = "请输入手机号"
        field.keyboardType = .phonePad
        field.tintColor = SystemNavgationBarTintColor
        
        return field
    }()
    
    lazy var passwordText:UITextField = { () -> UITextField in
        let field = UITextField()
        field.font = fontSize14
        field.placeholder = "输入验证码"
        field.keyboardType = .numbersAndPunctuation
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
    
    lazy var tipLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.text = "使用社交账号登录"
        label.font = fontSize12
        return label
    }()
    
    lazy var tipLabelLeftLine:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    lazy var tipLabelRightLine:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()

    lazy var qqButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.tag = SocietyType.qq.rawValue
        button.setImage(#imageLiteral(resourceName: "qq"), for: .normal)
        return button
    }()
    
    lazy var sinaButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.tag = SocietyType.sina.rawValue
        button.setImage(#imageLiteral(resourceName: "webo"), for: .normal)
        return button
    }()
    
    lazy var wechatButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.tag = SocietyType.wechat.rawValue
        button.setImage(#imageLiteral(resourceName: "wechat"), for: .normal)
        return button
    }()
    
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLoginView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLoginViewSubView()
    }
//MARK: 私有方法
    private func setupLoginView() {
        
        backgroundColor = SystemGlobalBackgroundColor
    
        addSubview(backgroundImage)
        addSubview(closeButton)
        addSubview(loginButton)
        addSubview(registerButton)
        addSubview(usingPasswdButton)
        addSubview(passwdIconButton)
        addSubview(verifyCodeButton)
        addSubview(phoneIconImage)
        addSubview(passwordText)
        addSubview(phoneText)
        addSubview(phoneInputBottomLine)
        addSubview(paswordBottomLine)
        addSubview(tipLabel)
        addSubview(tipLabelLeftLine)
        addSubview(tipLabelRightLine)
        addSubview(qqButton)
        addSubview(wechatButton)
        addSubview(sinaButton)
        
    
        
        closeButton.addTarget(self, action: #selector(closeLoginView), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonClick), for: .touchUpInside)
        usingPasswdButton.addTarget(self, action: #selector(usingPasswordButtonClick(button:)), for: .touchUpInside)
        verifyCodeButton.addTarget(self, action: #selector(verityCodeButtonClick(button:)), for: .touchUpInside)
        
        qqButton.addTarget(self, action: #selector(SocietyLoginButtonClick(button:)), for: .touchUpInside)
        wechatButton.addTarget(self, action: #selector(SocietyLoginButtonClick(button:)), for: .touchUpInside)
        sinaButton.addTarget(self, action: #selector(SocietyLoginButtonClick(button:)), for: .touchUpInside)
        
        phoneText.addTarget(self, action: #selector(textFieldValueDidChange), for: .editingChanged)
        passwordText.addTarget(self, action: #selector(textFieldValueDidChange), for: .editingChanged)
    }
    
    private func setupLoginViewSubView() {
        
        backgroundImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        closeButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.top.equalToSuperview().offset(margin*1.5)
            make.width.height.equalTo(margin*3.6)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(margin*4)
            make.right.equalToSuperview().offset(-(margin*4))
            make.height.equalTo(margin*4)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.left.equalTo(loginButton)
            make.top.equalTo(loginButton.snp.bottom).offset(margin*1.5)
        }
        
        usingPasswdButton.snp.makeConstraints { (make) in
            make.right.equalTo(loginButton)
            make.top.equalTo(registerButton)
        }
        
        passwdIconButton.snp.makeConstraints { (make) in
            make.left.equalTo(loginButton.snp.left)
            make.bottom.equalTo(loginButton.snp.top).offset(-(margin*3))
            make.size.equalTo(CGSize(width: 14, height: 16))
        }
        
        passwordText.snp.makeConstraints { (make) in
            make.left.equalTo(passwdIconButton.snp.right).offset(margin)
            make.bottom.equalTo(loginButton.snp.top).offset(-(margin*2))
            make.right.equalTo(verifyCodeButton.snp.left).offset(-margin*0.5)
            make.height.equalTo(margin*3.5)
        }
        
        paswordBottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(passwordText)
            make.right.equalTo(loginButton)
            make.top.equalTo(passwordText.snp.bottom)
            make.height.equalTo(0.8)
        }
        
        phoneIconImage.snp.makeConstraints { (make) in
            make.left.size.equalTo(passwdIconButton)
            make.bottom.equalTo(passwdIconButton.snp.top).offset(-(margin*2.5))
        }
        
        phoneText.snp.makeConstraints { (make) in
            make.left.width.equalTo(paswordBottomLine)
            make.bottom.equalTo(passwordText.snp.top).offset(-margin)
            make.height.equalTo(margin*3)
        }
        
        phoneInputBottomLine.snp.makeConstraints { (make) in
            make.left.width.equalTo(phoneText)
            make.top.equalTo(phoneText.snp.bottom)
            make.height.equalTo(paswordBottomLine)
        }
        
        verifyCodeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(passwordText)
            make.right.equalTo(paswordBottomLine)
            make.width.equalTo(margin*7.0)
            make.height.equalTo(phoneText).multipliedBy(0.8)
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-(margin*11))
            make.size.equalTo(CGSize(width: margin*10, height: margin*1.5))
        }
        
        tipLabelLeftLine.snp.makeConstraints { (make) in
            make.right.equalTo(tipLabel.snp.left).offset(-(margin*1.5))
            make.centerY.equalTo(tipLabel)
            make.left.equalTo(loginButton)
            make.height.equalTo(0.8)
        }
        
        tipLabelRightLine.snp.makeConstraints { (make) in
            make.left.equalTo(tipLabel.snp.right).offset(margin*1.5)
            make.centerY.equalTo(tipLabel)
            make.right.equalTo(loginButton)
            make.height.equalTo(tipLabelLeftLine)
        }
        
        wechatButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(tipLabel.snp.bottom).offset(margin*3)
            make.width.height.equalTo(margin*3.6)
        }
        
        sinaButton.snp.makeConstraints { (make) in
            make.top.size.equalTo(wechatButton)
            make.centerX.equalToSuperview().multipliedBy(0.5).offset(-margin)
        }
        
        qqButton.snp.makeConstraints { (make) in
            make.top.size.equalTo(wechatButton)
            make.centerX.equalToSuperview().multipliedBy(1.5).offset(margin)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
        
    }
    
    //: 开始自动轮播
    func startTimer() {
        let timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateValue), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer, forMode: .commonModes)
        self.timer = timer
    }
    
    //: 结束自动轮播
    func stopTimer() {
        if self.timer!.isValid {
            self.timer!.invalidate()
        }
        
        self.timer = nil
    }
//MARK: 内部响应
    @objc private func closeLoginView() {
        delegate?.loginViewCloseButtonClick()
    }
    
    @objc private func loginButtonClick() {
        delegate?.loginViewLoginButtonClick(withPhone: phoneText.text, withPassword: passwordText.text,withType:LoginType(rawValue: usingPasswdButton.tag)!)
    }
    
    @objc private func registerButtonClick() {
        delegate?.loginViewTurnToRegisterViewButtonClick()
    }
    
    @objc private func usingPasswordButtonClick(button:UIButton) {
        
        if button.titleLabel!.text == "使用密码" {
            button.tag = LoginType.usingPassword.rawValue
            verifyCodeButton.isHidden = true
            passwordText.placeholder = "输入密码"
            button.setTitle("使用短信验证码", for: .normal)
            passwdIconButton.setImage(#imageLiteral(resourceName: "icon_signin_password"), for: .normal)
        }else{
            button.tag = LoginType.verifyCode.rawValue
            button.setTitle("使用密码", for: .normal)
            passwordText.placeholder = "输入验证码"
            verifyCodeButton.isHidden = false
            passwdIconButton.setImage(#imageLiteral(resourceName: "icon_signin_message"), for: .normal)
        }
        
        delegate?.loginViewUsingPasswordButtonClick()
    }
    
    @objc private func verityCodeButtonClick(button:UIButton) {
        //: 防止重复发送发送验证码
        guard phoneText.text != "" else {
            ProgressHUD.showInfo(withStatus: "请输入手机号码！")
            return
        }
        //: 发送请求验证码
        button.isEnabled = false
        delegate?.loginViewVerityCodeButtonClick(withPhone: phoneText.text)
        //: 动画
        startTimer()
        
    }


    @objc private func SocietyLoginButtonClick(button:UIButton) {
        delegate?.loginViewSocietyLoginButtonClick(withType: SocietyType(rawValue: button.tag)!)
    }
    
    @objc private func textFieldValueDidChange() {
        loginButton.isEnabled = !passwordText.text!.isEmpty && !phoneText.text!.isEmpty
    }
    
 
    @objc private func updateValue() {
        verifyCodeButton.setTitle("\(LoginView.second)s后再试", for: .normal)
        LoginView.second -= 1
        
        if LoginView.second == 0 {
            stopTimer()
            LoginView.second = defaultValue
            verifyCodeButton.setTitle("获取验证码", for: .normal)
            verifyCodeButton.isEnabled = true
        }
    }
}


//MARK: 协议
protocol LoginViewDelegate:NSObjectProtocol {
    func loginViewCloseButtonClick()
    func loginViewLoginButtonClick(withPhone phone:String?,withPassword passwd:String?,withType type:LoginType)
    func loginViewTurnToRegisterViewButtonClick()
    func loginViewUsingPasswordButtonClick()
    func loginViewVerityCodeButtonClick(withPhone phone:String?)
    func loginViewSocietyLoginButtonClick(withType type:SocietyType)
}

public enum SocietyType : Int {
    
    case wechat 
    
    case sina
    
    case qq

}

public enum LoginType : Int {
    
    case usingPassword
    
    case verifyCode

    
}

