//
//  BNRImageStore.h
//  Homepwner
//
//  Created by tirostiros on 15-1-24.
//  Copyright (c) 2015年 cn.com.tiros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject
+(id)BNRImageStoreShare;
-(void)setImage:(UIImage*)image forKey:(NSString*)key;
-(id)getImageForKey:(NSString*)key;
-(void)removeImageForKey:(NSString*)key;

@end
