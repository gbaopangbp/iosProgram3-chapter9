//
//  ItemTableViewController.h
//  Homepwner
//
//  Created by tirostiros on 15-1-13.
//  Copyright (c) 2015年 cn.com.tiros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemTableViewController : UITableViewController
@property (strong, nonatomic)  UIView *headerView;
- (void)editButton:(id)sender;

- (void)addButton:(id)sender;
@end
