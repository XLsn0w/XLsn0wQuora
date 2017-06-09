//
//  BaseChatCell.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/27.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage


class BaseChatCell: UITableViewCell {
    
    //: CellID
    var id:String?
    //: 视图类型
    var type:MessageType?
    
    var baseViewModel:BaseChatCellViewModel?{
        didSet{
            
            id = baseViewModel!.id
            
            type = baseViewModel!.type
            
            timeLabel.text = baseViewModel!.timeLabelText
            
            if let image = baseViewModel!.avatarImage {
                avatarButton.setImage(image, for: .normal)
            }
            else{
                avatarButton.sd_setImage(with: baseViewModel?.avatarUrl, for: .normal)
            }
            
            //：设置头像圆角
            let width = baseViewModel!.avatarWidth
            setupAvatarCornerRadius(width: width)
            
            nameLabel.isHidden = !baseViewModel!.showNameLabel
            timeLabel.font = baseViewModel?.timeLabelFont
            
            updateLayout(withAvatarWidth: width)
        }
    }
//MARK: 懒加载
    //: 时间戳
    lazy var timeLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.gray
        label.alpha = 0.7
        label.layer.masksToBounds = true
        label.layer.cornerRadius = margin * 0.5
        return label
    }()
    
    //: 用户头像
    lazy var avatarButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "me_avatar_boy"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(white: 0.7, alpha: 1.0).cgColor
        button.addTarget(self, action: #selector(avatarButtonClick(button:)), for: .touchUpInside)
        return button
    }()
    
    //: 用户昵称
    lazy var nameLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.isHidden = true
        label.textColor = UIColor.gray
        label.font = fontSize12
        return label
    }()
    
    //: 消息背景图
    lazy var backView:UIImageView = {() -> UIImageView in
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(backViewLongPress))
        view.addGestureRecognizer(longPress)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(backViewDoubleTap))
        view.addGestureRecognizer(doubleTap)
        
        return view
    }()
    
    //:
//MARK: 构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupBaseChatCell()
        setupBaseChatCellSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: 私有方法
    private func updateLayout(withAvatarWidth width:CGFloat) {
        timeLabel.snp.makeConstraints { (make) in
            make.height.equalTo(margin*2)
        }
        
        avatarButton.snp.remakeConstraints { (make) in
            make.width.height.equalTo(width)
            make.top.equalTo(timeLabel.snp.bottom).offset(margin*1.2)
            if self.baseViewModel!.viewLocation == .right {
                make.right.equalToSuperview().offset(-margin*0.8)
            }
            else{
                make.left.equalToSuperview().offset(margin*0.8)
            }
            
        }
        
        nameLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(avatarButton).offset(-margin*0.1)
             if self.baseViewModel!.viewLocation == .right {
                make.right.equalTo(avatarButton.snp.left).offset(-margin*0.1)
            }
             else {
                make.left.equalTo(avatarButton.snp.left).offset(margin*0.1)
            }
            make.height.equalTo(margin*1.4)
        }
        
        backView.snp.remakeConstraints { (make) in
            if self.baseViewModel!.viewLocation == .right {
                make.right.equalTo(avatarButton.snp.left).offset(-margin*0.5)
            }
            else {
                make.left.equalTo(avatarButton.snp.right).offset(margin*0.5)
            }
            make.top.equalTo(nameLabel.snp.bottom).offset(-margin*0.1)
        }
        
        
    }
    
    
    private func setupBaseChatCellSubView() {
            
            timeLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(margin)
                make.centerX.equalToSuperview()
            }
            
            nameLabel.snp.makeConstraints { (make) in
                make.top.equalTo(avatarButton).offset(-margin*0.1)
                make.right.equalTo(avatarButton.snp.left).offset(-margin*0.1)
            }
            
            avatarButton.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-margin*0.8)
                make.width.height.equalTo(margin*4)
                make.top.equalTo(timeLabel.snp.bottom).offset(margin*1.2)
            }
            
            backView.snp.makeConstraints { (make) in
                make.right.equalTo(avatarButton.snp.left).offset(-margin*0.5)
                make.top.equalTo(nameLabel.snp.bottom).offset(-margin*0.1)
            }
    }
    
    private func setupBaseChatCell() {
        selectionStyle = .none
        backgroundColor = UIColor.clear
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(avatarButton)
        contentView.addSubview(nameLabel)
        contentView.addSubview(backView)
        
    }
    
    private func setupAvatarCornerRadius(width:CGFloat) {
         avatarButton.layer.cornerRadius = width*0.5
    }
    
//MARK: 内部响应
    @objc private func avatarButtonClick(button:UIButton) {
        
    }
    
    @objc private func backViewLongPress() {
        
    }
    
    @objc private func backViewDoubleTap() {
        
    }

}
