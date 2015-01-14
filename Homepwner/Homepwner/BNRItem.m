//
//  BNRItem.m
//  BNRItem
//
//  Created by tirostiros on 14-12-25.
//  Copyright (c) 2014年 cn.com.tiros. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

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
        self.dateCreated = [[NSData alloc] init];
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

@end
