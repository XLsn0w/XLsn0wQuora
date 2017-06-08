//
//  Person.h
//  XLsn0wApplication
//
//  Created by XLsn0w on 2017/6/1.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *sex;
@property (assign, nonatomic) NSInteger age;


@property (retain, nonatomic) NSString *retainString;
@property (copy, nonatomic) NSString *string_copy;

@end
