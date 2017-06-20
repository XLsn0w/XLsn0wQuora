
#import "XLsn0wQRcode.h"

#import <AVFoundation/AVFoundation.h>
#import <CoreGraphics/CoreGraphics.h>

CGFloat const NAVIGATIONBAR_HEIGHT = 64.f;
CGFloat const TABBAR_HEIGHT = 49.f;
CGFloat const ZFScanRatio = 0.68f;

@interface MaskView : UIView
//重设UI的frame
- (void)resetFrame;
//移除动画
- (void)removeAnimation;
@end

@interface MaskView ()

@property (nonatomic, strong) UIImageView * scanLineImg;
@property (nonatomic, strong) UIView * maskView;
@property (nonatomic, strong) UILabel * hintLabel;
@property (nonatomic, strong) UIImageView * topLeftImg;
@property (nonatomic, strong) UIImageView * topRightImg;
@property (nonatomic, strong) UIImageView * bottomLeftImg;
@property (nonatomic, strong) UIImageView * bottomRightImg;

@property (nonatomic, strong) UIBezierPath * bezier;
@property (nonatomic, strong) CAShapeLayer * shapeLayer;

/** 第一次旋转 */
@property (nonatomic, assign) CGFloat isFirstTransition;

@end

@implementation MaskView

- (void)commonInit {
    _isFirstTransition = YES;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        [self addUI];
    }
    
    return self;
}

/**
 *  添加UI
 */
- (void)addUI{
    //遮罩层
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.5;
    self.maskView.layer.mask = [self maskLayer];
    [self addSubview:self.maskView];
    
    //提示框
    self.hintLabel = [[UILabel alloc] init];
    self.hintLabel.text = @"将二维码/条码放入框内，即可自动扫描";
    self.hintLabel.textColor = [UIColor lightGrayColor];
    self.hintLabel.numberOfLines = 0;
    self.hintLabel.font = [UIFont systemFontOfSize:14];
    self.hintLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.hintLabel];
    
    //边框
    UIImage * topLeft = [UIImage imageNamed:@"ScanQR1"];
    UIImage * topRight = [UIImage imageNamed:@"ScanQR2"];
    UIImage * bottomLeft = [UIImage imageNamed:@"ScanQR3"];
    UIImage * bottomRight = [UIImage imageNamed:@"ScanQR4"];
    
    //左上
    self.topLeftImg = [[UIImageView alloc] init];
    self.topLeftImg.image = topLeft;
    [self addSubview:self.topLeftImg];
    
    //右上
    self.topRightImg = [[UIImageView alloc] init];
    self.topRightImg.image = topRight;
    [self addSubview:self.topRightImg];
    
    //左下
    self.bottomLeftImg = [[UIImageView alloc] init];
    self.bottomLeftImg.image = bottomLeft;
    [self addSubview:self.bottomLeftImg];
    
    //右下
    self.bottomRightImg = [[UIImageView alloc] init];
    self.bottomRightImg.image = bottomRight;
    [self addSubview:self.bottomRightImg];
    
    //扫描线
    UIImage * scanLine = [UIImage imageNamed:@"QRCodeScanLine"];
    self.scanLineImg = [[UIImageView alloc] init];
    self.scanLineImg.image = scanLine;
    self.scanLineImg.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.scanLineImg];
    [self.scanLineImg.layer addAnimation:[self animation] forKey:nil];
    
    //设置frame
    //横屏
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
        
        //提示框
        self.hintLabel.frame = CGRectMake(0, 0, self.frame.size.height * ZFScanRatio, 60);
        self.hintLabel.center = CGPointMake(self.maskView.center.x, self.maskView.center.y + (self.frame.size.height * ZFScanRatio) * 0.5 + 25);
        //左上
        self.topLeftImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.height * ZFScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.height * ZFScanRatio)) * 0.5, self.topLeftImg.image.size.width, self.topLeftImg.image.size.height);
        //右上
        self.topRightImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.height * ZFScanRatio)) * 0.5 - self.topRightImg.image.size.width + self.frame.size.height * ZFScanRatio, (self.frame.size.height - (self.frame.size.height * ZFScanRatio)) * 0.5, self.topRightImg.image.size.width, self.topRightImg.image.size.height);
        //左下
        self.bottomLeftImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.height * ZFScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.height * ZFScanRatio)) * 0.5 - self.bottomLeftImg.image.size.height + self.frame.size.height * ZFScanRatio, self.bottomLeftImg.image.size.width, self.bottomLeftImg.image.size.height);
        //右下
        self.bottomRightImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.height * ZFScanRatio)) * 0.5 - self.bottomRightImg.image.size.width + self.frame.size.height * ZFScanRatio, (self.frame.size.height - (self.frame.size.height * ZFScanRatio)) * 0.5 - self.bottomRightImg.image.size.width + self.frame.size.height * ZFScanRatio, self.bottomRightImg.image.size.width, self.bottomRightImg.image.size.height);
        //扫描线
        self.scanLineImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.height * ZFScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.height * ZFScanRatio)) * 0.5, self.frame.size.height * ZFScanRatio, scanLine.size.height);
        
        //竖屏
    }else{
        //提示框
        self.hintLabel.frame = CGRectMake(0, 0, self.frame.size.width * ZFScanRatio, 60);
        self.hintLabel.center = CGPointMake(self.maskView.center.x, self.maskView.center.y + (self.frame.size.width * ZFScanRatio) * 0.5 + 40);
        //左上
        self.topLeftImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * ZFScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.width * ZFScanRatio)) * 0.5, topLeft.size.width, topLeft.size.height);
        //右上
        self.topRightImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * ZFScanRatio)) * 0.5 - topRight.size.width + self.frame.size.width * ZFScanRatio, (self.frame.size.height - (self.frame.size.width * ZFScanRatio)) * 0.5, topRight.size.width, topRight.size.height);
        //左下
        self.bottomLeftImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * ZFScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.width * ZFScanRatio)) * 0.5 - bottomLeft.size.height + self.frame.size.width * ZFScanRatio, bottomLeft.size.width, bottomLeft.size.height);
        //右下
        self.bottomRightImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * ZFScanRatio)) * 0.5 - bottomRight.size.width + self.frame.size.width * ZFScanRatio, (self.frame.size.height - (self.frame.size.width * ZFScanRatio)) * 0.5 - bottomRight.size.width + self.frame.size.width * ZFScanRatio, bottomRight.size.width, bottomRight.size.height);
        //扫描线
        self.scanLineImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * ZFScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.width * ZFScanRatio)) * 0.5, self.frame.size.width * ZFScanRatio, scanLine.size.height);
    }
}

