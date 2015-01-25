//
//  DetailViewController.m
//  Homepwner
//
//  Created by tirostiros on 15-1-17.
//  Copyright (c) 2015年 cn.com.tiros. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRImageStore.h"
#import "OverLayView.h"

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
    
    [self.imageView setImage:[[BNRImageStore BNRImageStoreShare] getImageForKey:self.item.imageKey]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self view] endEditing:YES];
    
    _item.itemName = self.nameField.text;
    _item.serialNumber = self.serialField.text;
    _item.valueInDollars = [self.valueField.text intValue];
}

#pragma mark-textField协议
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    [self resignFirstResponder];
}


- (IBAction)takePic:(id)sender
{
    UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
    //设置是否允许用户自己编辑图片
    imagePick.allowsEditing = YES;

    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePick setSourceType:UIImagePickerControllerSourceTypeCamera];
        //只有拍照时才可以设置下面的悬浮view，否则会抛出异常
        OverLayView *view = [[OverLayView alloc] initWithFrame:CGRectMake(200, 200, 10, 10)];
        imagePick.cameraOverlayView = view;
    }
    else
    {
        [imagePick setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    imagePick.delegate = self;
    [self presentViewController:imagePick animated:YES completion:nil];
}

- (IBAction)deletePic:(id)sender
{
    if (self.item.imageKey)
    {
        [[BNRImageStore BNRImageStoreShare] removeImageForKey:self.item.imageKey];
        [self.imageView setImage:nil];
    }
}

#pragma mark-uiimagepickercontroller 协议
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
//    [self.imageView setImage:image];
    CFUUIDRef newID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newString = CFUUIDCreateString(kCFAllocatorDefault, newID);
    NSString *key = (__bridge NSString*)newString;
    self.item.imageKey = key;
    [[BNRImageStore BNRImageStoreShare] setImage:image forKey:key];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];

}
@end
