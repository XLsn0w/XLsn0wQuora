
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIBezierPath (JKLength)

- (CGFloat)jk_length;

- (CGPoint)jk_pointAtPercentOfLength:(CGFloat)percent;

@end