/**
 *  动画
 */
- (CABasicAnimation *)animation{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 3;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.repeatCount = MAXFLOAT;
    
    //第一次旋转
    if (_isFirstTransition) {
        //横屏
        if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
            
            animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, (self.center.y - self.frame.size.height * ZFScanRatio * 0.5 + self.scanLineImg.image.size.height * 0.5))];
            animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, (self.center.y + self.frame.size.height * ZFScanRatio * 0.5 - self.scanLineImg.image.size.height * 0.5))];
            
            //竖屏
        }else{
            animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, (self.center.y - self.frame.size.width * ZFScanRatio * 0.5 + self.scanLineImg.image.size.height * 0.5))];
            animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y + self.frame.size.width * ZFScanRatio * 0.5 - self.scanLineImg.image.size.height * 0.5)];
        }
        
        _isFirstTransition = NO;
        
        //非第一次旋转
    }else{
        //横屏
        if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
            
            animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, (self.frame.size.height - (self.frame.size.width * ZFScanRatio)) * 0.5)];
            animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.scanLineImg.frame.origin.y + self.frame.size.width * ZFScanRatio - self.scanLineImg.frame.size.height * 0.5)];
            
            
            //竖屏
        }else{
            
            animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, (self.frame.size.height - (self.frame.size.height * ZFScanRatio)) * 0.5)];
            animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.scanLineImg.frame.origin.y + self.frame.size.height * ZFScanRatio - self.scanLineImg.frame.size.height * 0.5)];
        }
    }
    
    return animation;
}

/**
 *  遮罩层bezierPath
 *
 *  @return UIBezierPath
 */
