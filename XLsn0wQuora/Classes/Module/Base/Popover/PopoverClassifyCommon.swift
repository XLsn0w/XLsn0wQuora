//
//  PopoverClassifyCommon.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/15.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

let labelFont = UIFont.systemFont(ofSize: 13.0)
let labelTextColor = UIColor.gray
let scrollLineHeight:CGFloat = 2.0
let scrollLineMargin:CGFloat = 10.0
let scrollButtonMargin:CGFloat = 5.0

let normalColor:UIColor = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
let selectedColor:UIColor = UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0)

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
//: 弹出按钮列数
let popoverButtonNum = 4
let popoverButtonWidth:CGFloat = ScreenWidth/CGFloat(popoverButtonNum)
let popoverButtonHeight:CGFloat = 50.0
let popoverButtonBoderWidth:CGFloat = 0.5
let popoverButtonLineHeight:CGFloat = 2.0
