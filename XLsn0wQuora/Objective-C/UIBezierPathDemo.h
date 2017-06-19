//
//  UIBezierPathDemo.h
//  XLsn0wQuora
//
//  Created by XLsn0w on 2017/6/19.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//
#define kDefaultFrame CGRectMake(100, 100, 100, 100)
/** 9==100-82/2 */
#define kRoundFrame CGRectMake(100+9, 100+9, 82, 82)
#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size

#import <UIKit/UIKit.h>

@interface UIBezierPathDemo : UIView

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) CAShapeLayer *layer;
@property (nonatomic, assign, getter=isCompleteAnimation) BOOL completeAnimation;

@end
