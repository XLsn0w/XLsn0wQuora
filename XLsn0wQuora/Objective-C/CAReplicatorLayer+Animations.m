
#import "CAReplicatorLayer+Animations.h"

@implementation CAReplicatorLayer (Animations)
+(CAReplicatorLayer *)indicatorAnimation:(NSUInteger)dotsNum Duration:(CFTimeInterval)duration Color:(UIColor *)color Size:(CGRect)size{
    
    //  背景 layer
    CAReplicatorLayer *replayer = [CAReplicatorLayer layer];
    replayer.frame = size;
    replayer.cornerRadius = 10;
    replayer.backgroundColor= [UIColor colorWithWhite:0 alpha:0.75].CGColor;
    
    //  单个小方块 （原始层）
    CAShapeLayer *dotlayer = [CAShapeLayer layer];
    
    UIBezierPath *dotPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 14, 14) cornerRadius:2];
    dotlayer.path = dotPath.CGPath;
    dotlayer.position = CGPointMake(replayer.bounds.size.width/2,replayer.bounds.size.height/5);
    dotlayer.fillColor =  color.CGColor;
    [replayer addSublayer:dotlayer];
    
     //  1、设置 拷贝份数、旋转
    CGFloat angle = 2 * M_PI /dotsNum;
    
    replayer.instanceCount = dotsNum;
    replayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    
    //  2、设置了 动画后, 每个点 会同时 执行 变大变小
    CABasicAnimation * shrinkAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    shrinkAnimation.fromValue = @(1.0);
    shrinkAnimation.toValue = @(0.1);
    shrinkAnimation.duration = duration;
    shrinkAnimation.repeatCount = INFINITY;
    //    shrinkAnimation.autoreverses = YES;     //    TODO: 打开这行,看看效果
    [dotlayer addAnimation:shrinkAnimation forKey:nil];
    
    //  3、设置 每个点的 延时 （会逐个自动添加上）
    replayer.instanceDelay = duration / dotsNum;    // TODO: 注释掉试试
    
    dotlayer.transform = CATransform3DMakeTranslation(0.01, 0.01, 0.01);
    
    return replayer;
    
}

+(CAReplicatorLayer *)barAnimation:(NSUInteger)barsNum Duration:(CFTimeInterval)duration Color:(UIColor *)color Size:(CGRect)size{

    //  背景 layer
    CAReplicatorLayer * repLayer = [[CAReplicatorLayer alloc] init];
    repLayer.frame = size;
    repLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    
    //  1、单条 柱形  (原始层)

    UIBezierPath *barPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 8, repLayer.bounds.size.height*0.8) cornerRadius:0];
    
    CAShapeLayer *barlayer = [CAShapeLayer layer];
    barlayer.path = barPath.CGPath;
    barlayer.position =CGPointMake(10, 55);
    barlayer.fillColor = color.CGColor;
    //  加在 replicator layer 上的 layer 可以复制
    [repLayer addSublayer:barlayer];
    
    CABasicAnimation * moveAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    moveAnimation.toValue = @(barlayer.position.y - 35);
    moveAnimation.duration = duration;
    moveAnimation.autoreverses = YES;
    moveAnimation.repeatCount = INFINITY;
    [barlayer addAnimation:moveAnimation forKey:@"moveAnimation"];
    
    //   1、设置 replicator 拷贝 为 3份(包括原来的)
    //      拷贝默认 会出现在相同的位置
    repLayer.instanceCount = barsNum;
    
    //  2、设置每个 拷贝的 位移 (x 上 右移20)
    //      会同时移动
    repLayer.instanceTransform = CATransform3DMakeTranslation(20, 0, 0);
    
    //  3、设置 延迟
    repLayer.instanceDelay = 0.33;
    
    //  超出边界的不显示
    repLayer.masksToBounds = YES;
    
    return repLayer;
}
@end
