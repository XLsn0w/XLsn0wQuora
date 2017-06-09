//
//  StrategySectionView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/21.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class StrategySectionView: UICollectionReusableView {
//MARK: 属性
    weak var delegate:StrategySectionViewDelegate?
//MARK: 懒加载
    lazy var marginTopView:UIView = { () -> UIView in
        let view = UIView()
        
        return view
    }()
    
    lazy var leftLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = normalColor
        label.font = fontSize15
        label.numberOfLines = 1
        label.text = "分类"
        return label
    }()
    
    lazy var rightButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.titleLabel?.font = fontSize14
        button.setTitleColor(UIColor.gray, for: .normal)
        button.setTitle("查看全部", for: .normal)
        button.setImage(#imageLiteral(resourceName: "celldisclosureindicator_nightmode"), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -3, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -141)
        return button
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStrategySectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        marginTopView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(12)
        }
        
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin*1.5)
            make.bottom.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-margin)
            make.width.equalTo(100)
        }
    }
//MARK: 私有方法
    
    private func setupStrategySectionView() {
        addSubview(marginTopView)
        addSubview(leftLabel)
        addSubview(rightButton)
        
        rightButton.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
    }
//MARK: 内部处理
    @objc private func rightButtonClick() {
        delegate?.strategySectionViewRightButtonClick()
    }
    
}

//MARK: 协议方法
protocol StrategySectionViewDelegate:NSObjectProtocol {
    func strategySectionViewRightButtonClick()
}
