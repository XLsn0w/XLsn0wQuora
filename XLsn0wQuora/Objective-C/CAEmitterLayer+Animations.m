
/**
 
 emitterPosition:发射位置
 
 emitterSize:发射源的大小；
 
 emitterMode:发射模式
 NSString * const kCAEmitterLayerPoints;
 NSString * const kCAEmitterLayerOutline;
 NSString * const kCAEmitterLayerSurface;
 NSString * const kCAEmitterLayerVolume;
 复制代码
 emitterShape:发射源的形状：
 NSString * const kCAEmitterLayerPoint;
 NSString * const kCAEmitterLayerLine;
 NSString * const kCAEmitterLayerRectangle;
 NSString * const kCAEmitterLayerCuboid;
 NSString * const kCAEmitterLayerCircle;
 NSString * const kCAEmitterLayerSphere;
 复制代码
 renderMode:渲染模式：
 NSString * const kCAEmitterLayerUnordered;
 NSString * const kCAEmitterLayerOldestFirst;
 NSString * const kCAEmitterLayerOldestLast;
 NSString * const kCAEmitterLayerBackToFront;
 NSString * const kCAEmitterLayerAdditive;
 复制代码
 Properties:
 
 birthRate:粒子产生系数，默认1.0；
 
 emitterCells: 装着CAEmitterCell对象的数组，被用于把粒子投放到layer上；
 
 emitterDepth:决定粒子形状的深度联系：emitter shape
 
 emitterZposition:发射源的z坐标位置；
 
 lifetime:粒子生命周期
 
 preservesDepth:不是多很清楚（粒子是平展在层上）
 
 
 scale:粒子的缩放比例：
 
 seed：用于初始化随机数产生的种子
 
 spin:自旋转速度
 
 velocity：粒子速度
 
 CAEmitterCell
 
 CAEmitterCell类代从从CAEmitterLayer射出的粒子；emitter cell定义了粒子发射的方向。
 
 alphaRange:  一个粒子的颜色alpha能改变的范围；
 
 alphaSpeed:粒子透明度在生命周期内的改变速度；
 
 birthrate：粒子参数的速度乘数因子；每秒发射的粒子数量
 
 blueRange：一个粒子的颜色blue 能改变的范围；
 
 blueSpeed: 粒子blue在生命周期内的改变速度；
 
 color:粒子的颜色
 
 contents：是个CGImageRef的对象,既粒子要展现的图片；
 
 contentsRect：应该画在contents里的子rectangle：
 
 emissionLatitude：发射的z轴方向的角度
 
 emissionLongitude:x-y平面的发射方向
 
 emissionRange；周围发射角度
 
 emitterCells：粒子发射的粒子
 
 enabled：粒子是否被渲染
 
 greenrange: 一个粒子的颜色green 能改变的范围；
 
 greenSpeed: 粒子green在生命周期内的改变速度；
 
 lifetime：生命周期
 
 lifetimeRange：生命周期范围      lifetime= lifetime(+/-) lifetimeRange
 
 magnificationFilter：不是很清楚好像增加自己的大小
 
 minificatonFilter：减小自己的大小
 
 minificationFilterBias：减小大小的因子
 
 name：粒子的名字
 
 redRange：一个粒子的颜色red 能改变的范围；
 
 redSpeed; 粒子red在生命周期内的改变速度；
 
 scale：缩放比例：
 
 scaleRange：缩放比例范围；
 
 scaleSpeed：缩放比例速度：
 
 spin：子旋转角度
 
 spinrange：子旋转角度范围
 
 style：不是很清楚：
 
 velocity：速度
 
 velocityRange：速度范围
 
 xAcceleration:粒子x方向的加速度分量
 
 yAcceleration:粒子y方向的加速度分量
 
 zAcceleration:粒子z方向的加速度分量
 */

#import "CAEmitterLayer+Animations.h"

@implementation CAEmitterLayer (Animations)

