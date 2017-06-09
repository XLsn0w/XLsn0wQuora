//
//  MeHeaderView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/24.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SDWebImage

fileprivate let buttonPhotoWidth:CGFloat = 65.0
fileprivate let labelGenderManColor:UIColor = UIColor(red: 27.0/255.0, green: 158.0/255.0, blue: 252.0/255.0, alpha: 1.0)

class MeHeaderView: UIView {
    
    
//MARK: 属性
    weak var delegate:MeHeaderViewDelegate? {
        didSet{
            optionFooterView.delegate = delegate as! MeHeadFooterViewDelegate?
        }
    }
    
    var viewModel:MeHeaderViewModel? {
        didSet{
            
            if !viewModel!.isEmptyModel {
                headImage.sd_setImage(with: viewModel?.headImageUrl, placeholderImage: #imageLiteral(resourceName: "me_avatar_boy"))
                nickNameLabel.text = viewModel?.userNameText
                
               
                
                genderImage.isHidden = false
                
                if viewModel!.gender == 1 {
                    genderImage.image = #imageLiteral(resourceName: "boy_ziliao")
                    if let _ = viewModel?.userNameText {
                        nickNameLabel.textColor = labelGenderManColor
                    }
                }
                else {
                    genderImage.image = #imageLiteral(resourceName: "girl_ziliao")
                    if let _ = viewModel?.userNameText {
                        nickNameLabel.textColor = SystemNavgationBarTintColor
                    }
                }
            }
            else {
                headImage.image = #imageLiteral(resourceName: "me_avatar_boy")
                nickNameLabel.text = "登录"
                genderImage.isHidden = true
                nickNameLabel.textColor = UIColor.white
            }
        }
    }
//MARK: 懒加载
    lazy var optionFooterView:MeHeadFooterView = MeHeadFooterView()
    lazy var backgroundImageView:UIImageView = { () -> UIImageView in
       let view = UIImageView(image: #imageLiteral(resourceName: "me_profile"))
        
        return view
    }()
    
    lazy var headImage:UIImageView = { () -> UIImageView in
        let view = UIImageView(image: #imageLiteral(resourceName: "me_avatar_boy"))
        view.layer.cornerRadius = buttonPhotoWidth * 0.5
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = true
        view.addSubview(self.headIconButton)
        return view
    }()
    
    lazy var genderImage:UIImageView = { () -> UIImageView in
        let view = UIImageView()
        view.isHidden = true 
        return view
    }()
    
    lazy var headIconButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        
        return button
    }()
    
    lazy var nickNameLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.text = "登陆"
        label.textColor = UIColor.white
        label.font = fontSize14
        label.sizeToFit()
        return label
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMeHeaderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupMeHeaderViewSubView()
    }
//MARK: 私有方法
    private func setupMeHeaderView() {
        backgroundColor = UIColor.white
        addSubview(backgroundImageView)
        addSubview(headImage)
        addSubview(genderImage)
        addSubview(nickNameLabel)
        addSubview(optionFooterView)
        
        
        headIconButton.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
    }
    
    private func setupMeHeaderViewSubView() {
       backgroundImageView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(optionFooterView.snp.top)
        }
        
        headImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(90.0)
            make.width.height.equalTo(buttonPhotoWidth)
            make.centerX.equalToSuperview()
        }
        
        genderImage.snp.makeConstraints { (make) in
            make.left.equalTo(headImage.snp.right)
            make.bottom.equalTo(headImage.snp.bottom)
            make.width.height.equalTo(margin*1.2)
        }
        
        headIconButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        nickNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headIconButton.snp.bottom).offset(margin)
            make.centerX.equalToSuperview()
        }
        
        optionFooterView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(70.0)
        }
    }
//MARK: 内部响应
    @objc private func buttonClick(button:UIButton) {
        delegate?.meHeaderViewHeadIconButtonClick(button: button)
    }
}

//MARK: 协议
protocol MeHeaderViewDelegate:NSObjectProtocol {
    func meHeaderViewHeadIconButtonClick(button:UIButton)
}
