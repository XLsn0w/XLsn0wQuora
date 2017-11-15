

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>


@interface CAEmitterLayer (Animations)

/**
 雪花散落效果
 @parma position 发射位置
 @parma size 发射源的大小
 */
+ (CAEmitterLayer *)snowEmitterPosition:(CGPoint)position emitterSize:(CGSize)size;

/**
 心乱飞效果
 */
+ (CAEmitterLayer *)heartsEmitterPosition:(CGPoint)position emitterSize:(CGSize)size;

/**
 烟花效果
 */
+ (CAEmitterLayer *)fireworksEmitterPosition:(CGPoint)position emitterSize:(CGSize)size;
@end
