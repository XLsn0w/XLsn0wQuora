
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
    
}

