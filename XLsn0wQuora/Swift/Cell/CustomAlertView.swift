//
//  CustomAlertView.swift
//  Timi
//
//  Created by 田子瑶 on 16/8/30.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

private let ScreenHeightRatio = UIScreen.main.bounds.height / 480

private let BgMarginLeft:CGFloat = 30
private let BgMarginRight:CGFloat = 30
private let BgMarginTop:CGFloat = 100
private let BgHeight:CGFloat = 170 * ScreenHeightRatio

private let TitleTextHeight:CGFloat = 50 * ScreenHeightRatio
private let ImageViewHeight:CGFloat = 70 * ScreenHeightRatio
private let ImageHeight:CGFloat = 50 * ScreenHeightRatio
private let BtnHeight:CGFloat = 50 * ScreenHeightRatio

private let ImageMarginTop:CGFloat = 10
private let ImageMarginLeft:CGFloat = 10

class CustomAlertView: UIView {
    
    var cancelBlock:(()->Void)?
    var sureBlock:((String, String)->Void)?
    
    //初始化
    fileprivate var titleText:UITextField?
    //标题
    var title:String{
        get{
            if let title = titleText?.text{
                return title != "" ? title : "新建账本"
            }
            else{
                return "新建账本"
            }
        }
        set(newValue){
            titleText?.text = newValue
        }
    }
    var imageArray:[FlagBtn] = []
    //初始化选中背景图,传入图片名
    var initChooseImage:String{
        get{
            for i in 0...imageArray.count - 1{
                if imageArray[i].showFlag == true{
                    return "book_cover_\(i)"
                }
            }
            return "book_cover_0"
        }
        set(newValue){
            for i in 0...imageArray.count - 1{
                if (newValue.range(of: "\(i)") != nil){
                    imageArray[i].showFlag = true
                }
                else{
                    imageArray[i].showFlag = false
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.6)
        let tap = UITapGestureRecognizer(target: self, action: #selector(CustomAlertView.tapBgView(_:)))
        self.addGestureRecognizer(tap)
        setup(frame)
    }
    
    fileprivate func setup(_ frame: CGRect){
        
        let bgWidth = frame.width - BgMarginLeft - BgMarginRight
        let bgView = UIView(frame: CGRect(x: BgMarginLeft, y: BgMarginTop, width: bgWidth, height: BgHeight))
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 10
        
        //账本标题
        let titleText = UITextField(frame: CGRect(x: 0, y: 0, width: bgWidth, height: TitleTextHeight))
        titleText.font = UIFont(name: "Courier", size: 20)
        titleText.placeholder = "新建账本"
        titleText.textAlignment = .center
        self.titleText = titleText
        
        //分割线
        let topSepLine = UIView(frame: CGRect(x: 0, y: TitleTextHeight, width: bgWidth, height: 1))
        topSepLine.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        
        //背景图
        let ImageWidth = (bgWidth - ImageMarginLeft * 6)/5
        var imageArray:[FlagBtn] = []
        for i in 1...5 {
            let imageX = ImageMarginLeft * CGFloat(i)  + ImageWidth * CGFloat(i - 1)
            let frame = CGRect(x: imageX, y: ImageMarginTop + TitleTextHeight, width: ImageWidth, height: ImageHeight)
            let image = FlagBtn(frame: frame)
            image.layer.cornerRadius = 5
            image.tag = i - 1
            image.setImage(UIImage(named: "book_cover_\(i - 1)"), for: UIControlState())
            image.addTarget(self, action: #selector(CustomAlertView.chooseImage(_:)), for: .touchUpInside)
            
            imageArray.append(image)
            bgView.addSubview(image)
        }
        self.imageArray = imageArray
        
        //分割线
        let botmSepLine = UIView(frame: CGRect(x: 0, y: TitleTextHeight + ImageViewHeight , width: bgWidth, height: 1))
        botmSepLine.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        
        //按钮
        let cancelBtn = UIButton(frame: CGRect(x: 0, y: TitleTextHeight + ImageViewHeight, width: bgWidth / 2 - 1, height: BtnHeight))
        cancelBtn.setTitle("取消", for: UIControlState())
        cancelBtn.titleLabel?.font = UIFont(name: "Courier", size: 20)
        cancelBtn.setTitleColor(UIColor.black, for: UIControlState())
        cancelBtn.addTarget(self, action: #selector(CustomAlertView.cancelPress(_:)), for: .touchUpInside)
        let btnSepLine = UIView(frame: CGRect(x: bgWidth / 2 - 1, y: TitleTextHeight + ImageViewHeight, width: 1, height: BtnHeight))
        btnSepLine.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        
        let sureBtn = UIButton(frame: CGRect(x: bgWidth / 2, y: TitleTextHeight + ImageViewHeight, width: bgWidth / 2, height: BtnHeight))
        sureBtn.setTitle("确定", for: UIControlState())
        sureBtn.titleLabel?.font = UIFont(name: "Courier", size: 20)
        sureBtn.setTitleColor(UIColor.black, for: UIControlState())
        sureBtn.addTarget(self, action: #selector(CustomAlertView.surePress(_:)), for: .touchUpInside)
        
        bgView.addSubview(cancelBtn)
        bgView.addSubview(sureBtn)
        bgView.addSubview(btnSepLine)
        bgView.addSubview(topSepLine)
        bgView.addSubview(titleText)
        bgView.addSubview(botmSepLine)
        self.addSubview(bgView)
        
    }
    
    func cancelPress(_ sender:UIButton){
        if let cancelBlock = cancelBlock{
            cancelBlock()
        }
    }
    func surePress(_ sender:UIButton){
        if let sureBlock = sureBlock{
            sureBlock(title, initChooseImage)
        }
    }
    func chooseImage(_ sender: FlagBtn){
        let index = sender.tag
        
        for i in 0...imageArray.count - 1{
            if i == index{
                imageArray[i].showFlag = true
            }
            else{
                imageArray[i].showFlag = false
            }
            
        }
    }
    
    //MARK: - click action
    func tapBgView(_ sender:UITapGestureRecognizer){
        titleText?.resignFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

