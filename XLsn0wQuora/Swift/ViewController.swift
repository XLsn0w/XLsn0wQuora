//
//  ViewController.swift
//  XLsn0wApplication
//
//  Created by XLsn0w on 2017/5/27.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

import UIKit
import XLsn0wKit_swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        func inoutFunc(_ i: inout Int) {
            i += 1
        }
        
        
//        堆（heap）：堆是用于存放进程运行中被动态分配的内存段，它的大小并不固定，可动态扩张或缩减。当进程调用malloc等函数分配内存时，新分配的内存就被动态添加到堆上（堆被扩张）；当利用free等函数释放内存时，被释放的内存从堆中被剔除（堆被缩减）
//        栈 (stack)：栈又称堆栈， 是用户存放程序临时创建的局部变量，也就是说我们函数括弧“{}”中定义的变量（但不包括static声明的变量，static意味着在数据段中存放变 量）。除此以外，在函数被调用时，其参数也会被压入发起调用的进程栈中，并且待到调用结束后，函数的返回值也会被存放回栈中。由于栈的先进先出特点，所以 栈特别方便用来保存/恢复调用现场。从这个意义上讲，我们可以把堆栈看成一个寄存、交换临时数据的内存区。
//        当程序在执行时动态分配空间（C中的malloc函数），所分配的空间就属于heap。其概念与数据结构中“堆”的概念不同。
        
        var x = 0
        inoutFunc(&x)
        print(x)
        //输出结果：“1”
        //参数x传入到inc函数中后，在函数内被修改为1，函数返回时这个值(1)覆盖了原来的x的值(0)，所以x变成了1。

        let myClosure = {(num1: Int, num2: Int) -> Int  in
            return num1 + num2;
        }
        
        XLsn0wLog(myClosure(10, 10))

        DispatchQueue.global().async {
//            全局队列是并发队列，并由整个进程共享，可传入优先级来访问队列。存在三个全局队列：高、中（默认）、低三个优先级队列。
        }

        DispatchQueue.main.async {
//            主队列是一个串行队列。无法控制主线程dispatch队列的执行继续或中断。
        }
        
//        创建队列 DispatchQueue的默认初始化方法创建的就是一个同步队列，如果要创建并发的队列，在attributes中声明concurrent。
        
        // 串行队列
        let serialQueue = DispatchQueue(label: "queuename")
        serialQueue.sync {
 
            XLsn0wLog("serialQueue")
        }
        
        // 并发队列
        let concurrentQueue = DispatchQueue(label: "queuename", attributes: .concurrent)
        concurrentQueue.async {
            XLsn0wLog("concurrentQueue")
        }
        
        let delay = DispatchTime.now() + DispatchTimeInterval.seconds(10)
        
        DispatchQueue.main.asyncAfter(deadline: delay) {
            // 延迟
            XLsn0wLog("delay")
        }
        
        
        DispatchQueue.AutoreleaseFrequency.inherit
        
        simpleMax(17, 42) // T 被推断为 Int 类型
        simpleMax(3.14159, 2.71828) // T 被推断为 Double 类型
    }
    
