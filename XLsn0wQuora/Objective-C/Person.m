//
//  Person.m
//  XLsn0wApplication
//
//  Created by XLsn0w on 2017/6/1.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

- (instancetype)init {
    self = [super init];
    if (self) {
        
        
        NSMutableString *mStr = [NSMutableString string];
        
        [mStr setString:@"我没变"];
        
        self.retainString = mStr;
        self.string_copy = mStr;
        NSLog(@"retainString-> %p",  self.retainString);
        NSLog(@"copyString-> %p",    self.string_copy);
        
         NSString *str = @"我来了";
        
        self.retainString = str;
        self.string_copy = str;
        NSLog(@"retainString-> %p",  self.retainString);
        NSLog(@"copyString-> %p",    self.string_copy);
    }
    return self;
}
@end
