//
//  ClassifySingleListCell.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/23.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class ClassifySingleListCell: UITableViewCell {
//MARK: 属性
    var viewModel:ClassifySingleListCellViewModel? {
        didSet{
            photoImage.image = viewModel!.photoImage
            titleLabel.text = viewModel!.titleLabelText
            tagLabel.text = viewModel!.tagLabelText
            tagNameLabel.text = viewModel!.tagNameLabelText
            priceButton.setTitle(viewModel!.priceButtonTitle, for: .normal)
        }
    }
//MARK: 懒加载
    lazy var photoImage:UIImageView = UIImageView()
    lazy var titleLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = fontSize14
        label.numberOfLines = 0
        return label
    }()
    
    lazy var tagLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = fontSize14
        return label
    }()
    
    lazy var tagNameLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = fontSize14
        return label
    }()
    
    lazy var priceButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "feed_favoriteicon"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "feed_favoriteicon_selected"), for: .selected)
        button.setTitleColor(normalColor, for: .normal)
        button.setTitleColor(normalColor, for: .selected)
        button.titleLabel?.font = fontSize12
        button.contentMode = .right
        return button
    }()
    
    lazy var sperateLine:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = SystemGlobalLineColor
        return view
    }()
//MARK: 构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupClassifySingleListCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupClassifySingleListCellSubView()
    }
//MARK: 私有方法
    private func setupClassifySingleListCell() {
        addSubview(photoImage)
        addSubview(titleLabel)
        addSubview(tagLabel)
        addSubview(tagNameLabel)
        addSubview(priceButton)
        addSubview(sperateLine)
        
        priceButton.addTarget(self, action: #selector(priseButtonClick(button:)), for: .touchUpInside)
    }
    
    private func setupClassifySingleListCellSubView() {
        photoImage.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(margin)
            make.bottom.equalToSuperview().offset(-margin)
            make.width.equalTo(120.0)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(photoImage.snp.right).offset(margin - 2.0)
            make.top.equalToSuperview().offset(margin*2)
            make.right.equalToSuperview().offset(-margin)
            make.bottom.equalTo(tagLabel.snp.top).offset(-margin*0.5)
        }
        
        tagLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-margin)
        }
        
        tagNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(tagLabel.snp.right).offset(margin - 2.0)
            make.bottom.equalTo(tagLabel)
        }
        
        priceButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(tagNameLabel)
            make.right.equalToSuperview().offset(-(margin*0.5))
            make.width.equalTo(60.0)
        }
        
        sperateLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
//MARK: 内部响应处理
    @objc private func priseButtonClick(button:UIButton) {
        button.isSelected = !button.isSelected
        
        let text = viewModel!.priceButtonTitle!
        
        let title = button.isSelected ? String(Int(text)! + 1) : text
        
        button.setTitle(title, for: .normal)
        
    }
}
