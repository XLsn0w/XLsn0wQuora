/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/

/*! Objective-C-Categories */
#import "NSDate+XL.h"
#import "NSString+XL.h"
#import "NSArray+XL.h"
#import "NSDictionary+XLsn0w.h"
#import "NSMutableArray+XLsn0w.h"
#import "UIView+XLsn0w.h"
#import "UILabel+XLsn0w.h"
#import "UIButton+XLsn0w.h"
#import "UIImage+XLsn0w.h"
#import "UIImageView+XLsn0w.h"
#import "UIColor+XLsn0w.h"
#import "UITabBarController+XLsn0w.h"
#import "UINavigationBar+XLsn0w.h"
#import "NSArray+JKBlock.h"
#import "NSArray+JKSafeAccess.h"
#import "NSBundle+JKAppIcon.h"
#import "NSData+JKAPNSToken.h"
#import "NSData+JKBase64.h"
#import "NSData+JKDataCache.h"
#import "NSData+JKEncrypt.h"
#import "NSData+JKGzip.h"
#import "NSData+JKHash.h"
#import "NSData+JKzlib.h"
#import "NSData+JKPCM.h"
#import "NSDate+JKCupertinoYankee.h"
#import "NSDate+JKFormatter.h"
#import "NSDate+JKInternetDateTime.h"
#import "NSDate+JKReporting.h"
#import "NSDate+JKUtilities.h"
#import "NSDateFormatter+JKMake.h"
#import "NSDecimalNumber+JKCalculatingByString.h"
#import "NSDecimalNumber+JKExtensions.h"
#import "NSDictionary+JKBlock.h"
#import "NSDictionary+JKJSONString.h"
#import "NSDictionary+JKMerge.h"
#import "NSDictionary+JKSafeAccess.h"
#import "NSDictionary+JKURL.h"
#import "NSDictionary+JKXML.h"
#import "NSException+JKTrace.h"
#import "NSFileHandle+JKReadLine.h"
#import "NSFileManager+JKPaths.h"
#import "NSHTTPCookieStorage+JKFreezeDry.h"
#import "NSIndexPath+JKOffset.h"
#import "NSInvocation+JKBlock.h"
#import "NSMutableURLRequest+JKUpload.h"
#import "NSNotificationCenter+JKMainThread.h"
#import "NSNumber+JKCGFloat.h"
#import "NSNumber+JKRomanNumerals.h"
#import "NSNumber+JKRound.h"
#import "NSObject+JKAddProperty.h"
#import "NSObject+JKAppInfo.h"
#import "NSObject+JKAssociatedObject.h"
#import "NSObject+JKAutoCoding.h"
#import "NSObject+JKBlocks.h"
#import "NSObject+JKBlockTimer.h"
#import "NSObject+JKEasyCopy.h"
#import "NSObject+JKGCD.h"
#import "NSObject+JKKVOBlocks.h"
#import "NSObject+JKReflection.h"
#import "NSObject+JKRuntime.h"
#import "NSRunLoop+JKPerformBlock.h"
#import "NSSet+JKBlock.h"
#import "NSString+JKBase64.h"
#import "NSString+JKContains.h"
#import "NSString+JKDictionaryValue.h"
#import "NSString+JKEmoji.h"
#import "NSString+JKEncrypt.h"
#import "NSString+JKHash.h"
#import "NSString+JKMatcher.h"
#import "NSString+JKMIME.h"
#import "NSString+JKNormalRegex.h"
#import "NSString+JKPinyin.h"
#import "NSString+JKRemoveEmoji.h"
#import "NSString+JKScore.h"
#import "NSString+JKSize.h"
#import "NSString+JKTrims.h"
#import "NSString+JKURLEncode.h"
#import "NSString+JKUUID.h"
#import "NSString+JKXMLDictionary.h"
#import "NSTimer+JKAddition.h"
#import "NSTimer+JKBlocks.h"
#import "NSURL+JKParam.h"
#import "NSURL+JKQueryDictionary.h"
#import "NSURLConnection+JKSelfSigned.h"
#import "NSURLRequest+JKParamsFromDictionary.h"
#import "NSUserDefaults+JKiCloudSync.h"
#import "NSUserDefaults+JKSafeAccess.h"
#import "MKMapView+JKBetterMaps.h"
#import "MKMapView+JKMoveLogo.h"
#import "MKMapView+JKZoomLevel.h"
#import "UIAlertView+JKBlock.h"
#import "UIApplication+JKApplicationSize.h"
#import "UIApplication+JKKeyboardFrame.h"
#import "UIApplication+JKNetworkActivityIndicator.h"
#import "UIApplication+JKPermissions.h"
#import "UIBarButtonItem+JKAction.h"
#import "UIBezierPath+JKBasicShapes.h"
#import "UIBezierPath+JKLength.h"
#import "UIBezierPath+JKSVGString.h"
#import "UIBezierPath+JKSymbol.h"
#import "UIBezierPath+JKThroughPointsBezier.h"
#import "UIButton+JKBackgroundColor.h"
#import "UIButton+JKBlock.h"
#import "UIButton+JKCountDown.h"
#import "UIButton+JKImagePosition.h"
#import "UIButton+JKIndicator.h"
#import "UIButton+JKMiddleAligning.h"
#import "UIButton+JKSubmitting.h"
#import "UIButton+JKTouchAreaInsets.h"
#import "UIColor+JKGradient.h"
#import "UIColor+JKHEX.h"
#import "UIColor+JKModify.h"
#import "UIColor+JKRandom.h"
#import "UIColor+JKWeb.h"
#import "UIControl+JKActionBlocks.h"
#import "UIControl+JKBlock.h"
#import "UIDevice+JKHardware.h"
#import "UIFont+JKDynamicFontControl.h"
#import "UIFont+JKTTF.h"
#import "UIImage+JKAlpha.h"
#import "UIImage+JKAnimatedGIF.h"
#import "UIImage+JKBetterFace.h"
#import "UIImage+JKBlur.h"
#import "UIImage+JKCapture.h"
#import "UIImage+JKColor.h"
#import "UIImage+JKFileName.h"
#import "UIImage+JKFXImage.h"
#import "UIImage+JKGIF.h"
#import "UIImage+JKMerge.h"
#import "UIImage+JKOrientation.h"
#import "UIImage+JKRemoteSize.h"
#import "UIImage+JKResize.h"
#import "UIImage+JKRoundedCorner.h"
#import "UIImage+JKSuperCompress.h"
#import "UIImage+JKVector.h"
#import "UIImageView+JKAddition.h"
#import "UIImageView+JKFaceAwareFill.h"
#import "UIImageView+JKGeometryConversion.h"
#import "UIImageView+JKLetters.h"
#import "UIImageView+JKReflect.h"
#import "UILabel+JKAutomaticWriting.h"
#import "UILabel+JKAutoSize.h"
#import "UILabel+JKSuggestSize.h"
#import "UINavigationBar+JKAwesome.h"
#import "UINavigationController+JKStackManager.h"
#import "UINavigationController+JKTransitions.h"
#import "UINavigationItem+JKLoading.h"
#import "UINavigationItem+JKLock.h"
#import "UINavigationItem+JKMargin.h"
#import "UIPopoverController+iPhone.h"
#import "UIResponder+JKChain.h"
#import "UIResponder+JKFirstResponder.h"
#import "UIScreen+JKFrame.h"
#import "UIScrollView+JKAddition.h"
#import "UIScrollView+JKPages.h"
#import "UISearchBar+JKBlocks.h"
#import "UISplitViewController+JKQuickAccess.h"
#import "UITextField+JKBlocks.h"
#import "UITextField+JKSelect.h"
#import "UITextField+JKShake.h"
#import "UITextView+JKPinchZoom.h"
#import "UITextView+JKPlaceHolder.h"
#import "UITextView+JKSelect.h"
#import "UIView+JKAnimation.h"
#import "UIView+JKBlockGesture.h"
#import "UIView+JKConstraints.h"
#import "UIView+JKCustomBorder.h"
#import "UIView+JKDraggable.h"
#import "UIView+JKFind.h"
#import "UIView+JKFrame.h"
#import "UIView+JKNib.h"
#import "UIView+JKRecursion.h"
#import "UIView+JKScreenshot.h"
#import "UIView+JKShake.h"
#import "UIView+JKToast.h"
#import "UIView+JKVisuals.h"
#import "UIViewController+JKBackButtonItemTitle.h"
#import "UIViewController+JKBackButtonTouched.h"
#import "UIViewController+JKBlockSegue.h"
#import "UIViewController+JKRecursiveDescription.h"
#import "UIViewController+JKStoreKit.h"
#import "UIViewController+JKVisible.h"
#import "UIWebView+JKBlocks.h"
#import "UIWebView+JKCanvas.h"
#import "UIWebView+JKJavaScript.h"
#import "UIWebView+JKLoad.h"
#import "UIWebView+JKMetaParser.h"
#import "UIWebView+JKStyle.h"
#import "UIWebVIew+JKSwipeGesture.h"
#import "UIWebView+JKTS_JavaScriptContext.h"
#import "UIWindow+JKHierarchy.h"
#import "CAMediaTimingFunction+JKAdditionalEquations.h"
#import "CAShapeLayer+JKUIBezierPath.h"
#import "CATransaction+JKAnimateWithDuration.h"
#import "NSObject+XLsn0w.h"
#import "UILabel+MultipleLines.h"
#import "UIColor+BgColor.h"
#import "UIBarButtonItem+BFKit.h"
#import "UIButton+BFKit.h"
#import "UIColor+BFKit.h"
#import "UIDevice+BFKit.h"
#import "UIFont+BFKit.h"
#import "UIImage+BFKit.h"
#import "UIImageView+BFKit.h"
#import "UILabel+BFKit.h"
#import "UINavigationBar+BFKit.h"
#import "UIScreen+BFKit.h"
#import "UIScrollView+BFKit.h"
#import "UITableView+BFKit.h"
#import "UITableView+Placeholder.h"
#import "UITextField+BFKit.h"
#import "UITextView+BFKit.h"
#import "UIToolbar+BFKit.h"
#import "UIView+BFKit.h"
#import "UIWebView+BFKit.h"
#import "UIWindow+BFKit.h"
#import "NSArray+BFKit.h"
#import "NSData+BFKit.h"
#import "NSDate+BFKit.h"
#import "NSDictionary+BFKit.h"
#import "NSFileManager+BFKit.h"
#import "NSMutableArray+BFKit.h"
#import "NSMutableDictionary+BFKit.h"
#import "NSNumber+BFKit.h"
#import "NSObject+BFKit.h"
#import "NSProcessInfo+BFKit.h"
#import "NSString+BFKit.h"
#import "NSThread+BFKit.h"
#import "NSDate-Utilities.h"

#import "NSObject+XLsn0wKit.h"
#import "UIButton+XLsn0wBadge.h"
#import "UIButton+ImageTitleLayout.h"
#import "UIDevice+XLsn0wKit.h"
#import "UIImageView+XLsn0wKit.h"
#import "UIViewController+XLsn0wKit.h"

#import "NSObject+GetCurrentScreenViewController.h"
#import "UIViewController+AddIsAutorotate.h"
#import "UINavigationController+AddXLsn0wShouldAutorotate.h"


/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/

