//
//  OperateAccountBookView.swift
//  Timi
//
//  Created by 田子瑶 on 16/8/30.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

private let ScreenWidthRatio = UIScreen.main.bounds.width / 320
private let ScreenHeightRatio = UIScreen.main.bounds.height / 480

private let BgViewHeight = 100 * ScreenHeightRatio
private let AllBtnMarginLeft = 40 * ScreenWidthRatio
private let BtnMarginRight = 25 * ScreenWidthRatio


class OperateAccountBookView: UIView {
    
    
    var cancelBlock:(()->Void)?
    var deleteBlock:(()->Void)?
    var editBlock:(()->Void)?
    
    var cancelBtn:UIView!
    var editBtn:UIView!
    var deleteBtn:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.0)
        let tap = UITapGestureRecognizer(target: self, action: #selector(OperateAccountBookView.tapBgView(_:)))
        self.addGestureRecognizer(tap)
        self.isHidden = true
        setup(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showBtnAnimation(){
        self.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.cancelBtn.centerY = self.cancelBtn.centerY - BgViewHeight
        })
        UIView.animate(withDuration: 0.25, animations: {
            self.deleteBtn.centerY = self.deleteBtn.centerY - BgViewHeight
        })
        UIView.animate(withDuration: 0.3, animations: {
            self.editBtn.centerY = self.editBtn.centerY - BgViewHeight
        })
        
    }
    func hideBtnAnimation(){
        self.isHidden = true
        self.cancelBtn.centerY = self.cancelBtn.centerY + BgViewHeight
        self.deleteBtn.centerY = self.deleteBtn.centerY + BgViewHeight
        self.editBtn.centerY = self.editBtn.centerY + BgViewHeight
    }
    
    //MARK: - setup
    fileprivate func setup(_ frame:CGRect){
        
        //背景图
        let bgViewY = frame.height - BgViewHeight
        let bgView = UIView(frame: CGRect(x: 0, y: bgViewY, width: frame.width, height: BgViewHeight))
        bgView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        //按钮
        let cancelBtn = generateBtn(0, title: "取消", imageName: "menu_operation_cancel", action: #selector(OperateAccountBookView.cancelPress(_:)))
        self.cancelBtn = cancelBtn
        let deleteBtn = generateBtn(1, title: "删除", imageName: "menu_operation_delete", action: #selector(OperateAccountBookView.deletePress(_:)))
        self.deleteBtn = deleteBtn
        let editBtn = generateBtn(2, title: "修改", imageName: "menu_operation_edit", action: #selector(OperateAccountBookView.editPress(_:)))
        self.editBtn = editBtn
        
        bgView.addSubview(editBtn)
        bgView.addSubview(deleteBtn)
        bgView.addSubview(cancelBtn)
        self.addSubview(bgView)
    }
    fileprivate func generateBtn(_ index:Int , title:String, imageName:String, action:Selector)->UIView {
        let btnY = 12 * ScreenWidthRatio + BgViewHeight
        let width = frame.width - 25.6 * ScreenWidthRatio - 2 * AllBtnMarginLeft - 2 * BtnMarginRight
        let bgWidth = width / 3
        let offsetX = AllBtnMarginLeft + (bgWidth + BtnMarginRight) * CGFloat(index)
        let bgHeight = (bgWidth / 2) * 3 + 10 * ScreenWidthRatio
        
        let bgView = UIView(frame: CGRect(x: offsetX, y: btnY, width: bgWidth, height: bgHeight))
        //按钮
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: bgWidth, height: bgWidth))
        btn.setImage(UIImage(named: imageName), for: UIControlState())
        btn.addTarget(self, action: action, for: .touchUpInside)
        
        let labelHeight = bgWidth / 2
        let labelY = bgWidth + 10 * ScreenWidthRatio
        //标题
        let label = UILabel(frame: CGRect(x: 0, y: labelY, width: bgWidth, height: labelHeight))
        label.text = title
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: 18)
        label.textColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        
        bgView.addSubview(btn)
        bgView.addSubview(label)
        return bgView
    }
    
    //MARK: - click action
    func tapBgView(_ sender:UITapGestureRecognizer){
        if let cancelBlock = cancelBlock{
            cancelBlock()
        }
    }
    func cancelPress(_ sender:UIButton){
        if let cancelBlock = cancelBlock{
            cancelBlock()
        }
    }
    func deletePress(_ sender:UIButton){
        if let deleteBlock = deleteBlock{
            deleteBlock()
        }
    }
    func editPress(_ sender:UIButton){
        if let editBlock = editBlock{
            editBlock()
        }
    }
}
