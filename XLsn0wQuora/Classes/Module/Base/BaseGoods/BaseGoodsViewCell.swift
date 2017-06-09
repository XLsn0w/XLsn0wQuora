//
//  BaseGoodsViewCell.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/20.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class BaseGoodsViewCell: UICollectionViewCell {
//MARK: 属性
    var viewModel:BaseGoodsViewModel?{
        didSet{
            photoImage.image = viewModel!.photoImage
            priceLabel.text = viewModel!.priceLabelText
            titleLabel.text = viewModel!.titleLabelText
            likeButton.setTitle(viewModel!.likeButtonText, for: .normal)
            
        }
    }
//MARK: 懒加载
    lazy var photoImage:UIImageView = { () -> UIImageView in
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var priceLabel:UILabel = { () -> UILabel in
       let label = UILabel()
        label.textColor = SystemNavgationBarTintColor
        label.font = fontSize12
        
        return label
    }()
    
    lazy var titleLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = normalColor
        label.font = fontSize13
        
        return label
    }()
    
    lazy var likeButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "search_giftbtn_default"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "feed_favoriteicon_selected"), for: .selected)
        button.titleLabel?.font = fontSize12
        button.setTitleColor(normalColor, for: .normal)
        return button
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBaseGoodsView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupBaseGoodsViewSubView()
    }
//MARK: 私有方法
    private func setupBaseGoodsView() {
        backgroundColor = UIColor.white
        addSubview(photoImage)
        addSubview(priceLabel)
        addSubview(titleLabel)
        addSubview(likeButton)
    }
    
    private func setupBaseGoodsViewSubView() {
        priceLabel.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        likeButton.snp.makeConstraints { (make) in
            make.bottom.width.height.equalTo(priceLabel)
            make.right.equalToSuperview().offset(-5)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.right.equalToSuperview().offset(-margin)
            make.top.equalTo(photoImage.snp.bottom).offset(margin*0.5)
            make.height.equalTo(35)
        }
        
        photoImage.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
    }
}
