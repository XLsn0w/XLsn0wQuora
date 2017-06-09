//
//  PopoverSortClassifyView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/23.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let LineViewColor:UIColor = UIColor (red: 223.0/255.0, green: 223.0/255.0, blue: 223.0/255.0, alpha: 1.0)
fileprivate let ButtonBorderColor:UIColor = UIColor (red: 223.0/255.0, green: 223.0/255.0, blue: 223.0/255.0, alpha: 1.0)

fileprivate let buttonColumn  = 3
fileprivate let buttonMargin:CGFloat = margin*1.5
fileprivate let buttonWidth:CGFloat = (ScreenWidth - CGFloat(buttonColumn + 1) * buttonMargin)/CGFloat(buttonColumn)
fileprivate let buttonHeight:CGFloat = ItemWidth

class PopoverSortClassifyView: UIView {
    
    var viewModel:PopoverSortClassifyViewModel? {
        didSet{
            buttonTitles = viewModel!.buttonTitles
            popoverTitles = viewModel!.popoverTitles
            
            setupPopoverSortClassifyView()
        }
    }
    
    var buttonTitles:Array<String>?
    var popoverTitles:Array<Array<String>>?
    var popoverViewCache = [String:UIView]()
    var popoverButtonCache  = [String:UIButton]()
    var currentPopoverView:UIView?
    var currentPopoverButton:UIButton?
    var isShowingPopoverCover:Bool = false
//MARK: 懒加载
    lazy var coverView:CoverView =  CoverView()
    
    lazy var leftButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.tag = 0
        button.backgroundColor = UIColor.white
        button.setTitleColor(normalColor, for: .normal)
        button.titleLabel?.font = fontSize14
        button.setImage(#imageLiteral(resourceName: "giftcategorydetail_arrow_down_gray"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "giftcategorydetail_arrow_up_gray"), for: .selected)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -93)
        return button
    }()
    
    lazy var centerLeftButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        
        button.backgroundColor = UIColor.white
        button.tag = 1
        button.setTitleColor(normalColor, for: .normal)
        button.titleLabel?.font = fontSize14
        button.setImage(#imageLiteral(resourceName: "giftcategorydetail_arrow_down_gray"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "giftcategorydetail_arrow_up_gray"), for: .selected)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -93)
        return button
    }()
    
    lazy var centerRightButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.tag = 2
        button.backgroundColor = UIColor.white
        button.setTitleColor(normalColor, for: .normal)
        button.titleLabel?.font = fontSize14
        button.setImage(#imageLiteral(resourceName: "giftcategorydetail_arrow_down_gray"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "giftcategorydetail_arrow_up_gray"), for: .selected)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -93)
        return button
    }()
    
    lazy var rightButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.tag = 3
        button.backgroundColor = UIColor.white
        button.setTitleColor(normalColor, for: .normal)
        button.titleLabel?.font = fontSize14
        button.setImage(#imageLiteral(resourceName: "giftcategorydetail_arrow_down_gray"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "giftcategorydetail_arrow_up_gray"), for: .selected)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -93)
        return button
    }()
    
    lazy var centerLeftLine:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = SystemGlobalLineColor
        return view
    }()
    
    lazy var centerLine:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = SystemGlobalLineColor
        return view
    }()
    
    lazy var centerRightLine:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = SystemGlobalLineColor
        return view
    }()
    
    lazy var bottomLine:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = SystemGlobalLineColor
        return view
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if viewModel != nil {
            setupPopoverSortClassifyViewSubView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupPopoverSortClassifyViewSubView()
    }
