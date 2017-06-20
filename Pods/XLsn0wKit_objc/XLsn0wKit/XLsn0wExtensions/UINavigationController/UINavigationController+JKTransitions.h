
#import <UIKit/UIKit.h>

@interface UINavigationController (JKTransitions)

- (void)jk_pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition;
- (UIViewController *)jk_popViewControllerWithTransition:(UIViewAnimationTransition)transition;

@end
