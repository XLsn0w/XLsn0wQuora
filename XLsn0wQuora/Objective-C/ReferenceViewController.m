//
//  ReferenceViewController.m
//  XLsn0wApplication
//
//  Created by XLsn0w on 2017/6/1.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

#import "ReferenceViewController.h"
#import "RetainCount.h"

@interface ReferenceViewController ()

@end

@implementation ReferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *view = [UIView new];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:view.center];    //一定要设置 不然底层的CGPathRef找不到起始点，将会崩溃
    [path addCurveToPoint:CGPointMake(270, 410) controlPoint1:CGPointMake(0, 300) controlPoint2:CGPointMake(300, 0)];    //以左下角和右上角为控制点
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.duration = 3.0f;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.values = @[];
    
    [view.layer addAnimation:animation forKey:nil];
    
    
            //变量           //对象
    RetainCount *retainCount = [[RetainCount alloc] init];
//    通过[RetainCount alloc]创建了一个对象，
//    变量retainCount是一个对象的引用（存储了对象的地址）
    //在ObjC中每个对象内部都有一个与之对应的整数（retainCount），叫“引用计数器”
//    当调用这个对象的alloc、new, retain/copy方法之后引用计数器自动在原来的基础上加1（ObjC中调用一个对象的方法就是给这个对象发送一个消息），
//    当调用这个对象的release方法之后它的引用计数器减1，如果一个对象的引用计数器为0，则系统会自动调用这个对象的dealloc方法来销毁这个对象。
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
