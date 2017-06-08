//
//  RetainCount.h
//  XLsn0wApplication
//
//  Created by XLsn0w on 2017/5/27.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RetainCount : NSObject

@property (copy, nonatomic) NSString *name;

@end

/*
 
 一、区域划分
 
 一个C/C++编译的程序占用的内存分为以下几个部分
 
 1、栈区（stack）： 由编译器自动分配释放，存放函数的参数值、局部变量的值等，其操作方式类似于数据结构中的栈
 
 2、堆区（heap）：一般由程序员分配释放，若程序员不释放，程序结束时可能由OS回收，注意它与数据结构中的堆是两回事，分配方式倒是类似于链表
 
 3、全局区（静态区 static）： 全局变量和静态变量的存储是放在一块的，初始化的全局变量和静态变量在一块区域，未初始化的全局变量和未初始化静态变量在相邻的另一块区域，程序结束后由系统释放。
 
 4、文字常量区：常量字符串就是存放在该区，程序结束后由系统释放
 
 5、程序代码区：存放函数体的二进制代码
 
 二、堆和栈
 
 1、申请方式：
 
 栈：遵循先进后出的规则，它的生长方向是向下的，是向着内存地址减小的方向增长，栈是系统提供的功能。特点是高效快速，缺点是有限制，数据不灵活。它是由系统自动分配的
 
 堆：生长方向是向上的，也就是向着内存地址增加的方向，需要程序员自己申请，并指明大小，
 
 2、申请后系统的响应：
 
 栈：只要栈的剩余空间大于所申请的空间，系统将为程序提供内存，否则将报异常提示栈溢出
 
 堆：首先应该操作系统有一个记录空闲内存地址的链表，当系统收到程序的申请时会遍历该链表，寻找第一个空间大于所申请空间的堆节点，然后将该结点从空闲结点链表中删除，并将该结点的空间分配给程序，另外，对于大多数系统，会在这块内存空间中的首地址处记录本次分配的大小，这样代码中的delete语句才能正确的释放本内存空间，另外由于找到的堆结点的大小不一定正好等于申请的大小，系统会自动的将多余的那部分重新放入空闲链表中
 
 
 
 
 
 
 
 
 Objective-C有GC垃圾回收机制吗？
 
 GC(Garbage Collection)，垃圾回收机制，简单地说就是程序中及时处理废弃不用了的内存对象的机制，防止内存中废弃对象堆积过多造成内存泄漏。Objective-C语言本身是支持垃圾回收机制的，但有平台局限性，仅限于Mac桌面系统开发中，而在iPhone和iPad等苹果移动终端设备中是不支持垃圾回收机制的。在移动设备开发中的内存管理是采用MRC(Manual Reference Counting)以及iOS5以后的ARC(Automatic Reference Counting)，本质都是RC引用计数，通过引用计数的方式来管理内存的分配与释放，从而防止内存泄漏。
 
 另外引用计数RC和垃圾回收GC是有区别的。垃圾回收是宏观的，对整体进行内存管理，虽然不同平台垃圾回收机制有异，但基本原理都是一样的：将所有对象看做一个集合，然后在GC循环中定时检测活动对象和非活动对象，及时将用不到的非活动对象释放掉来避免内存泄漏，也就是说用不到的垃圾对象是交给GC来管理释放的，而无需开发者关心，典型的是Java中的垃圾回收机制；相比于GC，引用计数是局部性的，开发者要管理控制每个对象的引用计数，单个对象引用计数为0后会马上被释放掉。ARC自动引用计数则是一种改进，由编译器帮助开发者自动管理控制引用计数(自动在合适的时机发送release和retain消息)。另外自动释放池autorelease pool则像是一个局部的垃圾回收，将部分垃圾对象集中释放，相对于单个释放会有一定延迟。
 
 问题：
 如果一个对象释放前被加到了NotificationCenter中，不在NotificationCenter中remove这个对象可能会出现什么问题？
 
 首先对于NotificationCenter的使用，我们都知道，只要添加对象到消息中心进行通知注册，之后就一定要对其remove进行通知注销。将对象添加到消息中心后，消息中心只是保存该对象的地址，消息中心到时候会根据地址发送通知给该对象，但并没有取得该对象的强引用，对象的引用计数不会加1。如果对象释放后却没有从消息中心remove掉进行通知注销，也就是通知中心还保存着那个指针，而那个指针指的对象可能已经被释放销毁了，那个指针就成为一个野指针，当通知发生时，会向这个野指针发送消息导致程序崩溃。
 
 问题： Objective-C是如何实现内存管理的？autorealease pool自动释放池是什么？autorelease的对象是在什么时候被release的？autorelease和release有什么区别？
 
 引用计数
 
 Objective-C的内存管理本质上是通过引用计数实现的，每次RunLoop都会检查对象的引用计数，如果引用计数为0，说明该对象已经没人用了，可以对其进行释放了。其中引用计数可以大体分为三种：MRC(手动内存计数)、ARC(自动内存计数，iOS5以后)和内存池。
 
 其中引用计数是如何操作的呢？不论哪种引用计数方式，本质都是在合适的时机将对象的引用计数加1或者减1。
 
 这里简单归结一下：
 
 使对象引用计数加1的常见操作有：alloc、copy、retain
 
 使对象引用计数加1的常见操作有：release、autorealease
 自动释放池
 
 自动释放池是一个统一来释放一组对象的容器，在向对象发送autorelease消息时，对象并没有立即释放，而是将对象加入到最新的自动释放池（即将该对象的引用交给自动释放池，之后统一调用release），自动释放池会在程序执行到作用域结束的位置时进行drain释放操作，这个时候会对池中的每一个对象都发送release消息来释放所有对象。这样其实就实现了这些对象的延迟释放。
 
 自动释放池释放的时机，也就是自动释放池内的所有对象是在什么时候释放的，这里要提到程序的运行周期RunLoop。对于每一个新的RunLoop，系统都会隐式的创建一个autorelease pool，RunLoop结束时自动释放池便会进行对象释放操作。
 
 autorelease和release的区别主要是引用计数减一的时机不同,autorelease会在对象的使用真正结束的时候才做引用计数减1，而不是收到消息立马释放。
 
 retain、release和autorelease的底层实现
 
 最后通过了解这三者的较底层实现来理解它们的本质区别：
 
 -(id)retain {
 // 对象引用计数加1
 NSIncrementExtraRefCount(self);
 return self;
 }
 
 -(void)release {
 // 对象引用计数减1，之后如果引用计数为0则释放
 if(NSDecrementExtraRefCountWasZero(self)) {
 NSDeallocateObject(self);
 }
 }
 
 -(id)autorelease {
 // 添加对象到自动释放池
 [NSAutoreleasePool addObject:self];
 return self;
 }
 
 问题：
 为什么很多内置的类，如TableViewController的delegate的属性是assign不是retain?
 
 delegate代理的属性通常设置为assign或者weak是为了避免循环引用，所有的引用计数系统，都存在循环引用的问题，但也有个别特殊情况，个别类的代理例如CAAnimation的delegate就是使用strong强引用。
 
 其他问法： 委托的property声明用什么属性？为什么？
 
 问题： CAAnimation的delegate代理是强引用还是弱引用？
 
 CAAnimation的代理是强引用，是内存管理中的其中一个罕见的特例。我们知道为了避免循环引用问题，delegate代理一般都使用weak修饰表示弱引用的，而CAAnimation动画是异步的，如果动画的代理是弱应用不是强应用的话，会导致其随时都可能被释放掉。在使用动画时要注意采取措施避免循环引用，例如及时在视图移除之前的合适时机移除动画。
 
 CAAnimation的代理定义如下，明确说了动画的代理在动画对象整个生命周期间是被强引用的，默认为nil。
 
  The delegate of the animation. This object is retained for the
 * lifetime of the animation object. Defaults to nil. See below for the
 * supported delegate methods.

@property(nullable, strong) id <CAAnimationDelegate> delegate;

问题：
OC中，与alloc语义相反的方法是dealloc还是release？与retain语义相反的方法是dealloc还是release？需要与alloc配对使用的方法是dealloc还是release，为什么？

alloc与dealloc语意相反，alloc是创建变量，dealloc是释放变量；

retain与release语义相反，retain保留一个对象，调用后使变量的引用计数加1，而release释放一个对象，调用后使变量的引用计数减1。

虽然alloc对应dealloc，retain对应release，但是与alloc配对使用的方法是release，而不是dealloc。为什么呢？这要从他们的实际效果来看。事实上alloc和release配对使用只是表象，本质上其实还是retain和release的配对使用。alloc用来创建对象，刚创建的对象默认引用计数为1，相当于调用alloc创建对象过程中同时会调用一次retain使对象引用计数加1，自然要有对应的release的一次调用，使对象在不用时能够被释放掉防止内存泄漏。

此外，dealloc是在对象引用计数为0以后系统自动调用的，dealloc没有使对象引用计数减1的作用，只是在对象引用计数为0后被系统调用进行内存回收的收尾工作。

问题：
以下每行代码执行后，person对象的retain count分别是多少

Person *person = [[Person alloc] init];+1 1
[person retain]; +1 2
[person release];-1 1
[person release];-1 0

1-2-1-0。开始alloc创建对象并持有对象，初始引用计数为1，retain一次引用计数加1变为2，之后release对象两次，引用计数减1两次，先后变为1、0。

问题：执行下面的代码会发生什么后果？
Ball *ball = [[[[Ball alloc] init] autorelease] autorelease];

程序会因其而崩溃，因为对象被加入到自动释放池两次，当对象被移除时，自动释放池将其释放了不止一次，其中第二次释放必定导致崩溃。

问题：
内存管理的几条原则是什么？按照默认法则，哪些关键字生成的对象需要手动释放？哪些对象不需要手动释放会自动进入释放池？在和property结合的时候怎样有效的避免内存泄露？

当使用new、alloc或copy方法创建一个对象时，该对象引用计数器为1。如果不需要使用该对象，可以向其发送release或autorelease消息，在其使用完毕时被销毁。
如果通过其他方法获取一个对象，则可以假设这个对象引用计数为1，并且被设置为autorelease，不需要对该对象进行清理，如果确实需要retain这个对象，则需要使用完毕后release。
如果retain了某个对象，需要release或autorelease该对象，保持retain方法和release方法使用次数相等。
使用new、alloc、copy关键字生成的对象和retain了的对象需要手动释放。设置为autorelease的对象不需要手动释放，会直接进入自动释放池。
下面代码的输出依次为：

NSMutableArray* ary = [[NSMutableArray array] retain];
NSString *str = [NSString stringWithFormat:@"test"];
[str retain];
[ary addObject:str];
NSLog(@"%@%d",str,[str retainCount]);
[str retain];
[str release];
[str release];
NSLog(@"%@%d",str,[str retainCount]);
[ary removeAllObjects];
NSLog(@"%@%d",str,[str retainCount]);

2，3，1
3，2，1(right)
1，2，3
2，1，3
此问题考查的是非MRC下引用计数的使用（只有在MRC下才可以通过retain和release关键字手动管理内存对象，才可以向对象发送retainCount消息获取当前引用计数的值），开始使用类方法stringWithFormat在堆上新创建了一个字符串对象str，str创建并持有该字符串对象默认引用计数为1，之后retain使引用计数加1变为2，然后又动态添加到数组中且该过程同样会让其引用计数加1变为3(数组的add操作是添加对成员对象的强引用)，此时打印结果引用计数为3；之后的三次操作使引用计数加1后又减2，变为2，此时打印引用计数结果为2；最后数组清空成员对象，数组的remove操作会让移除的对象引用计数减1，因此str的引用计数变为了1，打印结果为1。因此先后引用计数的打印结果为：3，2，1。

这里要特别注意上面为何说stringWithFormat方法是在堆上创建的字符串对象，这里涉及到NSString的内存管理，下面单独对其进行扩展和分析。
OC中常用的创建NSString字符串对象的方法主要有以下五种：

// 字面量直接创建
NSString *str1 = @"string";
// 类方法创建
NSString *str2 = [NSString stringWithFormat:@"string"];
NSString *str3 = [NSString stringWithString:@"string"]; // 编译器优化后弃用，效果等同于str1的字面量创建方式
// 实例方法创建
NSString *str4 = [[NSString alloc] initWithFormat:@"string"];
NSString *str5 = [[NSString alloc] initWithString:@"string"]; // 编译器优化后弃用，效果等同于str1的字面量创建方式
 
开发中推荐的是前两种str1和str2的创建方式，分别用来创建不可变字符串和格式化字符串。最新的编译器优化后弃用了str3的stringWithString和str5的initWithString创建方式，现在这样创建会报警告，说这样创建是多余的，因为实际效果和直接用字面量创建相同，也都是在常量内存区创建一个不可变字符串。另外，此处由于字符串的内容都是“string”，使用str1、str3和str5创建的的字符串对象实际在常量内存区只有一个备份，这是编译器的优化效果，而str2和str4由于是在堆上创建因此各自有自己的备份。

此外最重要的是这五种方法创建的字符串对象所处的内存类型，str1、str3和str5都是创建的不可变字符串，是位于常量内存区的，由系统管理内存；stringWithFormat和initWithFormat创建的都是格式化的动态字符串对象，在堆上创建，需要手动管理内存。

相关问题：当你用stringWithString来创建一个新NSString对象的时候，你可以认为：

这个新创建的字符串对象已经被autorelease了(right)
这个新创建的字符串对象已经被retain了
全都不对
这个新创建的字符串对象已经被release了
问题：什么是安全释放？

释放掉不再使用的对象同时不会造成内存泄漏或指针悬挂问题称其为安全释放。

问题：
这段代码有什么问题,如何修改？




 */
