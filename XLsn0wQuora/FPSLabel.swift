
import UIKit

///FPS（Frames Per Second）：每秒传输帧数 
///FPS越高，画面越连续，越低，画面越卡

class FPSLabel: UILabel {

    private lazy var disPlayLink = CADisplayLink()
    private lazy var count: NSInteger = 0
    private lazy var lastTime: TimeInterval = 0
    private var fpsColor: UIColor = UIColor.green

    override init(frame: CGRect) {
        var fpsFrame = frame
        if fpsFrame.origin.x == 0 && fpsFrame.origin.y == 0 {
            fpsFrame = CGRect(x: UIScreen.main.bounds.width/2 - (60/2), y: 20, width: 60, height: 20)
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
        if fps > 55.0{
            fpsColor = UIColor.green
        } else if(fps >= 50.0 && fps <= 55.0) {
            fpsColor = UIColor.yellow
        } else {
            fpsColor = UIColor.red
        }
        
        attrMStr.setAttributes([NSForegroundColorAttributeName:fpsColor], range: NSMakeRange(0, attrMStr.length - 3))
        attrMStr.setAttributes([NSForegroundColorAttributeName:UIColor.blue], range: NSMakeRange(attrMStr.length - 3, 3))
        self.attributedText = attrMStr
    }
}
