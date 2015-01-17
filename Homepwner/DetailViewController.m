//
//  DetailViewController.m
//  Homepwner
//
//  Created by tirostiros on 15-1-17.
//  Copyright (c) 2015年 cn.com.tiros. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:_item.itemName];

    [self.nameField setText:_item.itemName];
    [self.serialField setText:_item.serialNumber];
    [self.valueField setText: [NSString stringWithFormat:@"%d",_item.valueInDollars]];
    
    NSDateFormatter *data = [[NSDateFormatter alloc] init];
    [data setTimeStyle:NSDateFormatterNoStyle];
    [data setDateStyle:NSDateFormatterShortStyle];
    [self.dataField setText:[data stringFromDate:_item.dateCreated]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self view] endEditing:YES];
    
    _item.itemName = self.nameField.text;
    _item.serialNumber = self.serialField.text;
    _item.valueInDollars = [self.valueField.text intValue];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    [self resignFirstResponder];
}


@end
