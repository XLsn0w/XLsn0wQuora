//
//  PopoverClassifyView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/15.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class PopoverClassifyView: UIView {

//MARK: 属性
    var popoverView:UIView?
    var isShowPopoverView = false
    //: 水平滚动选中按钮
    var selectedScrollButton:UIButton?
    //: 弹出按钮选中按钮
    var selectedPopoverButton:UIButton?
    
    weak var delegate:PopoverClassifyViewDelegate?
    
    var titles:Array<String>? {
        didSet {
            createClassify(titles: titles!)
            popoverView = createPopoverView(titles: titles!)
        }
    }
//MARK: 懒加载
    //: 缓存滚动按钮
    lazy var cacheScrollButtons = Array<UIButton>()
    //: 缓存弹出按钮
    lazy var cachePopoverButtons = Array<UIButton>()
    
    lazy var coverView:UIView = { () -> UIView in
       let view = UIView()
        view.backgroundColor = UIColor.white
        view.isHidden = true
        return view
    }()
    
    lazy var scrollView:UIScrollView = { () -> UIScrollView in
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    lazy var titleLabel:UILabel = { () -> UILabel in
       let label = UILabel()
        label.text = "切换选项"
        label.font = labelFont
        label.textColor = labelTextColor
        return label
    }()
    
    lazy var button:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "giftcategorydetail_arrow_down_gray"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "giftcategorydetail_arrow_up_gray"), for: .selected)
        
        button.addTarget(self, action: #selector(showPopoverViewButtonClick(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var scrollLine:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = SystemNavgationBackgroundColor
        return view
    }()
    
    lazy var ButtonLine:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = SystemNavgationBackgroundColor
        return view
    }()
    
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPopoverClassifySubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        button.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(44)
        }
        scrollView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(button.snp.left)
        }
        
        coverView.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalTo(scrollView)
            
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
        }
        
        setupScrollViewPosition()
    }
