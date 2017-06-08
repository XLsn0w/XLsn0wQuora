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
import Foundation
import UIKit

extension UIColor {
    
    static func hexValue (_ value:UInt32) -> UIColor{
        return UIColor.hexValue(value, alpha: 1);
    }
    static func hexValue (_ value:UInt32, alpha:CGFloat) -> UIColor{
        let r = (value & 0x00FF0000) >> 16
        let g = (value & 0x0000FF00) >> 8
        let b = (value & 0x000000FF)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue:CGFloat(b)/255.0, alpha: alpha)
    }
    
    
    //类函数 class  func   func  函数
    class  func getRandomColor() ->UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
    }
    //特性：1、在extension扩展，必须使用convenience便利构造函数
    // 2.必须调用self.init,构造默认没有返回值，但是系统会自动返回但是不能返回nil
    convenience init(r : CGFloat , g : CGFloat, b : CGFloat, a : CGFloat = 1.0){
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    //颜色转换
    convenience init?(colorHexString : String) {
        //1.判断字符串长度是否大于6
        guard colorHexString.characters.count >= 6 else {
            return nil
        }
        //2.将字符串转化为大写
        var hextempString = colorHexString.uppercased()
        
        //3.判断字符串是否是颜色字符串
        if hextempString.hasPrefix("0X") || hextempString.hasPrefix("##"){
            hextempString = (hextempString as NSString).substring(to: 2)
        }
        
        //4.分离出rgb的十六进制
        var  range = NSRange(location: 0, length: 2)
        let rhex = (hextempString as NSString).substring(with: range)
        range.location = 2
        let ghex = (hextempString as NSString).substring(with: range)
        range.location = 4
        let bhex = (hextempString as NSString).substring(with: range)
        
        //5.scaner转化
        var  r : UInt32 = 0
        var  g : UInt32 = 0
        var  b : UInt32 = 0
        Scanner(string: rhex).scanHexInt32(&r)
        Scanner(string: ghex).scanHexInt32(&g)
        Scanner(string: bhex).scanHexInt32(&b)
        
        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    }
    
    //获取颜色的RGB值
    func getRGBValue() -> (CGFloat , CGFloat , CGFloat){
        guard let components = self.cgColor.components else {
            fatalError("获取颜色的RGB值失败")
        }
        return (components[0] * 255,components[1] * 255,components[2] * 255)
    }

    
    class var JKThemColor_Yellow: UIColor {
        get {
            return UIColor.RGB(r: 254, g: 212, b: 48)!
        }
    }
    
    class var JKThemColor_Dark: UIColor {
        get {
            return UIColor.RGB(r: 32, g: 44, b: 61)!
        }
    }
    
    
    class var JKThemColor_Light: UIColor {
        get {
            return UIColor.RGB(r: 116, g: 116, b: 116)!
        }
    }
    
    
    class var JKThemColor_Mid: UIColor {
        get {
            return UIColor.RGB(r: 77, g: 77, b: 77)!
        }
    }
    


    
    class func RGB_Float(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor? {
        return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    class func RGB(r:Int,g:Int,b:Int) -> UIColor? {
        return UIColor.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
    
    func alpha(_ alpha: CGFloat) -> UIColor {
        return self.withAlphaComponent(alpha)
    }
    
    
    
    
    class func RGB(_ rgbValue: String) -> UIColor? {
        
        ///  支持格式包括： #ff21af64   #21af64   0x21af64
        if (rgbValue.hasPrefix("#") || (rgbValue.hasPrefix("0x"))) {
            let mutStr = (rgbValue as NSString).mutableCopy() as! NSMutableString
            
            if (rgbValue.hasPrefix("#")) {
                mutStr.deleteCharacters(in: NSRange.init(location: 0, length: 1))
            } else {
                mutStr.deleteCharacters(in: NSRange.init(location: 0, length: 2))
            }
            
            if (mutStr.length == 6) {
                mutStr.insert("ff", at: 0)
            }
            
            
            let aStr = mutStr.substring(with: NSRange.init(location: 0, length: 2))
            let rStr = mutStr.substring(with: NSRange.init(location: 2, length: 2))
            let gStr = mutStr.substring(with: NSRange.init(location: 4, length: 2))
            let bStr = mutStr.substring(with: NSRange.init(location: 6, length: 2))
            
            let alpha = aStr.hexValue()
            let red = rStr.hexValue()
            let green = gStr.hexValue()
            let blue = bStr.hexValue()
            
            return UIColor.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
        }else{
            assert(false, "16进制字符串转UIColor：格式不支持")
            return nil
        }
    }
}
