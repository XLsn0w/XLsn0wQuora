
#import <UIKit/UIKit.h>

typedef void (^JKBackButtonHandler)(UIViewController *vc);

@interface UIViewController (JKBackButtonTouched)
/**
 *  @author JKCategories
 *
 *  navgation 返回按钮回调
 */
-(void)jk_backButtonTouched:(JKBackButtonHandler)backButtonHandler;
@end