- (UIBezierPath *)maskPath{
    self.bezier = nil;
    self.bezier = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    //第一次旋转
    if (_isFirstTransition) {
        //横屏
        if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
            
            [self.bezier appendPath:[[UIBezierPath bezierPathWithRect:CGRectMake((self.frame.size.width - (self.frame.size.height * ZFScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.height * ZFScanRatio)) * 0.5, self.frame.size.height * ZFScanRatio, self.frame.size.height * ZFScanRatio)] bezierPathByReversingPath]];
            
            //竖屏
        }else{
            [self.bezier appendPath:[[UIBezierPath bezierPathWithRect:CGRectMake((self.frame.size.width - (self.frame.size.width * ZFScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.width * ZFScanRatio)) * 0.5, self.frame.size.width * ZFScanRatio, self.frame.size.width * ZFScanRatio)] bezierPathByReversingPath]];
        }
        
        //非第一次旋转
    }else{
        //横屏
        if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
            
            [self.bezier appendPath:[[UIBezierPath bezierPathWithRect:CGRectMake((self.frame.size.width - (self.frame.size.width * ZFScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.width * ZFScanRatio)) * 0.5, self.frame.size.width * ZFScanRatio, self.frame.size.width * ZFScanRatio)] bezierPathByReversingPath]];
            
            //竖屏
        }else{
            [self.bezier appendPath:[[UIBezierPath bezierPathWithRect:CGRectMake((self.frame.size.width - (self.frame.size.height * ZFScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.height * ZFScanRatio)) * 0.5, self.frame.size.height * ZFScanRatio, self.frame.size.height * ZFScanRatio)] bezierPathByReversingPath]];
        }
    }
    
    return self.bezier;
}

/**
 *  遮罩层ShapeLayer
 *
 *  @return CAShapeLayer
 */
- (CAShapeLayer *)maskLayer{
    [self.shapeLayer removeFromSuperlayer];
    self.shapeLayer = nil;
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.path = [self maskPath].CGPath;
    
    return self.shapeLayer;
}

#pragma mark - public method

/**
 *  重设UI的frame
 */
- (void)resetFrame{
    self.maskView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.maskView.layer.mask = [self maskLayer];
    
    //横屏(转前是横屏，转后才是竖屏)
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        
        self.hintLabel.frame = CGRectMake(0, 0, self.frame.size.width * ZFScanRatio, 60);
        self.hintLabel.center = CGPointMake(self.maskView.center.x, self.maskView.center.y + (self.frame.size.width * ZFScanRatio) * 0.5 + 40);
        
        self.topLeftImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * ZFScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.width * ZFScanRatio)) * 0.5, self.topLeftImg.image.size.width, self.topLeftImg.image.size.height);
        
        self.topRightImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * ZFScanRatio)) * 0.5 - self.topRightImg.image.size.width + self.frame.size.width * ZFScanRatio, (self.frame.size.height - (self.frame.size.width * ZFScanRatio)) * 0.5, self.topRightImg.image.size.width, self.topRightImg.image.size.height);
        
        self.bottomLeftImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * ZFScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.width * ZFScanRatio)) * 0.5 - self.bottomLeftImg.image.size.height + self.frame.size.width * ZFScanRatio, self.bottomLeftImg.image.size.width, self.bottomLeftImg.image.size.height);
        
        self.bottomRightImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * ZFScanRatio)) * 0.5 - self.bottomRightImg.image.size.width + self.frame.size.width * ZFScanRatio, (self.frame.size.height - (self.frame.size.width * ZFScanRatio)) * 0.5 - self.bottomRightImg.image.size.width + self.frame.size.width * ZFScanRatio, self.bottomRightImg.image.size.width, self.bottomRightImg.image.size.height);
        
        self.scanLineImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.width * ZFScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.width * ZFScanRatio)) * 0.5, self.frame.size.width * ZFScanRatio, self.scanLineImg.image.size.height);
        [self.scanLineImg.layer addAnimation:[self animation] forKey:nil];
        
        //竖屏(转前是竖屏，转后才是横屏)
    }else{
        self.hintLabel.frame = CGRectMake(0, 0, self.frame.size.height * ZFScanRatio, 60);
        self.hintLabel.center = CGPointMake(self.maskView.center.x, self.maskView.center.y + (self.frame.size.height * ZFScanRatio) * 0.5 + 25);
        
        self.topLeftImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.height * ZFScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.height * ZFScanRatio)) * 0.5, self.topLeftImg.image.size.width, self.topLeftImg.image.size.height);
        
        self.topRightImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.height * ZFScanRatio)) * 0.5 - self.topRightImg.image.size.width + self.frame.size.height * ZFScanRatio, (self.frame.size.height - (self.frame.size.height * ZFScanRatio)) * 0.5, self.topRightImg.image.size.width, self.topRightImg.image.size.height);
        
        self.bottomLeftImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.height * ZFScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.height * ZFScanRatio)) * 0.5 - self.bottomLeftImg.image.size.height + self.frame.size.height * ZFScanRatio, self.bottomLeftImg.image.size.width, self.bottomLeftImg.image.size.height);
        
        self.bottomRightImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.height * ZFScanRatio)) * 0.5 - self.bottomRightImg.image.size.width + self.frame.size.height * ZFScanRatio, (self.frame.size.height - (self.frame.size.height * ZFScanRatio)) * 0.5 - self.bottomRightImg.image.size.width + self.frame.size.height * ZFScanRatio, self.bottomRightImg.image.size.width, self.bottomRightImg.image.size.height);
        
        self.scanLineImg.frame = CGRectMake((self.frame.size.width - (self.frame.size.height * ZFScanRatio)) * 0.5, (self.frame.size.height - (self.frame.size.height * ZFScanRatio)) * 0.5, self.frame.size.height * ZFScanRatio, self.scanLineImg.image.size.height);
        [self.scanLineImg.layer addAnimation:[self animation] forKey:nil];
    }
}

