//
//  SearchHeaderView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/22.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

let LineColor = UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0)
let ButtonTintColor = UIColor(red: 80.0/255.0, green: 80.0/255.0, blue: 80.0/255.0, alpha: 1.0)

class SearchHeaderView: UIView {
    
//MARK: 属性
    weak var delegate:SearchHeaderViewDelegate?
    
    var viewModel:SearchHeaderViewModel? {
        didSet{
            buttonTitles = viewModel!.titles
            titleLabel.text = viewModel!.titleLabelText
            
             setupSearchHeaderView()
        }
    }
    var buttonTitles:Array<String>?
    var lastButton:UIButton?
    var selectButton:UIButton?
    
    var layoutHeight:((_ height:CGFloat) ->())?
//MARK: 懒加载
    lazy var titleLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.backgroundColor = SystemGlobalBackgroundColor
        label.font = fontSize13
        label.textAlignment = .left
        label.textColor = UIColor(red: 150.0/255.0, green: 150.0/255.0, blue: 153.0/255.0, alpha: 1.0)
        return label
    }()
    lazy var contentView:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var lineView:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = LineColor
        return view
    }()
//MARK: 构造方法
    init(withFinshedLayout layout:@escaping (_ height:CGFloat) ->()) {
        super.init(frame:CGRect.zero)
        
        self.layoutHeight = layout
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSearchHeaderViewSubView()
    }
//MARK: 私有方法
    private func setupSearchHeaderView() {
        addSubview(contentView)
        addSubview(titleLabel)
        addSubview(lineView)
        setupHotButton()
    }
    
    private func setupSearchHeaderViewSubView() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(30.0)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(0.5)
        }
        
        
        if let buttton = lastButton {
            contentView.snp.makeConstraints({ (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(lineView.snp.bottom)
                make.height.equalTo(buttton.frame.maxY + margin)
            })
            
            //: 重新调整高度
            layoutHeight!(contentView.frame.maxY)
        }else{
            //: 重新调整高度
            layoutHeight!(lineView.frame.maxY)
        }
        
    }
    
    private func setupHotButton() {
        guard let count = buttonTitles?.count  else {
            return
        }
        
        for i in 0..<count{
            let button = createHotButton(index: i)
            let title = buttonTitles![i]
            
            button.setTitle(title, for: .normal)
            button.addTarget(self, action: #selector(hotButtonClick(button:)), for: .touchUpInside)
            contentView.addSubview(button)
            
            let width:CGFloat = title.stringWidth(withFont: button.titleLabel!.font) + margin*4
            button.bounds.size = CGSize(width: width, height: 28.0)
            
            if lastButton == nil {
                button.frame.origin.x = margin
                button.frame.origin.y = margin
            }else{
                let isWrap = ScreenWidth - lastButton!.frame.maxX - margin < button.bounds.width + margin
                
                if isWrap {
                    button.frame.origin.x = margin
                    button.frame.origin.y = lastButton!.frame.maxY + margin
                }else{
                    button.frame.origin.x = lastButton!.frame.maxX + margin
                    button.frame.origin.y = lastButton!.frame.origin.y
                }
            }
            
            lastButton = button
        }
    }
    
    private func createHotButton(index:Int) ->UIButton {
        let button = UIButton(type: .custom)
        button.tag = index
        button.titleLabel?.font = fontSize13
        button.layer.cornerRadius = 3.0
        button.layer.masksToBounds = true
        button.layer.borderWidth = 0.5
        button.layer.borderColor = LineColor.cgColor
        button.setTitleColor(ButtonTintColor, for: .normal)
        button.setTitleColor(SystemNavgationBarTintColor, for: .selected)
        return button
    }
//MARK: 内部响应
    @objc private func hotButtonClick(button:UIButton) {
        
        if selectButton != nil && (selectButton!.isSelected) {
            selectButton!.isSelected = false
            selectButton!.layer.borderColor = LineColor.cgColor
        }
        button.isSelected = true
        selectButton = button
        
        button.layer.borderColor = SystemNavgationBarTintColor.cgColor
        
        delegate?.searchHeaderViewClickHotButton(button: button)
        
    }
}

protocol SearchHeaderViewDelegate:NSObjectProtocol {
    func searchHeaderViewClickHotButton(button:UIButton) -> Void
}
