//
//  SingleGiftColumnCell.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/21.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class SingleGiftColumnCell: UITableViewCell {

//MARK: 属性
    var viewModel:SingleGiftColumnCellViewModel? {
        didSet{
            titleButton.setTitle(viewModel!.titleButtonText, for: .normal)
        }
    }
//MARK: 懒加载
    
    lazy var lineLeft:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = SystemNavgationBarTintColor
        view.isHidden = true
        return view
    }()
    
    lazy var titleButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.titleLabel?.font = fontSize15
        // : 禁止按钮的交互
        button.isUserInteractionEnabled = false
        button.setTitleColor(normalColor, for: .normal)
        button.setTitleColor(SystemNavgationBarTintColor, for: .selected)
        button.setBackgroundImage(UIImage.image(withColor: SystemGlobalBackgroundColor, withSize: CGSize.zero), for: .normal)
        button.setBackgroundImage(UIImage.image(withColor: UIColor.white, withSize: CGSize.zero), for: .selected)
        
        return button
    }()
    
//MARK: 构造方法
    convenience init(reuseIdentifier: String?) {
        self.init(style: UITableViewCellStyle.default , reuseIdentifier: reuseIdentifier)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSingleGiftColumnCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSingleGiftColumnCellSubView()
    }
    
//MARK: 私有方法
    private func setupSingleGiftColumnCell() {
        contentView.addSubview(lineLeft)
        contentView.addSubview(titleButton)
        
    }
    
    private func setupSingleGiftColumnCellSubView() {
        lineLeft.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(3)
        }
        
        titleButton.snp.makeConstraints { (make) in
            make.left.equalTo(lineLeft.snp.right)
            make.top.right.bottom.equalToSuperview()
        }
    }
//MARK: 外部方法
    func selectedCell(select:Bool) {
        titleButton.isSelected = select
        lineLeft.isHidden = !select
    }
    
}
