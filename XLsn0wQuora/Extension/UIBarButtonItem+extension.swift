
import UIKit

extension UIBarButtonItem {
    
    class func creatBarItem(image:String, highImage:String, title:String, tagget:Any, action:Selector) -> UIBarButtonItem {
        
        let button = UIButton.init(type: UIButtonType.custom)
        button.setTitle(title, for: UIControlState.normal)
        button.setImage(UIImage.init(named: image), for: UIControlState.normal)
        button.setImage(UIImage.init(named: highImage), for: UIControlState.highlighted)
        button.addTarget(tagget, action: action, for: UIControlEvents.touchUpInside)
        
        button.sizeToFit()
        
        return UIBarButtonItem.init(customView: button)
    }
    
    convenience init(_ imageName:String,target: Any?,action: Selector) {
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setImage(UIImage(named: imageName + "_highlighted")?.withRenderingMode(.alwaysOriginal), for: .highlighted)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.sizeToFit()
        self.init(customView:button)
    }
    
    convenience init(_ titleName:String,_ textColor:UIColor ,_ textFont:UIFont,target: Any?,action: Selector) {
        let button = UIButton(type: .custom)
        button.setTitle(titleName, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = textFont
        button.addTarget(target, action: action, for: .touchUpInside)
        button.sizeToFit()
        self.init(customView:button)
    }
    
}

