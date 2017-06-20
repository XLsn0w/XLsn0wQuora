
import UIKit

class SwiftyMacro: NSObject {

}


let kScreenWidth  = Int(UIScreen.main.bounds.width)
let kScreenHeight = Int(UIScreen.main.bounds.height)

let IS_SCREEN_4_INCH = UIScreen.main.currentMode!.size  .equalTo(CGSize(width: 640, height: 1136))
let IS_SCREEN_47_INCH = UIScreen.main.currentMode!.size .equalTo(CGSize(width: 750, height: 1334))
let IS_SCREEN_55_INCH = UIScreen.main.currentMode!.size .equalTo(CGSize(width: 1242, height: 2208))
