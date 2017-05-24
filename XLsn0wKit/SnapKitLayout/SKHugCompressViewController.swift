//
//  SKHugCompressViewController.swift
//  AutoLayoutDemo
//
//  Created by 董知樾 on 2017/3/29.
//  Copyright © 2017年 董知樾. All rights reserved.
//

import UIKit

class SKHugCompressViewController: UIViewController {

    
    var hugLabel1 = UILabel()
    var compressResistanceLabel1 = UILabel()
    
    var hugLabel2 = UILabel()
    var compressResistanceLabel2 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Content Hugging/Compression"
        view.backgroundColor = .white
        
        hugLabel1.backgroundColor = UIColor.hexValue(0xf8f8f8)
        hugLabel1.textColor = UIColor.hexValue(0x666666)
        view.addSubview(hugLabel1)
        hugLabel1.font = UIFont.systemFont(ofSize: 14)
        hugLabel1.snp.makeConstraints { (make) in
            make.leading.equalTo(view.layoutMarginsGuide)
            make.centerY.equalTo(view)
        }
        
        compressResistanceLabel1.backgroundColor = UIColor.hexValue(0x666666)
        compressResistanceLabel1.textColor = UIColor.hexValue(0xf8f8f8)
        view.addSubview(compressResistanceLabel1)
        compressResistanceLabel1.font = UIFont.systemFont(ofSize: 14)
        compressResistanceLabel1.snp.makeConstraints { (make) in
            make.leading.equalTo(hugLabel1.snp.trailing).offset(12)
            make.centerY.equalTo(hugLabel1)
            make.trailing.equalTo(view.layoutMarginsGuide)
        }
        
        hugLabel1.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .horizontal)
        compressResistanceLabel1.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, for: .horizontal)
        
        hugLabel1.text = "我是压缩压缩压缩压缩压缩压缩"
        compressResistanceLabel1.text = "我是拉伸拉伸拉伸拉伸拉伸拉伸"
        
        ///一些控件是有故有尺寸‘Intrinsic Content Size’的 ，比如UILabel，一个单独的label我只需要设置leading和top的约束即可，如果我再增加width或者trailing的约束，label就会以width或者trailing为准去调整自身的宽度，这是因为，width、trailing..这些约束的优先级默认是require的，也就是说，如果约束指定了控件的尺寸，控件就会优先选择根据约束计算自身的尺寸。
        ///需求：两个左右并列的label，文字内容和长度都不固定，但（两个label的宽度和+间距）是固定的，要求左侧label的展示完全的内容，右侧的label紧跟着左侧，如果展示不完则省略。
        ///从左至右添加约束，此时如果是在IB中，会报红色警告的，因为两个label都有固有尺寸，系统不知道应该如何处理两者宽度，此时需要给其中一个label添加width约束才能消除警告，但是因为文字的长度不确定，如果通过计算文字宽度然后调整约束的constant值的话，很不优雅，也不符合AutoLayout的自适应的思想。
        ///UIView有这样一个方法setContentCompressionResistancePriority(_ priority: UILayoutPriority, for axis: UILayoutConstraintAxis) ，在horizontal或者vertical方向上设置内容抗压缩的优先级，默认都是750（high），我将一个优先级调低后，二者内容抗压缩的优先级不相等，系统会优先压缩优先级低的label
        ///如果没有特别要求间距的话，用NSAttributedString可以很简单的实现，但是如果需求改为：右侧label的展示完全的内容，左侧的label如果展示不完则省略，用NSAttributedString就不太好了。
        
        //2
        hugLabel2.backgroundColor = UIColor.hexValue(0xf8f8f8)
        hugLabel2.textColor = UIColor.hexValue(0x666666)
        hugLabel2.textAlignment = .center
        view.addSubview(hugLabel2)
        hugLabel2.font = UIFont.systemFont(ofSize: 14)
        hugLabel2.snp.makeConstraints { (make) in
            make.leading.equalTo(view.layoutMarginsGuide)
            make.centerY.equalTo(view).offset(20)
        }
        
        compressResistanceLabel2.backgroundColor = UIColor.hexValue(0x666666)
        compressResistanceLabel2.textColor = UIColor.hexValue(0xf8f8f8)
        compressResistanceLabel2.textAlignment = .center
        view.addSubview(compressResistanceLabel2)
        compressResistanceLabel2.font = UIFont.systemFont(ofSize: 14)
        compressResistanceLabel2.snp.makeConstraints { (make) in
            make.leading.equalTo(hugLabel2.snp.trailing).offset(12)
            make.centerY.equalTo(hugLabel2)
            make.trailing.equalTo(view.layoutMarginsGuide)
        }
        
        hugLabel2.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)
        compressResistanceLabel2.setContentHuggingPriority(UILayoutPriorityDefaultLow, for: .horizontal)
        
        hugLabel2.text = "我是拒绝拉伸"
        compressResistanceLabel2.text = "我是要拉伸"
        
        ///setContentHuggingPriority(_ priority: UILayoutPriority, for axis: UILayoutConstraintAxis)同理
    }
    

}