+(CAEmitterLayer *)snowEmitterPosition:(CGPoint)position emitterSize:(CGSize)size{
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    //发射位置
    snowEmitter.emitterPosition = position;
    //发射源的大小
    snowEmitter.emitterSize = size;
    //发射模式
    snowEmitter.emitterMode = kCAEmitterLayerOutline;
    //发射源的形状
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    
    // 装着CAEmitterCell对象的数组，被用于把粒子投放到layer上
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
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
    snowflake.emissionRange = 0.5 * M_PI;
    //子旋转角度范围
    snowflake.spinRange =0.25 * M_PI;
    //是个CGImageRef的对象,既粒子要展现的图片
    snowflake.contents = (id) [[UIImage imageNamed:@"DazFlake"]CGImage];
    //
    snowflake.color = [UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000].CGColor;
    //阴影透明度，默认0
    snowEmitter.shadowOpacity = 1.0;
    //阴影半径，默认3
    snowEmitter.shadowRadius = 0.0;
    //shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    snowEmitter.shadowOffset = CGSizeMake(0.0, 1.0);
    //shadowColor阴影颜色
    snowEmitter.shadowColor = [[UIColor whiteColor] CGColor];
    snowEmitter.emitterCells =[NSArray arrayWithObject:snowflake];

    return snowEmitter;
    
}

+(CAEmitterLayer *)heartsEmitterPosition:(CGPoint)position emitterSize:(CGSize)size{
    CAEmitterLayer *heartsEmitter = [CAEmitterLayer layer];
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

+(CAEmitterLayer *)fireworksEmitterPosition:(CGPoint)position emitterSize:(CGSize)size{

    CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
    fireworksEmitter.emitterPosition = position;
    fireworksEmitter.emitterSize	= size;
    fireworksEmitter.emitterMode	= kCAEmitterLayerOutline;
    fireworksEmitter.emitterShape	= kCAEmitterLayerLine;
    fireworksEmitter.renderMode		= kCAEmitterLayerAdditive;
    fireworksEmitter.seed = (arc4random()%100)+1;
    
    
    // 创建发射的火箭
    CAEmitterCell* rocket = [CAEmitterCell emitterCell];
    
    rocket.birthRate		= 1.0;
    rocket.emissionRange	= 0.25 * M_PI;  // some variation in angle
    rocket.velocity			= 380;
    rocket.velocityRange	= 100;
    rocket.yAcceleration	= 75;
    rocket.lifetime			= 1.02;	// we cannot set the birthrate < 1.0 for the burst
    
    rocket.contents			= (id) [[UIImage imageNamed:@"DazRing"] CGImage];
    rocket.scale			= 0.2;
    rocket.color			= [[UIColor redColor] CGColor];
    rocket.greenRange		= 1.0;		// different colors
    rocket.redRange			= 1.0;
    rocket.blueRange		= 1.0;
    rocket.spinRange		= M_PI;		// slow spin

    //没有这节点，会提前散落，实现爆照的场面
    CAEmitterCell* burst = [CAEmitterCell emitterCell];
    
    burst.birthRate			= 1.0;		// at the end of travel
    burst.velocity			= 0;
    burst.scale				= 2.5;
    burst.redSpeed			=-1.5;		// shifting
    burst.blueSpeed			=+1.5;		// shifting
    burst.greenSpeed		=+1.0;		// shifting
    burst.lifetime			= 0.35;

    // 火花
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    
    spark.birthRate			= 400;
    spark.velocity			= 125;
    spark.emissionRange		= 2* M_PI;	// 360 deg
    spark.yAcceleration		= 75;		// gravity
    spark.lifetime			= 3;
    
    spark.contents			= (id) [[UIImage imageNamed:@"DazStarOutline"] CGImage];
    spark.scaleSpeed		=-0.2;
    spark.greenSpeed		=-0.1;
    spark.redSpeed			= 0.4;
    spark.blueSpeed			=-0.1;
    spark.alphaSpeed		=-0.25;
    spark.spin				= 2* M_PI;
    spark.spinRange			= 2* M_PI;
    
    fireworksEmitter.emitterCells	= [NSArray arrayWithObject:rocket];
    rocket.emitterCells				= [NSArray arrayWithObject:burst];
    burst.emitterCells				= [NSArray arrayWithObject:spark];
    return fireworksEmitter;
}
@end
