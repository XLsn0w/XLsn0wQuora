//
//  MenuView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/5/1.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

public enum MenuItemType : Int {
    
    case copy
    
    case transmit
    
    case collect
    
    case delete
    
    case cancel
    
}

public enum MenuType : Int {
    
    case normal
    
    case custom
    
}

class MenuView: UIView {

//MARK: 单例
    static let shared = MenuView()
    
    var isShow:Bool = false
    
    var finshed:((_ itemType:MenuItemType)->())?
//MARK: 懒加载
    lazy var menuControl:UIMenuController = { () -> UIMenuController in
        let control = UIMenuController()
        
        return control
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMenuView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: 私有方法
    private func setupMenuView() {
        backgroundColor = UIColor.clear
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissMenuView))
        addGestureRecognizer(tap)
    }
    
    private func setMenuItem(type:MenuType) {
        if type == .custom {
            let copy = UIMenuItem(title: "复制", action: #selector(copyItemSelect))
            let transmit = UIMenuItem(title: "转发", action: #selector(transmitItemSelect))
            let collect = UIMenuItem(title: "收藏", action: #selector(collectItemSelect))
            let delete = UIMenuItem(title: "删除", action: #selector(deleteItemSelect))
            
            menuControl.menuItems = [copy, transmit, collect, delete]
        }
    }
    
    private func clickMenuItem(type:MenuItemType) {
        isShow = false
        removeFromSuperview()
        
        guard let finshed = self.finshed else {
            return
        }
        
        finshed(type)
    }
//MARK: 内部处理
    @objc private func dismissMenuView() {
       isShow = false
       
        if let finshed = self.finshed {
            finshed(.cancel)
        }
        
        menuControl.setMenuVisible(false, animated: true)
        removeFromSuperview()
    }
    
    @objc private func copyItemSelect() {
         clickMenuItem(type: .copy)
    }
    
    @objc private func transmitItemSelect() {
         clickMenuItem(type: .transmit)
    }
    
    @objc private func collectItemSelect() {
         clickMenuItem(type: .collect)
    }
    
    @objc private func deleteItemSelect() {
         clickMenuItem(type: .delete)
    }
//MARK: 外部接口
    func show(InView view:UIView,Type type:MenuType,Frame frame:CGRect,finshed:@escaping (_ itemType:MenuItemType)->()) {
        if isShow {
            return
        }
        
        self.frame = view.bounds
        self.finshed = finshed
        setMenuItem(type: type)
        menuControl.setTargetRect(frame, in: self)
        becomeFirstResponder()
        menuControl.setMenuVisible(true, animated: true)
    }
}
