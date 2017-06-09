//
//  TitleView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/20.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit


class TitleView: UIView {
//MARK: 属性
    weak var delegate:TitleViewDelegate?
    var snpLineBottomLeft:Constraint?
//MARK: 懒加载
    lazy var lineBottom:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var strategyButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setTitle("攻略", for: .normal)
        button.titleLabel?.font = fontSize15
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    lazy var singleButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setTitle("单品", for: .normal)
        button.titleLabel?.font = fontSize15
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTitleView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupTitleViewSubView()
        
    }
//MARK: 私有方法
    private func setupTitleView() {
        backgroundColor = UIColor.clear
        
        addSubview(strategyButton)
        addSubview(singleButton)
        addSubview(lineBottom)
        
        strategyButton.addTarget(self, action: #selector(strategyButtonClick), for: .touchUpInside)
        singleButton.addTarget(self, action: #selector(singleButtonClick), for: .touchUpInside)
        
        
    }
    
    private func setupTitleViewSubView() {
    
    DispatchQueue.once(token: "titleView.LayoutSubView") {
            strategyButton.snp.makeConstraints { (make) in
                make.left.top.height.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.5)
            }
            
            singleButton.snp.makeConstraints { (make) in
                make.top.right.equalToSuperview()
                make.width.height.equalTo(strategyButton)
            }
            
            
            lineBottom.snp.makeConstraints { (make) in
                snpLineBottomLeft = make.left.equalToSuperview().offset(margin*0.5).constraint
                make.bottom.equalToSuperview().offset(-4.0)
                make.height.equalTo(2.0)
                make.width.equalToSuperview().multipliedBy(0.4)
            }
        }
       
    }
//MARK: 内部响应处理
    @objc private func strategyButtonClick() {
        delegate?.selectedOptionAtItem(item: 0)
    }
    
    @objc private func singleButtonClick() {
        delegate?.selectedOptionAtItem(item: 1)
    }
    
//MARK: 公共方法
    func scrollLine(withOffsetX offset:CGFloat) {
        let x = margin*0.5 + offset/ScreenWidth * bounds.width * 0.5
        
        snpLineBottomLeft?.update(offset: x)

    }
}

protocol TitleViewDelegate:NSObjectProtocol {
    func selectedOptionAtItem(item:Int)
}
