//
//  BNRItem.m
//  BNRItem
//
//  Created by tirostiros on 14-12-25.
//  Copyright (c) 2014年 cn.com.tiros. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

//这个文件的保存方式，使用归档和解档方式保存
//图片使用写文件方式，
//还可以使用core data
//简单的设置可以使用偏好设置保存

+(id)randomItem
{
    NSArray *nameArray = @[@"LiLei",@"HanMeiMei",@"Lucy"];
    NSArray *locationArray = @[@"Beijing",@"ShangHai",@"NewYork"];
    
    int nameIndex = rand()%[nameArray count];
    int locationIndex = rand()%[locationArray count];
    NSString *name = [NSString stringWithFormat:@"%@-%@",nameArray[nameIndex],locationArray[locationIndex]];
    int value = rand()%100;
    NSString *serial = [NSString stringWithFormat:@"%c%c%c%c%c",
                        '0'+rand()%10,
                        'A'+rand()%26,
                        '0'+rand()%10,
                        'A'+rand()%26,
                        '0'+rand()%10];
    return [[self alloc] initWithItemName:name valueInDollars:value serialNumber:serial];
}

-(id)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber
{
    self = [super init];
    if (self)
    {
        self.itemName = name;
        self.valueInDollars = value;
        self.serialNumber = sNumber;
        self.dateCreated = [[NSDate alloc] init];
    }
    return self;
}

-(id)initWithItemName:(NSString *)name serialNumber:(NSString *)sNumber
{
    return [self initWithItemName:name valueInDollars:0 serialNumber:sNumber];
}

-(id)initWithItemName:(NSString *)name
{
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}

-(id)init
{
    return [self initWithItemName:@"Item" valueInDollars:0 serialNumber:@""];
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"name:%@,value:%d,serialNumber:%@",self.itemName,self.valueInDollars,self.serialNumber];
}

#pragma mark-nscoding协议
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.itemName forKey:@"name"];
    [aCoder encodeObject:self.serialNumber forKey:@"serial"];
    [aCoder encodeObject:self.dateCreated forKey:@"date"];
    [aCoder encodeObject:self.imageKey forKey:@"key"];
    [aCoder encodeInt:self.valueInDollars forKey:@"value"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        [self setItemName:[aDecoder decodeObjectForKey:@"name"]];
        [self setSerialNumber:[aDecoder decodeObjectForKey:@"serial"]];
        [self setDateCreated:[aDecoder decodeObjectForKey:@"date"]];
        [self setImageKey:[aDecoder decodeObjectForKey:@"key"]];
        [self setValueInDollars:[aDecoder decodeIntForKey:@"value"]];
    }
    return self;
}


@end
