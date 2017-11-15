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
    
    class func initAtPosition(position:CGPoint, size:CGSize) -> CAEmitterLayer {
        let heartsEmitter:CAEmitterLayer = CAEmitterLayer();
        //发射位置
        heartsEmitter.emitterPosition = position;
        //发射源的大小
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

}

/*
+(CAEmitterLayer *)heartsEmitterPosition:(CGPoint)position emitterSize:(CGSize)size{
    CAEmitterLayer *heartsEmitterPosition = [CAEmitterLayer layer];
    //发射位置
    heartsEmitter.emitterPosition = position;
    //发射源的大小
    heartsEmitter.emitterSize = size;
    heartsEmitter.emitterMode = kCAEmitterLayerOutline;
    heartsEmitter.emitterShape = kCAEmitterLayerCircle;
    heartsEmitter.renderMode = kCAEmitterLayerAdditive;
    
    CAEmitterCell *heart = [CAEmitterCell emitterCell];
    heart.name = @"heart";
    heart.emissionLongitude = M_PI/2.0;
    heart.emissionRange = 0.55 * M_PI;
    heart.birthRate = 0.0;
    heart.lifetime =10.0;
    heart.velocity = -120;
    heart.yAcceleration =20;
    heart.contents = (id)[UIImage imageNamed:@"DazHeart"].CGImage;
    heart.color =[[UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:0.5] CGColor];
    heart.redRange = 0.3;
    heart.blueRange = 0.3;
    heart.alphaSpeed = -0.5 /heart.lifetime;
    heart.scale = 0.15;
    heart.scaleSpeed = 0.5;
    heart.spinRange = 2.0 *M_PI;
    
    heartsEmitter.emitterCells = [NSArray arrayWithObject:heart];
    
    return heartsEmitter;
}
*/
