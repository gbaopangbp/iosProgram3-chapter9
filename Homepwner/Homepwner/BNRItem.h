//
//  BNRItem.h
//  BNRItem
//
//  Created by tirostiros on 14-12-25.
//  Copyright (c) 2014年 cn.com.tiros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject
@property(nonatomic,strong)NSString *itemName;
@property(nonatomic,strong)NSString *serialNumber;
@property(nonatomic)int valueInDollars;
@property(nonatomic,strong)NSData *dateCreated;

+(id)randomItem;
-(id)init;
-(id)initWithItemName:(NSString*)name;
-(id)initWithItemName:(NSString*)name serialNumber:(NSString*)sNumber;
-(id)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString*)sNumber;

@end