/*
     swift 3中对C层级的GCD的API进行了彻头彻尾的改变。本文将从实际使用场景来了解一下新的api使用。
     
     dispatch_async
     一个常见的场景就是在一个全局队列进行一些操作后切换到主线程配置UI。现在是这么写：
     
     DispatchQueue.global().async {
     // code
     DispatchQueue.main.async {
     // 主线程中
     }
     }
     global()是一个有着默认参数的静态函数：
     
     class DispatchQueue : DispatchObject {
     public  class var main: DispatchQueue
     public class func global(qos: DispatchQoS.QoSClass = default) -> DispatchQueue
     }
     sync
     如果想同步执行操作，和async类似，调用sync就可以了：
     
     DispatchQueue.global().sync {
     // 同步执行
     }
     优先级：DispatchQoS
     我们知道，GCD 的默认队列优先级有四个：
     
     DISPATCH_QUEUE_PRIORITY_HIGH
     DISPATCH_QUEUE_PRIORITY_DEFAULT
     DISPATCH_QUEUE_PRIORITY_LOW
     DISPATCH_QUEUE_PRIORITY_BACKGROUND
     现在则改为了QoSClass枚举
     
     public enum QoSClass {
     
     case background
     
     case utility
     
     case `default`
     
     case userInitiated
     
     case userInteractive
     
     case unspecified
     
     public init?(rawValue: qos_class_t)
     
     public var rawValue: qos_class_t { get }
     }
     这些命名比原先的更加友好，能更好表达这个操作的意图。
     
     225849-a1874612db1bc1ba.png
     
     和原有的对应关系是：
     
     * DISPATCH_QUEUE_PRIORITY_HIGH:         .userInitiated
     * DISPATCH_QUEUE_PRIORITY_DEFAULT:      .default
     * DISPATCH_QUEUE_PRIORITY_LOW:          .utility
     * DISPATCH_QUEUE_PRIORITY_BACKGROUND:   .background
     创建队列
     DispatchQueue的默认初始化方法创建的就是一个同步队列，如果要创建并发的队列，在attributes中声明concurrent。
     
     // 同步队列
     let serialQueue = DispatchQueue(label: "queuename")
     
     // 并发队列
     let concurrentQueue = DispatchQueue(label: "queuename", attributes: .concurrent)
     推迟时间后执行
     原先的dispatch_time_t现在由DispatchTime对象表示。可以用静态方法now获得当前时间，然后再通过加上一个DispatchTimeInterval枚举来获得一个需要延迟的时间。
     
     let delay = DispatchTime.now() + DispatchTimeInterval.seconds(60)DispatchQueue.main.asyncAfter(deadline: delay) {
     // 延迟执行}
     这里也可以直接加上一个秒数。
     
     let three = DispatchTime.now() + 3.0
     因为DispatchTime中自定义了+号。
     
     public func +(time: DispatchTime, seconds: Double) -> DispatchTime
     DispatchGroup
     如果想在dispatch_queue中所有的任务执行完成后再做某种操作可以使用DispatchGroup。原先的dispatch_group_t由现在的DispatchGroup对象代替。
     
     let group = DispatchGroup()
     
     let queueBook = DispatchQueue(label: "book")
     queueBook.async(group: group) {
     // 下载图书
     }
     let queueVideo = DispatchQueue(label: "video")
     queueVideo.async(group: group) {
     // 下载视频
     }
     
     group.notify(queue: DispatchQueue.main) {
     // 下载完成
     }
     DispatchGroup会在组里的操作都完成后执行notify。
     如果有多个并发队列在一个组里，我们想在这些操作执行完了再继续，调用wait
     
     group.wait()
     DispatchWorkItem
     使用DispatchWorkItem代替原来的dispatch_block_t。
     在DispatchQueue执行操作除了直接传了一个() -> Void类型的闭包外，还可以传入一个DispatchWorkItem。
     
     public func sync(execute workItem: DispatchWorkItem)
     
     public func async(execute workItem: DispatchWorkItem)
     DispatchWorkItem的初始化方法可以配置Qos和DispatchWorkItemFlags，但是这两个参数都有默认参数，所以也可以只传入一个闭包。
     
     public init(qos: DispatchQoS = default, flags: DispatchWorkItemFlags = default, block: @escaping @convention(block) () -> ())
     
     let workItem = DispatchWorkItem {
     // TODO:
     }
     DispatchWorkItemFlags枚举中assignCurrentContext表示QoS根据创建时的context决定。
     值得一提的是DispatchWorkItem也有wait方法，使用方式和group一样。调用会等待这个workItem执行完。
     
     let myQueue = DispatchQueue(label: "my.queue", attributes: .concurrent)
     let workItem = DispatchWorkItem {
     sleep(1)
     print("done")
     }
     myQueue.async(execute: workItem)
     print("before waiting")
     workItem.wait()
     print("after waiting")
     barrier
     假设我们有一个并发的队列用来读写一个数据对象。如果这个队列里的操作是读的，那么可以多个同时进行。如果有写的操作，则必须保证在执行写入操作时，不会有读取操作在执行，必须等待写入完成后才能读取，否则就可能会出现读到的数据不对。在之前我们用dipatch_barrier实现。
     现在属性放在了DispatchWorkItemFlags里。
     
     let wirte = DispatchWorkItem(flags: .barrier) {
     // write data}let dataQueue = DispatchQueue(label: "data", attributes: .concurrent)
     dataQueue.async(execute: wirte)
     信号量
     为了线程安全的统计数量，我们会使用信号量作计数。原来的dispatch_semaphore_t现在用DispatchSemaphore对象表示。
     初始化方法只有一个，传入一个Int类型的数。
     
     let semaphore = DispatchSemaphore(value: 5)
     
     // 信号量减一
     semaphore.wait()
     
     //信号量加一
     semaphore.signal()
     dispatch_once被废弃
     在swift 3中已经被废弃了。
     简单的建议就是一些初始化场景就用懒加载吧。
     
     // Examples of dispatch_once replacements with global or static constants and variables. 
     // In all three, the initialiser is called only once. 
     
     // Static properties (useful for singletons).
     class Object {
     static let sharedInstance = Object()
     }
     
     // Global constant.
     let constant = Object()
     
     // Global variable.
     var variable: Object = {
     let variable = Object()
     variable.doSomething()
     return variable
     }()
     */
    
    
    func simpleMax<T:Comparable>(_ x: T, _ y: T) -> () {
        guard x >= y else {
            print(y)
            return
        }
        
        
//        guard condition else {
//            statements
//        }
        
        print(x)
    }
    
    

    
    


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

