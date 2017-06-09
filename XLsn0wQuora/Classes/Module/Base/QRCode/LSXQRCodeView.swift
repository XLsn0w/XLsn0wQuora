//
//  LSXQRCodeView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/5.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class LSXQRCodeView: UIView {
    
//MARK: 懒加载
    lazy var resultLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var myLabel:UILabel = {
        let label = UILabel()
        label.text = "我的名片"
        label.textColor = SystemNavgationBarTintColor
        label.textAlignment = .center
        return label
    }()
    //: 冲击波视图
    lazy var lineView:UIImageView = { () -> UIImageView in
        let imageView = UIImageView(image: #imageLiteral(resourceName: "qrcode_scanline_qrcode"))
        return imageView
    }()
    
    
    //: 容器视图
    lazy var containerView:UIView = { ()-> UIView in
        let view = UIView()
        let backImageView = UIImageView(image: #imageLiteral(resourceName: "qrcode_border"))
        view.addSubview(backImageView)
        
        backImageView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview().inset(0)
        })
        
        let clipView = UIView()
        view.addSubview(clipView)
        clipView.addSubview(self.lineView)
        
        
        //: 裁剪视图区域
        clipView.clipsToBounds = true
        
        clipView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 3, left: 0, bottom: 3, right: 0))
            
        }
        
        self.lineView.snp.makeConstraints { (make) in
            make.left.right.width.height.equalToSuperview()
            make.bottom.equalTo(view.snp.top)
        }
        
        return view
    }()

//MARK: 系统方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupQRCodeView()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        containerView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-60)
            make.width.height.equalTo(220)
        }
        
        resultLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(containerView)
            make.top.equalTo(containerView.snp.bottom).offset(20)
        }
        
        myLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(containerView)
            make.top.equalTo(containerView.snp.bottom).offset(100)
        }
    }
    
    
//MARK: 私有方法
    private func setupQRCodeView() {
        addSubview(containerView)
        addSubview(resultLabel)
        addSubview(myLabel)
    }
    
   
}
