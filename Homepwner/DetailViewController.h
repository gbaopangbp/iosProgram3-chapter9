//
//  DetailViewController.h
//  Homepwner
//
//  Created by tirostiros on 15-1-17.
//  Copyright (c) 2015年 cn.com.tiros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNRItem.h"

@interface DetailViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic,strong)BNRItem *item;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UITextField *dataField;

@end
