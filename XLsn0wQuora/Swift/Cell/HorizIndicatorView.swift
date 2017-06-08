//
//  HorizIndicatorView.swift
//  Timi
//
//  Created by 田子瑶 on 16/8/30.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit
import SnapKit

class HorizIndicatorView: UIView {

    fileprivate var percent:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPercentWithText(_ text:String){
        percent.text = text
        percent.sizeToFit()
    }
    
   
    
    fileprivate func setupViews(){
        let indicator = UIImageView(image: UIImage(named: "horizontal_red_line"))
        self.addSubview(indicator)
        indicator.snp_makeConstraints {[weak self](make) in
            if let weakSelf = self {
                
                make.centerY.equalTo(weakSelf)
                make.leading.equalTo(weakSelf)
                make.width.equalTo(10)
 
            }
        }
        
        let percent = UILabel()
        self.percent = percent
        self.addSubview(percent)
        percent.snp_makeConstraints {[weak self](make) -> () in
            if let weakSelf = self{
                make.centerY.equalTo(weakSelf)
                make.leading.equalTo(indicator.snp_trailing)
            }
        }
    }
}
