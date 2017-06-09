//
//  MeHeadFooterView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/24.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

fileprivate let ButtonTitleColor = UIColor(red: 60.0/255.0, green: 60.0/255.0, blue: 60.0/255.0, alpha: 1.0)
fileprivate let BottomLineColor = UIColor(red: 208.0/255.0, green: 208.0/255.0, blue: 208.0/255.0, alpha: 1.0)
class MeHeadFooterView: UIView {
//MARk: 属性
    weak var delegate:MeHeadFooterViewDelegate?
//MARK: 懒加载
    lazy var ShoppingButton:CustomButton = { () -> CustomButton in
        let button = CustomButton(type: .custom)
         button.tag = OptionButtonType.Order.rawValue
         button.setTitle("购物车", for: .normal)
         button.titleLabel?.font = fontSize12
         button.setTitleColor(ButtonTitleColor, for: .normal)
         button.setImage(#imageLiteral(resourceName: "shopcart_bt"), for: .normal)
        
        return button
    }()
    
    lazy var OrderButton:CustomButton = { () -> CustomButton in
        let button = CustomButton(type: .custom)
        button.tag = OptionButtonType.Order.rawValue
        button.setTitle("订单", for: .normal)
        button.titleLabel?.font = fontSize12
        button.setTitleColor(ButtonTitleColor, for: .normal)
        button.setImage(#imageLiteral(resourceName: "order_bt"), for: .normal)
        
        return button
    }()
    
    lazy var DiscountButton:CustomButton = { () -> CustomButton in
        let button = CustomButton(type: .custom)
        button.tag = OptionButtonType.Discount.rawValue
        button.setTitle("礼券", for: .normal)
        button.titleLabel?.font = fontSize12
        button.setTitleColor(ButtonTitleColor, for: .normal)
        button.setImage(#imageLiteral(resourceName: "discount_bt"), for: .normal)
        
        return button
    }()
    
    lazy var CustomerButton:CustomButton = { () -> CustomButton in
        let button = CustomButton(type: .custom)
        button.tag = OptionButtonType.Custemer.rawValue
        button.setTitle("客服", for: .normal)
        button.titleLabel?.font = fontSize12
        button.setTitleColor(ButtonTitleColor, for: .normal)
        button.setImage(#imageLiteral(resourceName: "costomer_bt"), for: .normal)
        
        return button
    }()
    
    lazy var lineView:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = SystemNavgationBarTintColor
        return view
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMeHeadFooterView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupMeHeadFooterViewSubView()
    }
//MARK: 私有方法
    private func setupMeHeadFooterView() {
        addSubview(ShoppingButton)
        addSubview(OrderButton)
        addSubview(DiscountButton)
        addSubview(CustomerButton)
        addSubview(lineView)
        
        ShoppingButton.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        OrderButton.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        DiscountButton.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        CustomerButton.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
    }
    
    private func setupMeHeadFooterViewSubView() {
        ShoppingButton.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalTo(OrderButton)
            make.bottom.equalTo(lineView.snp.top)
        }
        
        OrderButton.snp.makeConstraints { (make) in
            make.left.equalTo(ShoppingButton.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(DiscountButton)
        }
        
        DiscountButton.snp.makeConstraints { (make) in
            make.left.equalTo(OrderButton.snp.right)
            make.top.equalToSuperview()
            make.width.equalTo(CustomerButton)
            make.bottom.equalTo(lineView.snp.top)
        }
        
        CustomerButton.snp.makeConstraints { (make) in
            make.left.equalTo(DiscountButton.snp.right)
            make.top.right.equalToSuperview()
            make.bottom.equalTo(lineView.snp.top)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
//MARK: 内部响应
    @objc private func buttonClick(button:UIButton) {
        
        delegate?.meHeadFooterViewButtonClick(withType:OptionButtonType(rawValue: button.tag)!)
    }
}

//MARk: 代理方法
protocol MeHeadFooterViewDelegate:NSObjectProtocol {
    func meHeadFooterViewButtonClick(withType type:OptionButtonType)
}


public enum OptionButtonType : Int {
    
    case Shopping
    
    case Order
    
    case Discount
    
    case Custemer
    
}
