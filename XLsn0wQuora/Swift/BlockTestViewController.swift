

import UIKit

typealias JKTestBlock = (_ text:String) -> String
typealias NameCType = (_ name:String) -> String

class BlockTestViewController: UIViewController {
    
    //  ((_ block携带的参数及类型)  -> 返回类型)?这里必须可选
    var block: JKTestBlock?
    
    let 你好 = "你好世界"
    let 🐶🐮 = "dogcow"
    
    let nameClosure = {(_ name:String) -> String in
        return name
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        self.blockTest()
     
        
        typealias RuntimeBlock = (_ text:String) -> Void
        let myBlock = {(str: String) in
            print(str)
        }
        

        
        // 解决方案
        let key = UnsafeRawPointer.init(bitPattern: "key".hashValue)
        
        objc_setAssociatedObject(self, key, myBlock as AnyObject, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        
        let tempBlock:RuntimeBlock = objc_getAssociatedObject(self, key) as! RuntimeBlock
        tempBlock("Swift-Runtime-objc_setAssociatedObject")
    }
    
    // Block 闭包
    final func blockTest() {
        
        // 1.block在函数方法中的应用
        self.blockFunc(withStr: "参数Str0") { (text) in
            print("block携带的text:\(text)")
        }
        self.blockFunc(withStr: "参数", compltion: nil)
        
        
        // 2.属性Block
        self.block = {(text) -> String in
            return text
        }
        if let str = self.block?("参数Str1") {
            print("\(str)")
        }

        // 3.方法（函数）内部的Block，用于精简代码（内部可复用）
        let privateBlock = {(text:String) -> String? in
            return text
        }
        let str_copy  = privateBlock("参数Str2")
        if (str_copy != nil) {
            print(str_copy)
            
        }
        
        
 /*
         类型3.1    -> String
         let privateBlock = {(text:String) -> String in
            return text
         }
         
         
         报错
         if let str_copy = privateBlock("参数Str2") {
         print("\(str_copy)")
         }
         
         
         可用，但是会警告
         if let str_copy : String = privateBlock("参数Str2") {
            print("\(str_copy)")
         }
         
         正确写法，-> String并没有带?,所以Blcok一定会返回有效值，就不用再做判断
         let str_copy  = privateBlock("参数Str2")
         print(str_copy)
         
         
         
         
         类型3.2    -> String?
         let privateBlock = {(text:String) -> String? in
            return nil
         }
         
         必须做判断，有可能返回空值
         let str_copy  = privateBlock("参数Str2")
         if (str_copy != nil) {
            print(str_copy)
         }
         
         
         类型3.3   text:String?   -> String?都可选
         let privateBlock = {(text:String?) -> String? in
            return text  无需加!解包 or ?可选
         }
         
         
         类型3.4   text:String?   -> String
         let privateBlock = {(text:String?) -> String in
            return text!   必须解包
         }
         print(str_copy)
         
         http://www.jianshu.com/p/3a8e45af7fdd
         http://www.cnblogs.com/kenshincui/p/5594951.html
         
 */
        
        
        
        
        
        
        
    }
    
    
    //  -> Void  等同-> ()
     final func blockFunc(withStr string: String, compltion block:((_ text:String) -> ())?) {
        block?("text")
    }
    
    /*  这种写法不能给Block传nil，即compltion: nil,必须实现代码*/
     final func block(withStr string: String, compltion block:(_ text:String) -> Void) {
     print("传进来的参数string:\(string) ")
        block("text")
     }
 
    

    
    

}
