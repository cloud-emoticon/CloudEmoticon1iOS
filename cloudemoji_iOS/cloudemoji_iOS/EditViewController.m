//
//  EditViewController.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-6.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "EditViewController.h"
#import "BackgroundImg.h"
#import "ProgressHUD.h"
@interface EditViewController ()

@end

@implementation EditViewController
@synthesize edit,bga,title,ename,rightbtn,tagStr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        BackgroundImg *bg = [[BackgroundImg alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [bg loadSetting:1];
        [bg loadSettingImg:1];
        [self.view addSubview:bg];
        
        //bga = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, self.view.frame.size.height - 140)];
        ename = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 20)];
        ename.backgroundColor = [UIColor whiteColor];
        ename.alpha = 0.9;
        ename.placeholder = @"无标题颜文字";
        ename.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        bga = [[UIView alloc] initWithFrame:CGRectMake(10, 30, self.view.frame.size.width - 20, self.view.frame.size.height * 0.37 - 20)];
        bga.backgroundColor = [UIColor whiteColor];
        bga.alpha = 0.5;
        edit = [[UITextView alloc] initWithFrame:bga.frame];
        edit.backgroundColor = [UIColor clearColor];
//        edit.delegate = self;
        [self.view addSubview:ename];
        [self.view addSubview:bga];
        [self.view addSubview:edit];
        
        rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(rightbtn:)];
        self.navigationItem.rightBarButtonItem = rightbtn;
        UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftbtn:)];
        //[self.rightbtn setEnabled:NO];
        self.navigationItem.leftBarButtonItem = leftbtn;
        
        self.navigationItem.leftBarButtonItem.title = @"保存";
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
        {
            PMCustomKeyboard *customKeyboard = [[PMCustomKeyboard alloc] init];
            [customKeyboard setTextView:edit];
        }
        else {
            PKCustomKeyboard *customKeyboard = [[PKCustomKeyboard alloc] init];
            [customKeyboard setTextView:edit];
        }
        
        [edit becomeFirstResponder];
    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    NSString *tmpStr = @"" ;
//    tmpStr = edit.text;
//    tmpStr = [tmpStr stringByReplacingCharactersInRange:range withString:string];
//    NSLog(@"tmpStr=%@",tmpStr);
    
//    NSString *nowTxt = [NSString stringWithFormat:@"%@%@",edit.text,text];
//    if ([tmpStr length] == 0) {
//        [self.rightbtn setEnabled:NO];
//    } else {
//        [self.rightbtn setEnabled:YES];
//    }
    return YES;
}

//- (void)keyboardWillChangeFrame:(NSNotification *)notification
//{
//    NSDictionary *info = [notification userInfo];
//    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y + 50;
//    CGRect inputFieldRect = bga.frame;
//    inputFieldRect.size.height += yOffset;
//    [UIView animateWithDuration:duration animations:^{
//        edit.frame = inputFieldRect;
//        bga.frame = inputFieldRect;
//    }];
//}

- (void)close
{
    self.navigationController.navigationBar.translucent = YES;
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
}

- (void)leftbtn:(id)sender
{
    [self close];
}

- (void)rightbtn:(id)sender
{
    if (edit.text.length == 0) {
        [ProgressHUD showError:@"还没有输入任何内容呢~"];
    } else {
        NSArray *item = [NSArray arrayWithObjects:@"<USER>",ename.text,edit.text,tagStr, nil];
        [self.delegate addData:item];
        [self close];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
