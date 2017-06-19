//
//  UIImageView+JKImage.m
//  JKImage
//
//  Created by Johnny on 14-5-29.
//  Copyright (c) 2014年 JK. All rights reserved.
//

#import "UIImageView+JKImage.h"
#import <CommonCrypto/CommonDigest.h>
#define MAXMEMERYSIZE 10

typedef void(^requestOK)(NSData *data);

@implementation UIImageView (JKImage)

- (void)showImageWith:(NSString *)url
{
    NSMutableDictionary *cache = [self memCache];
    __block UIImage *image = [cache valueForKey:[self md5:url]];
    
    if (image == nil)//如果内存没有缓存
    {
        image = [self outDisk:[self md5:url]];
        if (image == nil)
        {
            [self loadImageDataFromNetwork:url finishedBlock:^(NSData *data) {
                image = [UIImage imageWithData:data];
                [self inMenery:image url:url];//内存缓存,超过50清空再缓存,以节省内存占用
                [self inDisk:data fileName:[self md5:url]]; //本地缓存
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = image;
                    NSLog(@"从服务器端取出图片，并缓存");
                });
            }];
        }
        else
        {
            [self inMenery:image url:url];
            NSLog(@"从本地取出图片并缓存");
        }
    }
    self.image = image;
}

/*
    内存缓存，超过指定大小，整理内存空间
 */
- (void)inMenery:(UIImage *)image url:(NSString *)url
{
    NSMutableDictionary *cache = [self memCache];
    if (cache.count > MAXMEMERYSIZE)
    {
        [cache removeAllObjects];
    }
    [cache setObject:image forKey:[self md5:url]];
    NSLog(@"%d",cache.count);
}

/*
    写入图片到本地
 */
- (BOOL)inDisk:(NSData *)data fileName:(NSString *)name
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *dirCache = [[self dirDoc] stringByAppendingPathComponent:@"ImageCache"]; //指定要创建的目录路径
    [manager createDirectoryAtPath:dirCache withIntermediateDirectories:YES attributes:nil error:nil]; //创建ImageCache目录
    NSString *imagePath = [dirCache stringByAppendingPathComponent:name];//图片名
    
    NSLog(@"%@",imagePath);//test
    
    return [data writeToFile:imagePath atomically:YES]; //写入图片到disk
}

/*
    从本地取出图片
 */
- (UIImage *)outDisk:(NSString *)name;
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *dirCache = [[self dirDoc] stringByAppendingPathComponent:@"ImageCache"];
    NSString *imagePath = [dirCache stringByAppendingPathComponent:name];
    UIImage *image = nil;
    if ([manager fileExistsAtPath:imagePath]) {
       image = [UIImage imageWithContentsOfFile:imagePath];
    }
    return image;
}

/*
    从网络加载图片
 */
- (void)loadImageDataFromNetwork:(NSString *)url finishedBlock:(requestOK)block
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL *requestUrl = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    NSURLSession *session = [self session];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (!error)
        {
            block(data);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    }];
    [dataTask resume];
}

/*
    获取内存缓存单例
 */
- (NSMutableDictionary *)memCache
{
    static NSMutableDictionary *memCache = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        memCache = [NSMutableDictionary dictionaryWithCapacity:10];
    });
    
    return memCache;
}

/*
    网络请求单例
 */
- (NSURLSession *)session
{
    static NSURLSession *session;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    
    return session;
}

/*
    获取document路径
 */
- (NSString *)dirDoc
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

/*
 图片地址转换成MD5
 */
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
