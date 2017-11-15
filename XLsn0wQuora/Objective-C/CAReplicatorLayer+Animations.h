
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface CAReplicatorLayer (Animations)
/**
 基于CAReplicatorLayer－点加载动画
 @parma dotsNum 点个数
 */
+(CAReplicatorLayer *)indicatorAnimation:(NSUInteger)dotsNum Duration:(CFTimeInterval) duration Color:(UIColor *)color Size:(CGRect)size;

/**
 基于CAReplicatorLayer－柱形动画
 */
+(CAReplicatorLayer *)barAnimation:(NSUInteger)barsNum Duration:(CFTimeInterval) duration Color:(UIColor *)color Size:(CGRect)size;

@end

/*
 
 -(void)barAnimation{
 
 CAReplicatorLayer *replayer = [CAReplicatorLayer barAnimation:5 Duration:0.5 Color:[UIColor redColor] Size: CGRectMake(150, 40, 60, 60)];
 
 [self.view.layer addSublayer:replayer];
 }
 
 -(void)indicatorAnimation{
 
 CAReplicatorLayer *replayer = [CAReplicatorLayer indicatorAnimation:15 Duration:1.5 Color:[UIColor redColor] Size:CGRectMake(80, 130, 200, 200)];
 
 [self.view.layer addSublayer:replayer];
 }
 
 -(void)snow{
 //雪花
 CAEmitterLayer *snowEmitter = [CAEmitterLayer snowEmitterPosition:CGPointMake(self.view.bounds.size.width/2, -30) emitterSize:CGSizeMake(self.view.bounds.size.width*2, 0.0)];
 
 [self.view.layer insertSublayer:snowEmitter atIndex:0];
 
 }
 
 -(void)heart{
 
 //爱心
 CAEmitterLayer *heartEmitter = [CAEmitterLayer heartsEmitterPosition:CGPointMake(200, 200) emitterSize:CGSizeMake(30, 30)];
 [self.view.layer addSublayer:heartEmitter];
 
 CABasicAnimation *heartsBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.heart.birthRate"];
 heartsBurst.fromValue = [NSNumber numberWithFloat:150];
 heartsBurst.toValue = [NSNumber numberWithFloat: 0.0];
 heartsBurst.duration = 10.0;
 heartsBurst.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
 [heartEmitter addAnimation:heartsBurst forKey:@"heartsBurst"];
 
 }
 
 
 -(void)fireWorks{
 //烟火
 CGRect viewBounds = self.view.layer.bounds;
 CAEmitterLayer *fireworksEmitter = [CAEmitterLayer fireworksEmitterPosition:CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height) emitterSize:CGSizeMake(viewBounds.size.width/2.0, 0.0)];
 
 [self.view.layer addSublayer:fireworksEmitter];
 
 }
 
 */
