
import Foundation

// MARK: - 自定义dispatch_once
public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    /// - Parameters:
    ///   - token: NSUUID().uuidString
    ///   - block: Block to execute once
    public class func once(token: String, block:() -> Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}


//使用字符串token作为once的ID，执行once的时候加了一个锁，避免多线程下的token判断不准确的问题。
//使用的时候可以传token
//
//DispatchQueue.once(token: "com.vectorform.test") {
//    print( "Do This Once!" )
//}
//或者使用UUID也可以：
//
//private let _onceToken = NSUUID().uuidString
//
//DispatchQueue.once(token: _onceToken) {
//    print( "Do This Once!" )
//}

//class Singleton {
//    class var sharedInstance : Singleton {
//        struct Static {
//            static var onceToken : dispatch_once_t = 0
//            static var instance : Singleton? = nil
//        }
//        dispatch_once(&Static.onceToken) {
//            Static.instance = Singleton()
//        }
//        return Static.instance!
//    }
//}
