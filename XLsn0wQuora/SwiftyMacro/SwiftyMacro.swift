import UIKit
import SDWebImage
import SnapKit
import YYKit

/**************************************************************************************************/
/***************************************swift版-宏定义-文件*****************************************************/
/**************************************************************************************************/

//MARK: 屏幕设置系列
let kSCREEN_WIDTH = UIScreen.main.bounds.size.width
let kSCREEN_HEIGHT = UIScreen.main.bounds.size.height
let kSCREEN_BOUNDS = UIScreen.main.bounds

//顶部电池条的状态栏高度
let kStatubarHeight = UIApplication.shared.statusBarFrame.size.height

/** 高度667(6s)为基准比例！！！做到不同屏幕适配高度*/
let ND_HEI =  kSCREEN_HEIGHT/667.0

/** 宽度375.0f(6s)为基准比例！！！做到不同屏幕适配宽度  */
let ND_WID =  kSCREEN_WIDTH/375.0

let __LEFT = __X(x:12)

/** 适配屏幕宽度比例*f  */
func __X(x:CGFloat) -> CGFloat {
    return ND_WID * x
}

/** 适配屏幕高度比例*f  */
func __Y(y:CGFloat) -> CGFloat {
    return ND_HEI * y
}

func __FONT(x:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: __X(x: x))
}

func __setCGRECT(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}

/**  如果传入进来的name为空，会导致崩溃 因为必须返回有值 */
func __setImageName(name:String) -> UIImage {
    
    return UIImage(named: name)!
}


func __CGFloat(number:AnyObject) -> CGFloat {
    return CGFloat(number as! NSNumber)
}


let KUserDefauls = UserDefaults.standard

//MARK: 颜色系列
//导航栏颜色
let kGlobalLightBlueColor = UIColor.colorWithHexString(color: "#00d9c9")

let kScreenWidth  = Int(UIScreen.main.bounds.width)
let kScreenHeight = Int(UIScreen.main.bounds.height)

let IS_SCREEN_4_INCH = UIScreen.main.currentMode!.size.equalTo(CGSize(width: 640, height: 1136))
let IS_SCREEN_47_INCH = UIScreen.main.currentMode!.size.equalTo(CGSize(width: 750, height: 1334))
let IS_SCREEN_55_INCH = UIScreen.main.currentMode!.size.equalTo(CGSize(width: 1242, height: 2208))



















