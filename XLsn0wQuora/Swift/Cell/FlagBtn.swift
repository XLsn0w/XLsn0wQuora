//
//  FlagBtn.swift
//  Timi
//
//  Created by 田子瑶 on 16/8/30.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

class FlagBtn: UIButton {
    
    fileprivate var flagImage:UIImageView = UIImageView()
    var showFlag:Bool{
        get{
            return !flagImage.isHidden
        }
        set(newValue){
            flagImage.isHidden = !newValue
        }
    }
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFlag(frame)
    }
    fileprivate func setupFlag(_ frame:CGRect){
        let flagWidth = frame.width / 4
        let flagHeight = frame.height / 3
        let flagImage = UIImageView(frame: CGRect(x: 10, y: 0, width: flagWidth, height: flagHeight))
        flagImage.image = UIImage(named: "menu_selected_icon")
        flagImage.isHidden = true
        self.flagImage = flagImage
        self.addSubview(flagImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

