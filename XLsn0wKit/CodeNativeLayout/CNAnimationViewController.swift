//
//  CNAnimationViewController.swift
//  AutoLayoutDemo
//
//  Created by 董知樾 on 2017/3/28.
//  Copyright © 2017年 董知樾. All rights reserved.
//

import UIKit

class CNAnimationViewController: UIViewController {

    ///位移
    let moveView = UIView()
    ///放大缩小
    let stretchView = UIView()
    
    var moveStep = 0
    var stretchScale = 0
    var stretchViewWidth : NSLayoutConstraint!
    var stretchViewHeight : NSLayoutConstraint!
    var moveViewTop : NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "原生代码-动画"
        view.backgroundColor = .white
        
        stretchView.backgroundColor = UIColor.hexValue(0xfd84ea)
        view.addSubview(stretchView)
        
        stretchView.translatesAutoresizingMaskIntoConstraints = false
        let stretchViewCenterX = NSLayoutConstraint(item: stretchView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let stretchViewCenterY = NSLayoutConstraint(item: stretchView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        stretchViewWidth = NSLayoutConstraint(item: stretchView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 90)
        stretchViewHeight = NSLayoutConstraint(item: stretchView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 90)
        let stretchViewTop = NSLayoutConstraint(item: stretchView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let stretchViewBottom = NSLayoutConstraint(item: stretchView, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let stretchViewLeading = NSLayoutConstraint(item: stretchView, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: view.layoutMarginsGuide, attribute: .leading, multiplier: 1, constant: 0)
        let stretchViewTrailing = NSLayoutConstraint(item: stretchView, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: view.layoutMarginsGuide, attribute: .trailing, multiplier: 1, constant: 0)
        //w和h的约束与top、bottom、leading、trailing的不等约束存在潜在冲突，所以要调低w和h的优先级
        stretchViewWidth.priority = UILayoutPriorityDefaultHigh
        stretchViewHeight.priority = UILayoutPriorityDefaultHigh
        NSLayoutConstraint.activate([stretchViewCenterX,stretchViewCenterY,stretchViewWidth,stretchViewHeight,stretchViewTop,stretchViewBottom,stretchViewLeading,stretchViewTrailing])
        
        moveView.backgroundColor = UIColor.hexValue(0x40a0ff)
        view.addSubview(moveView)
        
        moveView.translatesAutoresizingMaskIntoConstraints = false
        moveViewTop = NSLayoutConstraint(item: moveView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 10)
        let moveViewLeading = NSLayoutConstraint(item: moveView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 10)
        let moveViewWidth = NSLayoutConstraint(item: moveView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 90)
        let moveViewHeight = NSLayoutConstraint(item: moveView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 90)
        let moveViewBottom = NSLayoutConstraint(item: moveView, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        moveViewTop.priority = UILayoutPriorityDefaultHigh
        NSLayoutConstraint.activate([moveViewTop,moveViewLeading,moveViewWidth,moveViewHeight,moveViewBottom])
        
        let moveButton = UIButton(type: .custom)
        moveButton.backgroundColor = UIColor.hexValue(0x40a0ff)
        moveButton.layer.cornerRadius = 4
        moveButton.layer.masksToBounds = true
        moveButton.setTitle("move 移动", for: .normal)
        moveButton.setTitleColor(.white, for: .normal)
        view.addSubview(moveButton)
        moveButton.addTarget(self, action: #selector(didClickMoveButton(button:)), for: .touchUpInside)
        
        moveButton.translatesAutoresizingMaskIntoConstraints = false
        let moveButtonLeading = NSLayoutConstraint(item: moveButton, attribute: .leading, relatedBy: .equal, toItem: view.layoutMarginsGuide, attribute: .leading, multiplier: 1, constant: 0)
        let moveButtonBottom = NSLayoutConstraint(item: moveButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -10)
        let moveButtonHeight = NSLayoutConstraint(item: moveButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44)
        NSLayoutConstraint.activate([moveButtonLeading,moveButtonBottom,moveButtonHeight])
        
        let stretchButton = UIButton(type: .custom)
        stretchButton.backgroundColor = UIColor.hexValue(0xfd84ea)
        stretchButton.layer.cornerRadius = 4
        stretchButton.layer.masksToBounds = true
        stretchButton.setTitle("stretch", for: .normal)
        stretchButton.setTitleColor(.white, for: .normal)
        view.addSubview(stretchButton)
        stretchButton.addTarget(self, action: #selector(didClickStretchButton(button:)), for: .touchUpInside)
        
        stretchButton.translatesAutoresizingMaskIntoConstraints = false
        let stretchButtonLeading = NSLayoutConstraint(item: stretchButton, attribute: .leading, relatedBy: .equal, toItem: moveButton, attribute: .trailing, multiplier: 1, constant: 10)
        let stretchButtonTrailing = NSLayoutConstraint(item: stretchButton, attribute: .trailing, relatedBy: .equal, toItem: view.layoutMarginsGuide, attribute: .trailing, multiplier: 1, constant: 0)
        let stretchButtonBottom = NSLayoutConstraint(item: stretchButton, attribute: .bottom, relatedBy: .equal, toItem: moveButton, attribute: .bottom, multiplier: 1, constant: 0)
        let stretchButtonWidth = NSLayoutConstraint(item: stretchButton, attribute: .width, relatedBy: .equal, toItem: moveButton, attribute: .width, multiplier: 1, constant: 0)
        let stretchButtonHeight = NSLayoutConstraint(item: stretchButton, attribute: .height, relatedBy: .equal, toItem: moveButton, attribute: .height, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([stretchButtonLeading,stretchButtonTrailing,stretchButtonBottom,stretchButtonWidth,stretchButtonHeight])
        
        ///NSLayoutConstraint代码量巨大，看起来也不清晰，阅读难度大，维护成本高，缺点很明显，使用原生的NSLayoutConstraint来做布局的话，做一些封装才好
    }
    
    func didClickMoveButton(button : UIButton) -> Void {
        
        button.isEnabled = false
        self.moveStep += 1
        view.setNeedsUpdateConstraints()
        view.updateConstraintsIfNeeded()
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
        }) { (comp) in
            button.isEnabled = true
        }
        
    }
    
    func didClickStretchButton(button : UIButton) -> Void {
        button.isEnabled = false
        self.stretchScale += 1
        view.setNeedsUpdateConstraints()
        view.updateConstraintsIfNeeded()
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
        }) { (comp) in
            button.isEnabled = true
        }
    }
    
    override func updateViewConstraints() {
        
        moveViewTop.constant = CGFloat(10 + moveStep * 100)
        
        stretchViewHeight.constant = CGFloat(90 + 100 * stretchScale)
        stretchViewWidth.constant = CGFloat(90 + 100 * stretchScale)
        
        super.updateViewConstraints()
    }

    

}
