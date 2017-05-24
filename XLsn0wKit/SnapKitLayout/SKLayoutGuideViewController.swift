//
//  SKLayoutGuideViewController.swift
//  AutoLayoutDemo
//
//  Created by 董知樾 on 2017/3/28.
//  Copyright © 2017年 董知樾. All rights reserved.
//

import UIKit

class SKLayoutGuideViewController: UIViewController {

    var leftLabel = UILabel()
    var rightLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "SnapKit-UILayoutGuide"
        view.backgroundColor = .white
        
        let layoutGuide = UILayoutGuide()
        view.addLayoutGuide(layoutGuide)
        layoutGuide.snp.makeConstraints { (make) in
            make.center.equalTo(view)
        }
        
        leftLabel.backgroundColor = UIColor.hexValue(0xf8f8f8)
        leftLabel.textColor = UIColor.hexValue(0x666666)
        view.addSubview(leftLabel)
        leftLabel.font = UIFont.systemFont(ofSize: 12)
        leftLabel.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalTo(layoutGuide)
        }
        
        rightLabel.backgroundColor = UIColor.hexValue(0x666666)
        rightLabel.textColor = UIColor.hexValue(0xf8f8f8)
        view.addSubview(rightLabel)
        rightLabel.font = UIFont.systemFont(ofSize: 14)
        rightLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(leftLabel.snp.trailing).offset(12)
            make.trailing.equalTo(layoutGuide)
            make.centerY.equalTo(leftLabel)
        }
        
        leftLabel.text = "左左左左左左"
        rightLabel.text = "右右右右"
        
        ///leftLabel + rightLabel 左右排列，文字内容和长度不确定的情况下整体居中
        ///在之前，由于无法确定整体的中心点（中心点可能在leftLabel内，也可能在rightLabel内，也可能在间距范围内），我会采用添加一个容器view的方法，将leftLabel和rightLabel添加到容器view上，添加从左至右的约束，令leftLabel和rightLabel可以对容器view起到支撑作用（我认为用支撑来形容比较形象，官方的说法应该是Intrinsic Content Size），这样容器view的尺寸就可以确定了，添加约束让容器view居中显示就能达到这样的效果了
        ///在iOS9之后，新增了UILayoutGuide类，可以在不使用容器view的情况下就做到这种效果，对UILayoutGuide可以像对UIView一样添加约束，但是UILayoutGuide并不会创建新的view，感觉像是一个约束的容器（是揣测，工作原理不太清楚）
        ///当然，需要适配iOS8和更早版本的同学并不能很开心的来使用UILayoutGuide😜
    }
    
}
