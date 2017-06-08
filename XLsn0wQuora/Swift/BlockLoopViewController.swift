
import UIKit
import Dispatch

class BlockLoopViewController: UIViewController {
    
    var block_One: ((_ text:String) -> String?)?
    
    var closureA: ()?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red

        
        typealias MyClosureType = (Int, Int) -> Int
//        var myCloure:MyClosureType?
        
        
       let myClosure = { (num1: Int, num2: Int) -> Int  in
            return num1 + num2;
        }
 
        myClosure(10, 10)

        /* 方案6.推荐    先弱后强*/
        weak var weakSelf = self
        self.block_One = {(text) -> String? in
            guard let strongSelf = weakSelf else {
                return nil
            }
            strongSelf.view.backgroundColor = UIColor.white
            return text
        }
     
        
    }

    
    final func escapingBlock(WithParamter param: String,block: @escaping((_ str: String) -> Void)) -> String{
        var temp = "测试"
        DispatchQueue.global().async {
            for i in 0...30{
                temp += "\(i)"
                
                if i == 29 {
                    DispatchQueue.main.async {
                        block(temp)
                    }
                }
            }
        }
        return temp
    }
    
    
    final func nonescapingBlock(WithParamter param: String,block: (_ str: String) -> Void) -> String{
        var temp = "测试"
//        DispatchQueue.global().async {
            for i in 0...30{
                temp += "\(i)"
                
                if i == 29 {
//                    在GCD多线程的Block中使用block会被强制使用@escaping，否则会报错
//                    DispatchQueue.main.async {
                        block(temp)
//                    }
                }
            }
//        }
        
        

        
        return temp
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let str = self.block_One?("参数Str1") {
            print("\(str)")
        }
        
    }
    
}
