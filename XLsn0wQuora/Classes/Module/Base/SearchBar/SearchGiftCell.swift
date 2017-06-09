//
//  SearchGiftCell.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/22.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class SearchGiftCell: UITableViewCell {

//MARK: 懒加载
    lazy var iconImage:UIImageView = UIImageView(image: #imageLiteral(resourceName: "giftcategory_guide"))
    lazy var titleLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.font = fontSize14
        label.textColor = UIColor.gray
        label.text = "使用选礼神器快速挑选礼物"
        return label
    }()
//MARK: 构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSearchGiftCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(margin*2)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImage.snp.right).offset(margin*0.5)
            make.top.bottom.equalToSuperview()
        }
    }
//MARK: 私有方法
    private func setupSearchGiftCell() {
        addSubview(iconImage)
        addSubview(titleLabel)
    }
    
}