//MARK: 私有方法
    private func setupPopoverSortClassifyView() {
        backgroundColor = UIColor.white
        
        addSubview(leftButton)
        addSubview(centerLeftButton)
        addSubview(centerRightButton)
        addSubview(rightButton)
        
        leftButton.addTarget(self, action: #selector(popoverButtonClick(button:)), for: .touchUpInside)
        centerLeftButton.addTarget(self, action: #selector(popoverButtonClick(button:)), for: .touchUpInside)
        centerRightButton.addTarget(self, action: #selector(popoverButtonClick(button:)), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(popoverButtonClick(button:)), for: .touchUpInside)
        
        addSubview(centerLeftLine)
        addSubview(centerRightLine)
        addSubview(centerLine)
        addSubview(bottomLine)
        
        let hideCoverViewPan = UITapGestureRecognizer(target: self, action: #selector(hidePopoverView))
        coverView.addGestureRecognizer(hideCoverViewPan)
        
        for i in 0..<buttonTitles!.count{
            if subviews[i].isKind(of: UIButton.self) {
                let button = subviews[i] as! UIButton
                if let title = buttonTitles?[i] {
                    button.setTitle(title, for: .normal)
                }
            }
        }
        
        for i in 0..<popoverTitles!.count {
            let view = createPopoverView(section: i, titles: popoverTitles![i])
            popoverViewCache["\(i)"] = view
        }
        
    }
    
    private func setupPopoverSortClassifyViewSubView() {
        leftButton.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(centerLeftButton)
        }
        
        centerLeftButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(centerLeftLine.snp.right)
            make.width.equalTo(centerRightButton)
        }
        
        centerRightButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(centerLine.snp.right)
            make.width.equalTo(rightButton)
        }
        
        rightButton.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(centerRightLine.snp.right)
        }
        
        centerLeftLine.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(leftButton.snp.right)
            make.size.equalTo(CGSize(width: 1.0, height: margin*2))
        }
        
        centerLine.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 1.0, height: margin*2))
            make.left.equalTo(centerLeftButton.snp.right)
        }
        
        centerRightLine.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 1.0, height: margin*2))
            make.left.equalTo(centerRightButton.snp.right)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
        
    }
    
    private func createPopoverView(section:Int,titles:Array<String>) -> UIView{
        let view = UIView()
        view.backgroundColor = SystemGlobalBackgroundColor
        var popoverViewHeight:CGFloat = 0.0
        
        for i in 0..<titles.count {
            let col = i % buttonColumn
            let row = i / buttonColumn
            let x = (buttonWidth + buttonMargin) * CGFloat(col) + buttonMargin
            let y = (buttonHeight + buttonMargin) * CGFloat(row) + buttonMargin
            
            let button = createButton(section: section, row: i, title: titles[i])
            button.frame = CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)
            view.addSubview(button)
            popoverViewHeight = button.frame.maxY + buttonMargin
        }
        
        view.frame = CGRect(x: 0, y: -popoverViewHeight, width: ScreenWidth, height: popoverViewHeight + buttonMargin*2)
        
        let pushView = UIView()
        pushView.frame = CGRect(x: 0, y: popoverViewHeight, width: view.bounds.width, height: buttonMargin*2)
        pushView.backgroundColor = UIColor.white
        view.addSubview(pushView)
        
        let lineView = UIView()
        lineView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 0.5)
        lineView.backgroundColor = LineViewColor
        pushView.addSubview(lineView)
        
        let pushImageView = UIImageView(image: #imageLiteral(resourceName: "giftcategorydetail_icon_fixed_nightmode"))
        pushImageView.frame.origin.x = (pushView.bounds.width - pushImageView.image!.size.width) * 0.5
        pushImageView.frame.origin.y = (pushView.bounds.height - pushImageView.image!.size.height) * 0.5
        pushView.addSubview(pushImageView)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(pushPopoverViewDragiing(gesture:)))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
        
        return view
    }
    
    private func createButton(section:Int ,row:Int,title:String) -> UIButton {
        let button = UIButton(type: .custom)
        
        button.setTitle(title, for: .normal)
        button.tag = section
        button.setBackgroundImage(UIImage.image(withColor: UIColor.white, withSize: CGSize(width: 1.0, height: 1.0)), for: .normal)
        button.setBackgroundImage(UIImage.image(withColor: SystemNavgationBarTintColor , withSize: CGSize(width: 1.0, height: 1.0)), for: .selected)
        button.setBackgroundImage(UIImage.image(withColor: UIColor.red , withSize: CGSize(width: 1.0, height: 1.0)), for: .highlighted)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.titleLabel?.font = fontSize14
        button.layer.masksToBounds = true
        button.layer.cornerRadius = margin*0.5
        button.layer.borderWidth = 0.5
        button.layer.borderColor = ButtonBorderColor.cgColor
        
        button.addTarget(self, action: #selector(popoverPadButtonClick(button:)), for: .touchUpInside)
        
        if row == 0 {
            button.isSelected = true
            popoverButtonCache["\(button.tag)"] = button
        }else {
            button.isSelected = false
        }
        
        return button
    }
    
    private func showPopoverView(button:UIButton) {
        button.isSelected = !button.isSelected
        
        if currentPopoverButton == button {
            hidePopoverView()
            return
        }
        
        if let oldButton = currentPopoverButton {
            oldButton.isSelected = !oldButton.isSelected
        }
        
        currentPopoverButton = button
       
        guard let view = popoverViewCache["\(button.tag)"] else {
            return
        }
        
        showCoverView(belowView: view)
        superview?.insertSubview(view, belowSubview: self)
        
        if isShowingPopoverCover {
            currentPopoverView!.removeFromSuperview()
            view.frame.origin.y = bounds.height
        }
        else {
            isShowingPopoverCover = true
            UIView.animate(withDuration: 0.3, animations: {
                view.frame.origin.y = self.bounds.height
            })
        }
        
        currentPopoverView = view
    }
    
    private func showCoverView(belowView view:UIView) {
        superview!.insertSubview(coverView, belowSubview: self)
    }
    
    private func hideCoverView() {
        coverView.removeFromSuperview()
    }
//MARK: 内部响应处理
    @objc private func pushPopoverViewDragiing(gesture:UIPanGestureRecognizer) {
        let view = popoverViewCache["\(currentPopoverButton!.tag)"]
        
        let maxCenterY = view!.frame.height * 0.5 + bounds.height
        
        switch gesture.state {
        case .began,.changed:
            if gesture.view!.center.y > maxCenterY {
                return
            }
            
            let translation = gesture.translation(in: self)
            
            if gesture.view!.center.y < maxCenterY {
                gesture.view!.center = CGPoint(x: gesture.view!.center.x, y: gesture.view!.center.y + translation.y)
            }
            else {
                gesture.view!.center = CGPoint(x: gesture.view!.center.x, y: maxCenterY - 0.0001)
            }
            
            gesture.setTranslation(CGPoint.zero, in: self)
            
        case .ended:
            if gesture.view!.center.y < maxCenterY * 0.5 {
                hideCoverView()
            }
            else {
                gesture.view!.center = CGPoint(x: gesture.view!.center.x, y: maxCenterY)
                
                gesture.setTranslation(CGPoint.zero, in: self)
            }
        default:
            print("")
        }
    }
    
    @objc private func popoverPadButtonClick(button:UIButton) {
        
        if let cacheButton = popoverButtonCache["\(button.tag)"] {
            cacheButton.isSelected = false
        }
        
        button.isSelected = true
        popoverButtonCache["\(button.tag)"] = button
    }
    
    @objc private func hidePopoverView() {
        guard let view = currentPopoverView else {
            return
        }
        
        isShowingPopoverCover = false
        currentPopoverButton = nil
        
        UIView.animate(withDuration: 0.3, animations: {
            view.frame.origin.y = -view.bounds.height
        }) { (_) in
            view.removeFromSuperview()
        }
        
        hideCoverView()
    }
    
    @objc private func popoverButtonClick(button:UIButton) {
        showPopoverView(button: button)
    }
}
