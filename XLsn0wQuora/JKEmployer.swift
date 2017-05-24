
import UIKit

class JKEmployer: NSObject {
    
    
    // weak类型，防止循环引用
    weak var delegate: JKEmployerDelegate?
    weak var dataSource: JKEmployerOptionalDelegate? //申明属性
    
    func activateDelegateFunc(str: String) -> Void {
        self.delegate?.jkDelegateFunc(str: str)
    }
    
    func activateOptionalDelegateFunc(str: String) -> Void {
        
        // 调用可选方法，函数方法后面要用?而不是！，不然会崩
        self.dataSource?.jkOptionalDelegateFunc?(str: str)
        
        let value = self.dataSource?.jkOptionalDelegateFun?(str: str)
        XLsn0wLog(printObject: value)
    }
    
    
}

// 必须实现的协议
protocol JKEmployerDelegate: NSObjectProtocol {

    // 必须实现的协议方法  可命名：func jkDelegateFunc(str: String)
    func jkDelegateFunc(str: String) -> Void
}


// 可选的协议
@objc protocol JKEmployerOptionalDelegate: NSObjectProtocol {
    
    // 1. 可选方法必须在协议protocol前面加 @objc
    // 2. func前面也加上 @objc optional
    @objc optional func jkOptionalDelegateFunc(str: String)
    
    // 带返回值
    @objc optional func jkOptionalDelegateFun(str: String) -> String
}

















