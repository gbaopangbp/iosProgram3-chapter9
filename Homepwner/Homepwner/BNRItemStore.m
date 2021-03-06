//
//  BNRItemStore.m
//  Homepwner
//
//  Created by tirostiros on 15-1-13.
//  Copyright (c) 2015年 cn.com.tiros. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore()
@property(nonatomic,strong)NSMutableArray *items;
@end

@implementation BNRItemStore



//alloc函数会调用allocWithZone，再调用c函数NSAllocateObject，用户能直接调用allocWithZone，本类设计为单例模式，
//为了防止用户通过allocWithZone创建实例，将该函数重写，调用share函数
+(id)shareBNRItemStore
{
    static BNRItemStore *store = nil;
    if (!store)
    {
        store = [[super allocWithZone:nil] init];
    }
    return store;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        NSString *path = [self getArcPath];
        _items = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (!_items) {
            _items = [[NSMutableArray alloc] init];
        }
    }
    NSLog(@"hhhh%@",_items);
    return self;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [BNRItemStore shareBNRItemStore];
}

-(NSArray *)allItems
{
    return _items;
}

-(BNRItem *)createItem
{
//    if (!_items)
//    {
//        _items = [[NSMutableArray alloc] init];
//    }
//    BNRItem *item = [BNRItem randomItem];
    BNRItem *item = [[BNRItem alloc] init];
    [_items addObject:item];
    NSLog(@"crezte num:%d",[_items count]);
    return item;
}

-(NSString *)getArcPath
{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [array objectAtIndex:0];
    return [path stringByAppendingString:@"/bnritemarc"];
}


-(void)saveItems
{
    NSString *path = [self getArcPath];
    [NSKeyedArchiver archiveRootObject:self.items toFile:path];
}


@end
