
import UIKit
import XLsn0wKit_swift

extension UIViewController {
    
    //: 通过类名称创建控制器
    class func controller(withName controllerName:String?) -> UIViewController? {
        
        //: 获取命名空间
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            XLsn0wLog("获取命名空间失败")
            return nil
        }
        
        guard let className = NSClassFromString(nameSpace + "." + (controllerName ?? ""))  else {
            XLsn0wLog("\(ToControllerKey):控制器名称\(controllerName)找不到!")
            return nil
        }
        
        
        //: 获取类型
        guard let classType = className as? UIViewController.Type  else {
            XLsn0wLog("获取类型失败，不能创建控制器")
            return nil
        }
        
        return classType.init()
    }
    
    
    func hideNavigationBar(isHiden hide:Bool) {
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.setBackgroundImage(hide ? UIImage() : UIImage.image(withColor: SystemNavgationBarTintColor, withSize: CGSize.zero), for: .default)
        
        if hide {
            navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
    
    //MARK: 显示警告
    func showMessageWoring(message : NSString) {
        
        let _font = UIFont.systemFont(ofSize: 14)
        
        let label = self.creatLabel()
        label.backgroundColor = UIColor.colorWithHexString_alpha(alpha: 0.90, color: "#7373a5");
        label.font = _font
        
        label.text = message as String;
        
        self.view.addSubview(label)
        
        self.showLabel(label: label)
    }
    
    //MARK: 显示错误类信息
    func showMessageError(message : NSString) {
        let _font = UIFont.systemFont(ofSize: 14)
        
        let label = self.creatLabel()
        label.backgroundColor = UIColor.colorWithHexString_alpha(alpha: 0.90, color: "#f23965");
        label.font = _font
        
        label.text = message as String;
        
        self.view.addSubview(label)
        
        self.showLabel(label: label)
    }
    
    func showLabel(label : UILabelPadding) {
        
        let __width = UIScreen.main.bounds.size.width
        
        let __height = NDTools.shareTool.sizeWithFont(font: label.font, width:__width , text: label.text!).height+32 //注意此处‘+32’ = 你的TOP+Bottom
        
        label.frame = CGRect.init(x: 0.0, y: -__height, width: __width, height: __height)
        
        UIView.animate(withDuration: 0.3, animations: {
            
            label.ND_Y = 0
            
        }) { (Bool) in
            
            UIView.animate(withDuration: 0.5, delay: 1.5, options: UIViewAnimationOptions.transitionFlipFromTop, animations: {
                label.ND_Y = -__height
            }, completion: { (Bool) in
                label .removeFromSuperview()
            })
        }
    }
    
    func creatLabel() -> UILabelPadding {
        let label = UILabelPadding.init()
        label.textColor = UIColor.white
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignment.left
        label.isUserInteractionEnabled = false
        label.paddingLeft = 15;
        label.paddingRight = 15;
        label.paddingTop = 22;
        label.paddingBottom = 10;
        
        return label
    }
    
}
