//
//  CommonLabel.swift
//  Timi
//
//  Created by 田子瑶 on 16/8/30.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

var xlLabel:UILabel?

class CommonLabel: UIView {

    fileprivate var upLabel:UILabel!
    fileprivate var downLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    convenience init(){
        self.init(frame: CGRect(x: 0,y: 0,width: 60, height: 60))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLabel(_ text:String) {
        upLabel.text = text
        upLabel.sizeToFit()
    }
    func setDownLabel(_ text:String) {
        downLabel.text = text
        downLabel.sizeToFit()
    }
    
    fileprivate func setupViews() {
        
        let downLabel = UILabel()
        downLabel.textAlignment = .center
        downLabel.sizeToFit()
        self.downLabel = downLabel
        self.addSubview(downLabel)
        downLabel.snp_makeConstraints {[weak self] (make) in
            if let weakSelf = self{
                make.centerX.equalTo(weakSelf.snp_centerX)
                make.bottom.equalTo(weakSelf.snp_bottom)
            }
        }
        let upperLabel = UILabel()
        upperLabel.textAlignment = .center
        upperLabel.sizeToFit()
        self.upLabel = upperLabel
        self.addSubview(upperLabel)
        upperLabel.snp_makeConstraints {[weak self] (make) in
            if let weakSelf = self{
                make.centerX.equalTo(weakSelf.snp_centerX)
                make.top.equalTo(weakSelf.snp_top)
            }
        }
    }
}