/**
 *  移除动画
 */
- (void)removeAnimation{
    [self.scanLineImg.layer removeAllAnimations];
}

@end

#pragma mark - XLsn0wQRcode
#import "XLsn0wMacro.h"

@interface XLsn0wQRcode ()<AVCaptureMetadataOutputObjectsDelegate>

/** 输入输出的中间桥梁 */
@property (nonatomic, strong) AVCaptureSession * session;
/** 相机图层 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer * previewLayer;
/** 扫描支持的编码格式的数组 */
@property (nonatomic, strong) NSMutableArray * metadataObjectTypes;
/** 遮罩层 */
@property (nonatomic, strong) MaskView * maskView;
/** 取消按钮 */
@property (nonatomic, strong) UIButton * cancelButton;

@end

@implementation XLsn0wQRcode

- (NSMutableArray *)metadataObjectTypes{
    if (!_metadataObjectTypes) {
        _metadataObjectTypes = [NSMutableArray arrayWithObjects:AVMetadataObjectTypeAztecCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeUPCECode, nil];
        
        // >= iOS 8
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
            [_metadataObjectTypes addObjectsFromArray:@[AVMetadataObjectTypeInterleaved2of5Code, AVMetadataObjectTypeITF14Code, AVMetadataObjectTypeDataMatrixCode]];
        }
    }
    
    return _metadataObjectTypes;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.maskView removeAnimation];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self capture];
    [self addUI];
}

/**
 *  添加遮罩层
 */
- (void)addUI{
    self.maskView = [[MaskView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.maskView];
    
    //取消按钮
    CGFloat cancel_width = 100;
    CGFloat cancel_height = 35;
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cancelButton.frame = CGRectMake(0, 0, cancel_width, cancel_height);
    [self.cancelButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.cancelButton setTintColor:[UIColor whiteColor]];
    [self.cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.maskView addSubview:self.cancelButton];
    self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    //横屏
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        
        self.cancelButton.center = CGPointMake(kScreenWidth - (self.view.center.x - kScreenHeight * ZFScanRatio * 0.5) * 0.5, self.view.center.y);
    
    //竖屏
    }else{
        self.cancelButton.frame = CGRectMake((CGRectGetWidth(self.maskView.frame) - cancel_width) / 2, CGRectGetHeight(self.maskView.frame) - cancel_height - 30, cancel_width, cancel_height);
        
    }
}

/**
 *  扫描初始化
 */
- (void)capture{
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc] init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    self.session = [[AVCaptureSession alloc] init];
    //高质量采集率
    self.session.sessionPreset = AVCaptureSessionPresetHigh;
    
    [self.session addInput:input];
    [self.session addOutput:output];
    
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.view.layer addSublayer:self.previewLayer];
    
    //设置扫描支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = self.metadataObjectTypes;
    
    //开始捕获
    [self.session startRunning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0) {
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = metadataObjects.firstObject;
        self.QRcodeBlock(metadataObject.stringValue);
        
        if (self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

#pragma mark - 取消事件

/**
 * 取消事件
 */
- (void)cancelAction{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 横竖屏适配

/**
 *  PS：size为控制器self.view的size，若图表不是直接添加self.view上，则修改以下的frame值
 */
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator{
    
    self.maskView.frame = CGRectMake(0, 0, size.width, size.height);
    self.previewLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [self.maskView resetFrame];
    
    //横屏
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
 
      self.cancelButton.frame = CGRectMake((CGRectGetWidth(self.maskView.frame) - CGRectGetWidth(self.cancelButton.frame)) / 2, CGRectGetHeight(self.maskView.frame) - CGRectGetHeight(self.cancelButton.frame) - 30, CGRectGetWidth(self.cancelButton.frame), CGRectGetHeight(self.cancelButton.frame));
    
    //竖屏
    }else{
        self.cancelButton.center = CGPointMake(kScreenHeight - (self.view.center.y - kScreenWidth * ZFScanRatio * 0.5) * 0.5, self.view.center.x);
    }
}

@end
