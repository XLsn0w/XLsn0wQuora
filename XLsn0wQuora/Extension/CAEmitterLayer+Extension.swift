//
//  CAEmitterLayer+Extension.swift
//  XLsn0wQuora
//
//  Created by golong on 2017/11/14.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

import UIKit
import Foundation

extension CAEmitterLayer {
    
    ///心花怒放
    class func initAtPosition(position:CGPoint, size:CGSize) -> CAEmitterLayer {
        let heartsEmitter:CAEmitterLayer = CAEmitterLayer();

        heartsEmitter.emitterPosition = position;
        heartsEmitter.emitterSize = size;
        
        heartsEmitter.emitterMode = kCAEmitterLayerOutline;
        heartsEmitter.emitterShape = kCAEmitterLayerCircle;
        heartsEmitter.renderMode = kCAEmitterLayerAdditive;
        
        let heart = CAEmitterCell()
        heart.name = "heart";
        heart.emissionLongitude = CGFloat(Double.pi/2.0);
        heart.emissionRange = CGFloat(0.55 * Double.pi);
        heart.birthRate = 0.0;
        heart.lifetime = Float(10.0);
        heart.velocity = -120;
        heart.yAcceleration = 20;
        heart.contents = UIImage(named: "DazHeart")?.cgImage
        heart.color = UIColor.red.cgColor
        heart.redRange = 0.3;
        heart.blueRange = 0.3;
        heart.alphaSpeed = Float(-0.5 / heart.lifetime);
        heart.scale = 0.15;
        heart.scaleSpeed = 0.5;
        heart.spinRange = CGFloat(2.0 * Double.pi);
        
        heartsEmitter.emitterCells = [heart];
        
        return heartsEmitter;
    }
    
    class func init_sn0wAtPosition(position:CGPoint, size:CGSize) -> CAEmitterLayer {
        let snowEmitter:CAEmitterLayer = CAEmitterLayer();
        //发射位置
        snowEmitter.emitterPosition = position;
        //发射源的大小
        snowEmitter.emitterSize = size;
        //发射模式
        snowEmitter.emitterMode = kCAEmitterLayerOutline;
        //发射源的形状
        snowEmitter.emitterShape = kCAEmitterLayerLine;
        
        // 装着CAEmitterCell对象的数组，被用于把粒子投放到layer上

        let snowflake = CAEmitterCell()
        //粒子产生系数，默认1.0
        snowflake.birthRate = 1.0;
        //粒子生命周期
        snowflake.lifetime  = 120.0;
        //粒子速度
        snowflake.velocity = -10;
        //速度范围
        snowflake.velocityRange = 10;
        //粒子y方向的加速度分量
        snowflake.yAcceleration = 2;
        //周围发射角度
        snowflake.emissionRange = CGFloat(0.5 * Double.pi);
        //子旋转角度范围
        snowflake.spinRange = CGFloat(0.25 * Double.pi);
        //是个CGImageRef的对象,既粒子要展现的图片
        snowflake.contents = UIImage(named: "DazFlake")?.cgImage
        //
        snowflake.color = UIColor.colorWithHexString_alpha(alpha: 0.5, color: "#F8F8FF").cgColor;
        //阴影透明度，默认0
        snowEmitter.shadowOpacity = 1.0;
        //阴影半径，默认3
        snowEmitter.shadowRadius = 0.0;
        //shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        snowEmitter.shadowOffset = CGSize(width: 0.0, height: 1.0);
        //shadowColor阴影颜色
        snowEmitter.shadowColor = UIColor.colorWithHexString_alpha(alpha: 0.5, color: "#DCDCDC").cgColor
        snowEmitter.emitterCells = [snowflake];
        
        return snowEmitter;
        
    }

}
