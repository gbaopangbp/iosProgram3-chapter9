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

-(void)setImage:(UIImage *)image forKey:(NSString *)key
{
    [self.images setValue:image forKey:key];
}

-(id)getImageForKey:(NSString *)key
{
    return [self.images valueForKey:key];
}

-(void)removeImageForKey:(NSString *)key
{
    [self.images removeObjectForKey:key];
}

@end
