//
//  Heap.m
//  XLsn0wApplication
//
//  Created by XLsn0w on 2017/6/1.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

#import "Heap.h"
#import <objc/runtime.h>
#import "Person.h"

@implementation Heap

+ (void)load {
    
//    dispatch_queue_t queue = dispatch_queue_create("com.sharemerge.gcd", NULL);
//    dispatch_async(queue,^ {
//        /*
//         1. 执行图片数据下载
//         2. 将下载好的数据流转换成UIImage
//         */
//        dispatch_async(dispatch_get_main_queue(),^{
//            /*
//             将转换后的UIImage绑定到UIImageView是
//             */
//        });
//    }
    
 
                   
//#pragma mark - 对象及对象的实例变量在堆中的地址
//    /**
//     * 定义Person类: 实例变量可见度为 @public
//     * 详见 Person类 文件
//     */
//    
//    /** 创建对象Person1, 并赋值 */
//    Person *person1 = [[Person alloc] init];
//    person1.name = @"zhangsan";
//    person1.sex = @"male";
//    person1.age = 18;
//    
//#pragma mark - 显示对象大小的函数
//    /** 直接显示 对象大小 . 需要导入<objc/runtime.h> 文件 */
//    NSLog(@"size:%ld", class_getInstanceSize([person1 class]));
//    
//    NSLog(@"---%d---(person1)对象和对象的实例变量在堆中的地址---", __LINE__);
//    NSLog(@"person1      add:%p", person1);
//    NSLog(@"person1 name add:%p", &person1.name);
//    NSLog(@"person1 age  add:%p", &_age);
//    NSLog(@"person1 sex  add:%p", &person1.sex);
//    
//    NSLog(@"---如果实例变量类型是对象类型, 指针内容是一个指针---");
//    NSLog(@"---%d---(person1)实例变量的指针指向的地址---", __LINE__);
//    NSLog(@"person1 name contant :%p", person1->_name);
//    NSLog(@"person1 sex  contant :%p", person1->_sex);
//    NSLog(@"字符串(zhangsan)   add:%p", @"zhangsan");
//    NSLog(@"字符串(male)       add:%p", @"male");  /**< 结论实例变量的指针最终指向了字符串常量首地址 */
//    
//    NSLog(@"---如果实例变量类型是非对象类型, 指针内容即为值---");
//    NSLog(@"person1 age  contant :%ld", (long)person1->_age);//get方法是不能获取地址的
//    NSLog(@"person1 age  contant :%ld", person1->_age);
//    
//    
//    /** 创建另一个对象Person2 */
//    Person *person2 = [[Person alloc] init];
//    person2 = person1;
//    
//    NSLog(@"---%d---(person2)对象和对象的实例变量在堆中的地址---", __LINE__);
//    NSLog(@"person2      add:%p", person2);
//    NSLog(@"person2 name add:%p", &person2->_name);
//    NSLog(@"person2 age  add:%p", &person2->_age);
//    NSLog(@"person2 sex  add:%p", &person2->_sex);  /**< 结论.person2 指向了person1的首地址person2 的实例变量地址也指向person1 的实例变量首地址 */
//    
//    NSLog(@"---%d---(person2)实例变量的指针指向的地址---", __LINE__);
//    NSLog(@"person2 name contant :%p", person2->_name);
//    NSLog(@"person2 sex  contant :%p", person2->_sex);
//    NSLog(@"字符串(zhangsan)   add:%p", @"zhangsan");
//    NSLog(@"字符串(male)       add:%p", @"male");
//    
//    
//    /* 使用copy方法创建person3 对象 */
//    Person *person3 = [person1 copy];
//    
//    NSLog(@"---%d---(person3)对象和对象的实例变量在堆中的地址---", __LINE__);
//    NSLog(@"person3      add:%p", person3);
//    NSLog(@"person3 name add:%p", &person3->_name);
//    NSLog(@"person3 age  add:%p", &person3->_age);
//    NSLog(@"person3 sex  add:%p", &person3->_sex);
//    
//    
//    NSLog(@"---%d---(person3)实例变量的指针指向的地址---", __LINE__);
//    NSLog(@"person3 name contant :%@", person3.name);
//    NSLog(@"person3 sex  contant :%p", person3->_sex);
//    NSLog(@"字符串(zhangsan)   add:%p", @"zhangsan");
//    NSLog(@"字符串(male)       add:%p", @"male");
}

@end
