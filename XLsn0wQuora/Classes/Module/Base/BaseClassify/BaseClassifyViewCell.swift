//
//  BaseClassifyViewCell.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/20.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit
import QorumLogs

let topViewHeight:CGFloat = 50.0
let middleViewHeight:CGFloat = 150
let bottomViewHeight:CGFloat = 60.0


let sellerHeadWidth:CGFloat = 25.0


let TagButtonBackgroudColor:UIColor =  UIColor(red: 243.0/255.0, green: 230.0/255.0, blue: 230.0/255, alpha: 1.0)


class BaseClassifyViewCell: UITableViewCell {
//MARK: 属性
    var viewModel:BaseClassifyViewModel? {
        didSet{
            middleView.image = viewModel!.image
            tagButton.setTitle(viewModel!.tagButtonText, for: .normal)
            sellerTitleButton.setTitle(viewModel!.sellerTitleButtonText, for: .normal)
            sellerNameLabel.text = viewModel!.sellerNameLabelText
            sellerHeadView.image = viewModel!.sellerHeadImage
            sellerDetailLabel.text = viewModel!.sellerDetailLabelText
            priseButton.setTitle(viewModel!.priseButtonText, for: .normal)
        }
    }
//MARK: 懒加载
    lazy var tagButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.backgroundColor = TagButtonBackgroudColor
        button.setTitleColor(SystemNavgationBarTintColor, for: .normal)
        button.titleLabel?.font = fontSize12
        
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = true
    
        return button
    }()
    
    //: 商家店名
    lazy var sellerTitleButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setTitleColor(normalColor, for: .normal)
        button.titleLabel?.font = fontSize13
        button.contentMode = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -margin, bottom: 0, right: 0)
        
        return button
    }()
    
    //: 商家头像
    lazy var sellerHeadView:UIImageView = { () -> UIImageView in
        let view = UIImageView()
        
        view.layer.cornerRadius = sellerHeadWidth*0.5
        view.layer.masksToBounds = true
        
        let button = UIButton(type: .custom)
        button.frame = view.bounds
        button.addTarget(self, action: #selector(sellerHeadClick), for: .touchUpInside)
        
        view.addSubview(button)
        
        return view
    }()
    //: 商家名称
    lazy var sellerNameLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = normalColor
        
        label.font = fontSize13
        
        return label
    }()
    
    //: 商家描述
    lazy var sellerDetailLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        
        label.textColor = normalColor

        label.font = fontSize14
        
        return label
    }()
    
    //: 商家点赞
    lazy var priseButton: UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "feed_favoriteicon"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "feed_favoriteicon_selected"), for: .selected)
        button.setTitleColor(normalColor, for: .normal)
        button.setTitleColor(normalColor, for: .selected)
        button.titleLabel?.font = fontSize12
        button.contentMode = .right
        
        return button
    }()
    
    lazy var topView:UIView = { () -> UIView in
        let view = UIView()
        
        view.addSubview(self.tagButton)
        view.addSubview(self.sellerTitleButton)
        view.addSubview(self.sellerHeadView)
        view.addSubview(self.sellerNameLabel)
        
        return view
    }()
    
    lazy var middleView:UIImageView = { () -> UIImageView in
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var bottomView:UIView = { () -> UIView in
        let view = UIView()
        view.addSubview(self.sellerDetailLabel)
        view.addSubview(self.priseButton)
        return view
    }()
    
//MARK: 系统方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupBaseClassifyViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        topView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(topViewHeight)
        }
        
        middleView.snp.makeConstraints { (make) in
            make.left.right.equalTo(topView)
            make.top.equalTo(topView.snp.bottom)
            make.height.equalTo(middleViewHeight)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.right.equalTo(middleView)
            make.top.equalTo(middleView.snp.bottom)
            make.height.equalTo(bottomViewHeight)
        }
        
        tagButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 20))
        }
        
        sellerTitleButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(tagButton.snp.right).offset(margin)
            make.size.equalTo(CGSize(width: 150, height: 30))
        }
        
        sellerNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-margin)
            make.height.equalTo(21)
        }
        
        sellerHeadView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(sellerNameLabel.snp.left).offset(-5)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        sellerDetailLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.centerY.equalToSuperview()
            make.height.equalTo(21)
        }
        
        priseButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(sellerDetailLabel.snp.right).offset(margin)
            make.right.equalToSuperview().offset(-margin)
            make.width.equalTo(80)
        }
        
    }
//MARK: 私有方法
    private func setupBaseClassifyViewCell() {
        addSubview(topView)
        addSubview(middleView)
        addSubview(bottomView)
        
        priseButton.addTarget(self, action: #selector(priseButtonClick), for: .touchUpInside)
    }
//MARK: 内部响应
    @objc private func sellerHeadClick() {
        QL2("头像啦")
    }
   
    @objc private func priseButtonClick(button:UIButton) {
        button.isSelected = !button.isSelected
        
        let text = viewModel!.priseButtonText
        
        let title = button.isSelected ? String(Int(text)! + 1) : text

        button.setTitle(title, for: .normal)
    
    }
    
}
