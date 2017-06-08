//
//  CustomDatePicker.swift
//  Timi
//
//  Created by 田子瑶 on 16/8/30.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

typealias cancelResponder = () -> ()
typealias sureResponder = (Date)->()

class CustomDatePicker:UIView {
    
    var initDate:Date?
    var pickedValue:Date?
    var cancelCallback: cancelResponder?
    var sureCallback :sureResponder?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame:CGRect, date:Date, cancel:cancelResponder?, sure:sureResponder?){
        self.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.7)
        let tap = UITapGestureRecognizer(target: self, action: #selector(CustomDatePicker.tapBgView(_:)))
        self.addGestureRecognizer(tap)
        self.initDate = date
        self.pickedValue = date
        setupView(frame)
    }
    
    func setupView(_ frame:CGRect){
        let bgWidth = frame.width
        let bgHeight = frame.height * 0.5
        let datePickerHeight = bgHeight - 60
        let btnWidth = bgWidth / 2
        //新建datepicker
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: bgWidth, height: bgHeight))
        bgView.backgroundColor = UIColor.white
        bgView.center = self.center
        //选择器
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: bgWidth, height: datePickerHeight))
        datePicker.setDate(initDate ?? Date(), animated: false)
        datePicker.addTarget(self, action: #selector(CustomDatePicker.chooseValue(_:)), for:.valueChanged)
        //分割线
        let sepLine = UIView(frame: CGRect(x: 0, y: datePickerHeight, width: bgWidth, height: 1))
        sepLine.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        let btnSepLine = UIView(frame: CGRect(x: btnWidth, y: datePickerHeight, width: 1, height: 60))
        btnSepLine.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        //底部按钮
        let cancelBtn = createBtnsWith(CGRect(x: 0, y: datePickerHeight, width: btnWidth, height: 60), title: "取消", action: #selector(CustomDatePicker.clickCancel(_:)))
        let OKBtn = createBtnsWith(CGRect(x: btnWidth, y: datePickerHeight, width: btnWidth, height: 60), title: "确定", action: #selector(CustomDatePicker.clickOK(_:)))
        
        //加到self上
        bgView.addSubview(cancelBtn)
        bgView.addSubview(btnSepLine)
        bgView.addSubview(sepLine)
        bgView.addSubview(OKBtn)
        bgView.addSubview(datePicker)
        self.addSubview(bgView)
    }
    func chooseValue(_ datePicker:UIDatePicker){
        pickedValue = datePicker.date
    }
    
    func tapBgView(_ sender:AnyObject){
        if let cancel = self.cancelCallback {
            cancel()
        }
    }
    func clickCancel(_ sender:AnyObject){
        if let cancel = self.cancelCallback {
            cancel()
        }
    }
    func clickOK(_ sender:AnyObject){
        if let sure = self.sureCallback {
            sure(self.pickedValue ?? Date())
            if let cancel = self.cancelCallback {
                cancel()
            }
        }
    }
    fileprivate func createBtnsWith(_ frame:CGRect, title:String, action:Selector ) -> UIButton {
        let btn = UIButton(frame: frame)
        btn.setTitle(title, for: UIControlState())
        btn.setTitleColor(UIColor.black, for: UIControlState())
        btn.addTarget(self, action: action, for: .touchUpInside)
        return btn
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
