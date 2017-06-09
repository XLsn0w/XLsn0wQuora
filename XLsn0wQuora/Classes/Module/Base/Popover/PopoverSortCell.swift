//
//  PopoverSortCell.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/24.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class PopoverSortCell: UITableViewCell {

//MARK: 属性
    var viewModel:PopoverSortCellViewModel? {
        didSet{
            titleLabel.text = viewModel!.titleLabelText
            selectButton.setImage(viewModel!.buttonImage, for: .selected)
            selectButton.isSelected = viewModel!.isSelected
        }
    }
//MARK: 懒加载
    lazy var titleLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font = fontSize14
        return label
    }()
    
    lazy var selectButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.clear
        return button
    }()
//MARK: 构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPopoverSortCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupPopoverSortCellSubView()
    }
//MARK: 私有方法
    private func setupPopoverSortCell() {
        backgroundColor = UIColor.clear
        addSubview(titleLabel)
        addSubview(selectButton)
    }
    
    private func setupPopoverSortCellSubView() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.top.bottom.equalToSuperview()
        }
        
        selectButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(margin*0.5)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(ItemWidth)
        }
    }
}
