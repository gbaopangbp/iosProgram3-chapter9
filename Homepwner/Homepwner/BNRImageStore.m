//
//  BNRImageStore.m
//  Homepwner
//
//  Created by tirostiros on 15-1-24.
//  Copyright (c) 2015年 cn.com.tiros. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore()
@property(nonatomic,strong)NSMutableDictionary *images;
@end

@implementation BNRImageStore

//图片的保存直接写到文件，使用写文件的方式

-(id)init
{
    self = [super init];
    if (!_images)
    {
        _images = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+(id)BNRImageStoreShare
{
    static BNRImageStore *store = nil;
    if (!store)
    {
        //调用父类的allocwithzon创建出对象
        store = [[super allocWithZone:NULL] init];
    }
    return store;
}

//覆盖自己的方法，返回静态变量，使alloc和该方法均失效，返回静态变量
+(id)allocWithZone:(struct _NSZone *)zone
{
    return [self BNRImageStoreShare];
}

//保存到文件
-(void)setImage:(UIImage *)image forKey:(NSString *)key
{
    [self.images setValue:image forKey:key];
    NSString *path = [self getSavePathByKey:key];
    NSData *jpg = UIImageJPEGRepresentation(image, 0.5);
    [jpg writeToFile:path atomically:YES];
}

//先从内存中读取，读不到再从文件读取
-(id)getImageForKey:(NSString *)key
{
    if (!key)
    {
        return nil;
    }
    UIImage *image = [self.images valueForKey:key];
    if (!image)
    {
        NSString *path = [self getSavePathByKey:key];
        image = [UIImage imageWithContentsOfFile:path];
        [self.images setObject:image forKey:key];
    }
    return image;
}

-(void)removeImageForKey:(NSString *)key
{
    [self.images removeObjectForKey:key];
    NSString *path = [self getSavePathByKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

//获取图片存储路径
-(NSString *)getSavePathByKey:(NSString *)key
{
    //存到document文件夹下
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *path = [array objectAtIndex:0];
    return [path stringByAppendingString:key];
}

@end
