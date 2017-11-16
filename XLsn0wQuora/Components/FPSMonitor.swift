
import UIKit

/// FPS 显示器

///FPS（Frames Per Second）：每秒传输帧数 
///FPS越高，画面越连续，越低，画面越卡

/*
 
 *1. iPhone 5      4.0   分辨率: 320x568，像素640x1136， @2x
 *2. iPhone 6      4.7   分辨率: 375x667，像素750x1334， @2x
 *3. iPhone 6 Plus 5.5   分辨率: 414x736，像素1242x2208，@3x
 
 *4. 屏幕比率 以 iPhone 6 为基准
 *5. #define kFitWidth  ([UIScreen mainScreen].bounds.size.width / 375)
 *6. #define kFitHeight ([UIScreen mainScreen].bounds.size.height / 667)
 
*/

class FPSMonitor: UILabel {
    
    private lazy var disPlayLink = CADisplayLink()
    private lazy var count: NSInteger = 0
    private lazy var lastTime: TimeInterval = 0
    private var fpsColor: UIColor = UIColor.green
    ///屏幕比率 以 iPhone 6 为基准
    private var kFitWidth: Float = Float(UIScreen.main.bounds.size.width / 375.0)

    override init(frame: CGRect) {
        var fpsFrame = frame
        if fpsFrame.origin.x == 0 && fpsFrame.origin.y == 0 {
            fpsFrame = CGRect(x: Int(80*kFitWidth), y: 0, width: 60, height: 20)
        }
        super.init(frame: fpsFrame)
        layer.cornerRadius = 5
        clipsToBounds = true
        textAlignment = .center
        isUserInteractionEnabled = false
        backgroundColor = UIColor.white
        alpha = 0.8
        font = UIFont.systemFont(ofSize: 12)

        disPlayLink = CADisplayLink(target: self, selector: #selector(tick))
        disPlayLink.add(to: RunLoop.main, forMode: .commonModes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        disPlayLink.invalidate()
    }
    
    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize( width: 60, height: 20)
    }
    
    func tick(link: CADisplayLink) {
        if lastTime == 0 {
            lastTime = link.timestamp
            return
        }
        count += 1
        let delta: TimeInterval = link.timestamp - lastTime
        if delta < 1 {
            return
        }
        
        lastTime = link.timestamp
        let fps = Double(count) / delta
        let fpsText = Int(round(fps))
        count = 0
        
        let attrMStr = NSMutableAttributedString(attributedString: NSAttributedString(string: "\(fpsText) FPS" ))
        if fps > 55.0 {// height
            fpsColor = UIColor.green
        } else if(fps >= 50.0 && fps <= 55.0) {
            fpsColor = UIColor.yellow
        } else {
            fpsColor = UIColor.red// low
        }
        
        attrMStr.setAttributes([NSForegroundColorAttributeName:fpsColor], range: NSMakeRange(0, attrMStr.length - 3))
        attrMStr.setAttributes([NSForegroundColorAttributeName:fpsColor], range: NSMakeRange(attrMStr.length - 3, 3))
        self.attributedText = attrMStr
    }
}