//MARK: 私有方法
    private func  setupPopoverClassifySubView() {
        addSubview(button)
        addSubview(scrollView)
        
        scrollView.addSubview(scrollLine)
        

        addSubview(coverView)
        coverView.addSubview(titleLabel)
        
        let hideCoverViewPan = UITapGestureRecognizer(target: self, action: #selector(hidePopoverView))
        
        coverView.addGestureRecognizer(hideCoverViewPan)
        
    }
    
    private func setupScrollViewPosition() {
       
        if let last = cacheScrollButtons.last {
            //: 改变ScrollView 的滚动区域大小
            scrollView.contentSize = CGSize(width: last.frame.maxX, height: 0)
        }
        
        if let selected = selectedScrollButton {
            scrollLine.center = CGPoint(x: selected.center.x, y: bounds.height - scrollLineHeight)
            scrollLine.bounds = CGRect(origin: .zero, size: CGSize(width: selected.bounds.width - scrollLineMargin, height: scrollLineHeight))
        }
        
    }
    private func createPopoverView(titles: Array<String>) -> UIView{
        let view = UIView()
        
        view.backgroundColor = UIColor.white
        
        for i in 0..<titles.count {
            let col = i % popoverButtonNum
            let row = i / popoverButtonNum
            let x = popoverButtonWidth * CGFloat(col)
            let y = popoverButtonHeight * CGFloat(row)
            
            let button = createTitleButton(title: titles[i], tag: i)
            
            view.addSubview(button)
            button.frame = CGRect(x: x, y: y, width: popoverButtonWidth, height: popoverButtonHeight)
            button.addTarget(self, action: #selector(popoverViewButtonClick(button:)), for: .touchUpInside)
            
            cachePopoverButtons.append(button)
            
            button.addSubview(boderLine(frame: CGRect(x: button.bounds.width - popoverButtonBoderWidth, y: 0, width: popoverButtonBoderWidth, height: button.bounds.height)))
            
            button.addSubview(boderLine(frame: CGRect(x: 0, y: button.bounds.height - popoverButtonBoderWidth, width: button.bounds.width, height: popoverButtonBoderWidth)))
            
            if i == 0 {
                popoverViewButtonClick(button: button)
            }
        }
        view.addSubview(ButtonLine)
        view.frame = CGRect(x: 0, y: -cachePopoverButtons.last!.frame.maxY, width: ScreenWidth, height: cachePopoverButtons.last!.frame.maxY)
        
        return view
    }
    
    private func boderLine(frame:CGRect) -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = SystemGlobalLineColor
        return view
    }
    
    private func createClassify(titles:Array<String>) {
        
        for i in 0..<titles.count {
            let title = titles[i]
            let button = createTitleButton(title: title,tag: i)
        
            let width:CGFloat = title.stringWidth(withFont: button.titleLabel!.font) + scrollLineMargin * 2
            let x:CGFloat = cacheScrollButtons.last == nil ? scrollButtonMargin : cacheScrollButtons.last!.frame.maxX
            
            button.frame = CGRect(x: x, y: 0, width: width, height: 44.0)
            
            button.addTarget(self, action: #selector(scrollButtonClick(button:)), for: .touchUpInside)
            
            scrollView.addSubview(button)
            
            //: 缓存按钮
            cacheScrollButtons.append(button)
            
            if i == 0 {
                scrollButtonClick(button: button)
            }
        }
    }
    
    private func createTitleButton(title:String,tag:Int) -> UIButton{
        let button = UIButton(type: .custom)
        
        button.tag = tag
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = labelFont
        
        button.setTitleColor(normalColor, for: .normal)
        button.setTitleColor(selectedColor, for: .selected)
        
        return button
    }
    
    private func hideCoverView() {
        coverView.isHidden = true
    }
    
    private func showCoverView() {
        coverView.isHidden = false
    
    }
    
    private func showPopoverView() {
        backgroundColor = coverView.backgroundColor
        button.isSelected = true
        
        //: 显示选中分类
        popoverViewButtonClick(button: cachePopoverButtons[selectedScrollButton!.tag])
        
        showCoverView()
        
        superview!.insertSubview(popoverView!, belowSubview: self)
        coverView.alpha = 0.0
        isShowPopoverView = true
        
        UIView.animate(withDuration: 0.3) {
            self.coverView.alpha = 1.0
            self.popoverView!.frame.origin.y = self.bounds.height
        }
    }
//MARK: 内部响应处理
    @objc private func scrollButtonClick(button:UIButton) {
        
        if let selected = selectedScrollButton {
            selected.isSelected = false
        }
        
        button.isSelected = true
        selectedScrollButton = button
        
        if button.center.x < bounds.width * 0.5 {
            scrollView.setContentOffset(CGPoint.zero, animated: true)
        }
        //: 滚动按钮居中
        else if (scrollView.contentSize.width > bounds.width)
        && (button.center.x > bounds.width * 0.5)
            && (button.center.x < (scrollView.contentSize.width - bounds.width * 0.5)) {
            
             scrollView.setContentOffset(CGPoint(x: button.frame.origin.x + button.bounds.width * 0.5 - bounds.width * 0.5, y: 0), animated: true)
        }else{
            
            scrollView.setContentOffset(CGPoint(x: (scrollView.contentSize.width - scrollView.bounds.size.width), y: 0), animated: true)
        }
        
        setNeedsLayout()
        //: 调用代理
        delegate?.popoverSrcollViewSelectedClassifyEndIndex(index: button.tag)
    }
    
    @objc private func hidePopoverView() {
        //: 判断是否存在popoverView
        guard let _ = popoverView else {
            return
        }
        
        backgroundColor = UIColor.white
        button.isSelected = false
        hideCoverView()
        
        //: 选中按钮
        scrollButtonClick(button: cacheScrollButtons[selectedPopoverButton!.tag])
        //: 动画
        UIView.animate(withDuration: 0.3, animations: {
            self.popoverView!.frame.origin.y = -self.popoverView!.bounds.height
            self.coverView.alpha = 0.0
        }) { (_) in
            self.popoverView!.removeFromSuperview()
            self.isShowPopoverView = false
        }
        
       
    }
    
    @objc private func popoverViewButtonClick(button:UIButton) {
        if let selected = selectedPopoverButton {
            selected.isSelected = false
        }
        
        button.isSelected = true
        selectedPopoverButton = button
        
        ButtonLine.frame = CGRect(x: button.frame.origin.x, y: button.frame.maxY, width: button.frame.width, height: popoverButtonLineHeight)

        
        if isShowPopoverView {
            hidePopoverView()
        }
    }
    
    //: 点击弹出popoverView
    @objc private func showPopoverViewButtonClick(button:UIButton) {
        
        if !button.isSelected {
            showPopoverView()
        }else{
            hidePopoverView()
        }
    }
//:  外部接口
    //: 外部联动选择
    func scrollButtonSelected(index :Int) {
        scrollButtonClick(button: cacheScrollButtons[index])
    }
}

//MARK: 协议
protocol PopoverClassifyViewDelegate:NSObjectProtocol {
    func popoverSrcollViewSelectedClassifyEndIndex(index:Int) -> Void
}
