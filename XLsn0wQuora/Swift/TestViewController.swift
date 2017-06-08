//
//  TestViewController.swift
//  XLsn0wNote_SnapKit
//
//  Created by XLsn0w on 2017/5/27.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    let closure =  { (_ string:String) -> String in
        return string
    }

    typealias namedFishesType = (first:String, second:String, third:String)
    let namedFishes: namedFishesType = ("cod", "dab", "eel")
    
    //1. 给一个数组，要求写一个函数，交换数组中的两个元素 ///Swift的泛型和Tuple
    func exchange<T>(_ array: inout [T], _ a:Int, _ b:Int) -> Void {
        (array[a], array[b]) = (array[b], array[a])
    }

    /*
     2. 下面代码有什么问题
     
     public class Node {
     public var value: Int
     public var prev: Node?
     public var post: Node?
     
     public init(_ value: Int) {
     self.value = value
     }
     }
     答案：应该在 var prev 或者 var post 前面加上 weak。
     原因：表面上看，以上代码毫无问题。但是我这样一写，问题就来了：
     let head = Node(0)
     let tail = Node(1)
     head.post = tail
     tail.prev = head
     此时，head 和 tail 互相指向，形成循环引用（retain cycle）。
     
     public weak var prev: Node?
     public var post: Node?
     */
     
     //3. 实现一个函数，输入是任一整数，输出要返回输入的整数 + 2
     //这时面试官会问，假如我要实现返回 + 6, + 8 的操作呢？能不能只定义一次方法呢？正确的写法是利用 Swift 的柯西特性：
     func add(_ num: Int) -> (Int) -> Int {
        return { val in
            return num + val
        }
     }
     
     //let addTwo = add(2), addFour = add(4), addSix = add(6), addEight = add(8)
     
     //4. 精简以下代码
     
    func divide(dividend: Double?, by divisor: Double?) -> Double? {
        if dividend == nil {
            return nil
        }
        if divisor == nil {
            return nil
        }
        if divisor == 0 {
            return nil
        }
        return dividend! / divisor!
    }
     //这题考察的是 guard let 语句以及 optional chaining，最佳答案是
    func divide2(dividend: Double?, by divisor: Double?) -> Double? {
        guard let dividend = dividend, let divisor = divisor, divisor != 0 else {
            return nil
        }
        return dividend / divisor
    }
     
     //5. 以下函数会打印出什么？
     
//    var car = "Benz"
//    let closure = { [car] in
//        print("I drive \(car)")
//    }
//    car = "Tesla"
//    closure()
    //因为 clousre 已经申明将 car 复制进去了（[car]），此时clousre 里的 car 是个局部变量，不再与外面的 car有关，所以会打印出"I drive Benz"。
    
    //将题目略作修改如下：
//    var car = "Benz"
//    let closure = {
//        print("I drive \(car)")
//    }
//    car = "Tesla"
//    closure()
//     此时 closure 没有申明复制拷贝 car，所以clousre 用的还是全局的 car 变量，此时将会打印出 "I drive Tesla"
    
     //6. 以下代码会打印出什么？
     
//    protocol Pizzeria {
//        func makePizza(_ ingredients: [String])
//        func makeMargherita()
//    }
//    
//    extension Pizzeria {
//        func makeMargherita() {
//            return makePizza(["tomato", "mozzarella"])
//        }
//    }
//    
//    struct Lombardis: Pizzeria {
//        func makePizza(_ ingredients: [String]) {
//            print(ingredients)
//        }
//        func makeMargherita() {//在Lombardis的代码中，重写了makeMargherita的代码，所以永远调用的是Lombardis 中的 makeMargherita。
//            return makePizza(["tomato", "basil", "mozzarella"])
//        }
//    }
//     
//    let lombardis1: Pizzeria = Lombardis()
//    let lombardis2: Lombardis = Lombardis()
//    lombardis1.makeMargherita()
//    lombardis2.makeMargherita()
//     答案：打印出如下两行
//     ["tomato", "basil", "mozzarella"]
//     ["tomato", "basil", "mozzarella"]
    
    
//    再进一步，我们把 protocol Pizzeria 中的 func makeMargherita() 删掉，代码变为
//    protocol Pizzeria {
//        func makePizza(_ ingredients: [String])
//    }
//    
//    extension Pizzeria {
//        func makeMargherita() {
//            return makePizza(["tomato", "mozzarella"])
//        }
//    }
//    
//    struct Lombardis: Pizzeria {
//        func makePizza(_ ingredients: [String]) {
//            print(ingredients)
//        }
//        func makeMargherita() {
//            return makePizza(["tomato", "basil", "mozzarella"])
//        }
//    }
//     let lombardis1: Pizzeria = Lombardis()
//     let lombardis2: Lombardis = Lombardis()
//     lombardis1.makeMargherita()
//     lombardis2.makeMargherita()
//     这时候打印出如下结果：
//     ["tomato", "mozzarella"]
//     ["tomato", "basil", "mozzarella"]
//     因为lombardis1 是 Pizzeria，而 makeMargherita() 有默认实现，这时候我们调用默认实现。
    
//     7. Swift 中定义常量和 Objective-C 中定义常量有什么区别？
//     
//     一般人会觉得没有差别，因为写出来好像也确实没差别。
//     OC是这样定义常量的：
//     const int number = 0;
//     Swift 是这样定义常量的：
//     let number = 0
//     首先第一个区别，OC中用 const 来表示常量，而 Swift 中用 let 来判断是不是常量。
//     上面的区别更进一步说，OC中 const 表明的常量类型和数值是在 compilation time 时确定的；而 Swift 中 let 只是表明常量（只能赋值一次），其类型和值既可以是静态的，也可以是一个动态的计算方法，它们在 runtime 时确定的。
    
//     8. Swift 中 struct 和 class 什么区别？举个应用中的实例
//     
//     struct 是值类型，
//     class  是引用类型。
//     看过WWDC的人都知道，struct 是苹果推荐的，原因在于它在小数据模型传递和拷贝时比 class 要更安全，在多线程和网络请求时尤其好用。我们来看一个简单的例子：
//    
//    class A {
//        var val = 1
//    }
//    
//    var a = A()
//    var b = a
//    b.val = 2
//    此时 a 的 val 也被改成了 2，因为 a 和 b 都是引用类型，本质上它们指向同一内存。解决这个问题的方法就是使用 struct：
//    struct A {
//        var val = 1
//    }
//    
//    var a = A()
//    var b = a
//    b.val = 2
//     此时 A 是struct，值类型，b 和 a 是不同的东西，改变 b 对于 a 没有影响。
    
     /*9. Swift 到底是面向对象还是函数式的编程语言？
     
     Swift 既是面向对象的，又是函数式的编程语言。
     说 Swift 是 Object-oriented，是因为 Swift 支持类的封装、继承、和多态，从这点上来看与 Java 这类纯面向对象的语言几乎毫无差别。
     说 Swift 是函数式编程语言，是因为 Swift 支持 map, reduce, filter, flatmap 这类去除中间状态、数学函数式的方法，更加强调运算结果而不是中间过程。
    */

}
