//
//  SKAnimationViewController.swift
//  AutoLayoutDemo
//
//  Created by 董知樾 on 2017/3/28.
//  Copyright © 2017年 董知樾. All rights reserved.
//

import UIKit

class SKAnimationViewController: UIViewController {
    
    ///位移
    let moveView = UIView()
    ///放大缩小
    let stretchView = UIView()
    
    var moveStep = 0
    var stretchScale = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "SnapKit动画"
        view.backgroundColor = .white

        stretchView.backgroundColor = UIColor.hexValue(0xfd84ea)
        view.addSubview(stretchView)
        stretchView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 90, height: 90)).priority(.high)
            make.center.equalTo(view)
            make.size.lessThanOrEqualTo(view.layoutMarginsGuide)
        }
        
        moveView.backgroundColor = UIColor.hexValue(0x40a0ff)
        view.addSubview(moveView)
        moveView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(10).priority(.high)
            make.leading.equalTo(10)
            make.size.equalTo(CGSize(width: 90, height: 90))
            make.bottom.lessThanOrEqualTo(view.snp.bottom)
        }
        
        
        let moveButton = UIButton(type: .custom)
        moveButton.backgroundColor = UIColor.hexValue(0x40a0ff)
        moveButton.layer.cornerRadius = 4
        moveButton.layer.masksToBounds = true
        moveButton.setTitle("move 移动", for: .normal)
        moveButton.setTitleColor(.white, for: .normal)
        view.addSubview(moveButton)
        moveButton.snp.makeConstraints { (make) in
            make.leading.equalTo(view.layoutMarginsGuide)
            make.bottom.equalTo(-10)
            make.height.equalTo(44)
        }
        moveButton.addTarget(self, action: #selector(didClickMoveButton(button:)), for: .touchUpInside)
        
        let stretchButton = UIButton(type: .custom)
        stretchButton.backgroundColor = UIColor.hexValue(0xfd84ea)
        stretchButton.layer.cornerRadius = 4
        stretchButton.layer.masksToBounds = true
        stretchButton.setTitle("stretch", for: .normal)
        stretchButton.setTitleColor(.white, for: .normal)
        view.addSubview(stretchButton)
        stretchButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(view.layoutMarginsGuide)
            make.height.width.bottom.equalTo(moveButton)
            make.leading.equalTo(moveButton.snp.trailing).offset(10)
        }
        stretchButton.addTarget(self, action: #selector(didClickStretchButton(button:)), for: .touchUpInside)
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
        ///view.setNeedsUpdateConstraints() 告诉self.view约束需要更新
        ///view.updateConstraintsIfNeeded() 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
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
    
    ///官方推荐在updateViewConstraints方法中更新或者添加约束
    override func updateViewConstraints() {
        moveView.snp.updateConstraints { (make) in
            make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(10 + moveStep * 100).priority(.high)
        }
        stretchView.snp.updateConstraints { (make) in
            make.size.equalTo(CGSize(width: 90 + 100 * stretchScale, height: 90 + 100 * stretchScale)).priority(.high)
        }
        super.updateViewConstraints()
    }

}
