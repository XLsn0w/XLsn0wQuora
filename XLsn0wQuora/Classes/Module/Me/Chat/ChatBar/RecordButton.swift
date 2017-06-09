//
//  RecordButton.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/29.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let titleLabelFont = fontSize16
fileprivate let titleLabelColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)

fileprivate let normalText = "按住 说话"
fileprivate let hightLightText = "松开 结束"
fileprivate let cancelText = "送开 取消"

fileprivate let hightLightColor = UIColor(white: 0.0, alpha: 0.3)

class RecordButton: UIView {
//MARK: 属性
    weak var delegate:RecordButtonDelegate?
//MARK: 懒加载
    var titleLabel:UILabel = {
        let label = UILabel()
        label.font = fontSize16
        label.textColor = titleLabelColor
        label.textAlignment = .center
        label.text = normalText
        return label
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupRecordButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        setupRecordButtonSubView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        backgroundColor = hightLightColor
        titleLabel.text = hightLightText
        
        delegate?.recordButtonTouchedBegin()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let point = touch.location(in: self) as CGPoint
        
        if (point.x >= 0 && point.x <= self.bounds.width) &&
            (point.y >= 0 && point.y <= self.bounds.height) {
            titleLabel.text = hightLightText
            delegate?.recordButtonTouchedMoved(true)
        }
        else {
            titleLabel.text = cancelText
            delegate?.recordButtonTouchedMoved(false)
        }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        backgroundColor = UIColor.clear
        titleLabel.text = normalText
        
        guard let touch = touches.first else {
            return
        }
        
        let point = touch.location(in: self) as CGPoint
        
        if (point.x >= 0 && point.x <= self.bounds.width) &&
            (point.y >= 0 && point.y <= self.bounds.height) {
            
            //: 结束
            delegate?.recordButtonTouchedEnd()
        }
        else {
            //: 取消
            delegate?.recordButtonTouchedCancel()
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        backgroundColor = UIColor.clear
        titleLabel.text = normalText
        
        //: 取消
        delegate?.recordButtonTouchedCancel()
    }

//MARK: 私有方法
    private func setupRecordButton() {
        addSubview(titleLabel)
        
        setupRecordButtonSubView()
    }
    
    private func setupRecordButtonSubView() {
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
    
}

//MARK: 协议
protocol RecordButtonDelegate:NSObjectProtocol {
    func recordButtonTouchedBegin()
    func recordButtonTouchedMoved(_ isMovingIn:Bool)
    func recordButtonTouchedEnd()
    func recordButtonTouchedCancel()
}

