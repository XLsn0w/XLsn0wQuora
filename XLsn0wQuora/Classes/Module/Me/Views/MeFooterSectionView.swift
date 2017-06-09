//
//  MeFooterSectionView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/25.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class MeFooterSectionView: UIView {

    weak var delegate:MeFooterSectionViewDelegate?
     var lineViewLeftConstraint:Constraint?
//MARK: 懒加载
    lazy var singleGiftButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        
        button.tag = 0
        button.setTitle("单品", for: .normal)
        button.titleLabel?.font = fontSize15
        button.setTitleColor(UIColor.gray, for: .normal)
        
        return button
    }()
    
    lazy var strategyGiftButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        
        button.tag = 1
        button.setTitle("攻略", for: .normal)
        button.titleLabel?.font = fontSize15
        button.setTitleColor(UIColor.gray, for: .normal)
        
        return button
    }()
    
    lazy var lineView:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = SystemNavgationBarTintColor
        return view
    }()
    
    lazy var bottomLine:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = SystemGlobalLineColor
        return view
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMeFooterSectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
         setupMeFooterSectionViewSubView()
    }
//MARK: 私有方法
    private func setupMeFooterSectionView() {
        
        backgroundColor = UIColor.white
        addSubview(singleGiftButton)
        addSubview(strategyGiftButton)
        addSubview(lineView)
        addSubview(bottomLine)
       
        
        singleGiftButton.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        strategyGiftButton.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
    }
    
    private func  setupMeFooterSectionViewSubView() {
        
     DispatchQueue.once(token: "MeFooterSectionView.LayoutSubView") {
            singleGiftButton.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview()
                make.bottom.equalTo(lineView.snp.top)
                make.width.equalTo(strategyGiftButton)
            }
            
            strategyGiftButton.snp.makeConstraints { (make) in
                make.top.right.equalToSuperview()
                make.left.equalTo(singleGiftButton.snp.right)
                make.bottom.equalTo(singleGiftButton)
            }
            
            lineView.snp.makeConstraints { (make) in
                lineViewLeftConstraint = make.left.equalToSuperview().constraint
                make.bottom.equalToSuperview()
                make.width.equalTo(singleGiftButton)
                make.height.equalTo(5.0)
            }
        
            bottomLine.snp.makeConstraints({ (make) in
                make.left.right.bottom.equalToSuperview()
                make.height.equalTo(0.8)
            })
        }
    }
//MARK: 内部处理方法
    @objc private func buttonClick(button:UIButton) {
        let offset = CGFloat(button.tag)*button.bounds.width
        
        lineViewLeftConstraint?.update(offset: offset)
        
        super.updateConstraints()
        
        delegate?.meFooterSectionViewButtonClick(button: button)
    }
}

//MARK: 协议
protocol MeFooterSectionViewDelegate:NSObjectProtocol {
    func meFooterSectionViewButtonClick(button:UIButton)
}
