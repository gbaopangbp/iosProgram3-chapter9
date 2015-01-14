//
//  BNRItemStore.h
//  Homepwner
//
//  Created by tirostiros on 15-1-13.
//  Copyright (c) 2015年 cn.com.tiros. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;


@interface BNRItemStore : NSObject

+(id)shareBNRItemStore;
-(NSArray *)allItems;
-(BNRItem *)createItem;

@end
