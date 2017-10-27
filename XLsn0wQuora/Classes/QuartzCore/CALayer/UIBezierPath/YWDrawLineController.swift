//
//  YWDrawLineController.swift
//  exampleForAnimation
//
//  Created by 姚巍 on 16/12/19.
//  Copyright © 2016年 姚巍. All rights reserved.
//  划线动画

import UIKit

class YWDrawLineController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
     
        
        
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.purple.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineCapRound
        
      
        ///UIBezierPath
        let bezierPath = UIBezierPath(ovalIn: CGRect(x: 100, y: 100, width: 250, height: 500))
        shapeLayer.path = bezierPath.cgPath//CAShapeLayer 有一个神奇的属性 path 用这个属性配合上 UIBezierPath 这个类就可以达到超神的效果
        
        self.view.layer.addSublayer(shapeLayer)
        
        let pathAnim = CABasicAnimation(keyPath: "strokeEnd")
        pathAnim.duration = 5.0
        pathAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pathAnim.fromValue = 0
        pathAnim.toValue = 1
        pathAnim.autoreverses = true
        pathAnim.fillMode = kCAFillModeForwards
//        pathAnim.isRemovedOnCompletion = false
        pathAnim.repeatCount = Float.infinity
        shapeLayer.add(pathAnim, forKey: "strokeEndAnim")
     
    }

}
