//
//  Custom.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-9.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "Custom.h"
//#import "EditViewController.h"

@interface Custom ()

@end

@implementation Custom

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//<<<<<<< HEAD
        self.view.backgroundColor = [UIColor whiteColor];
//=======
//        self.view.backgroundColor = [UIColor orangeColor];
//>>>>>>> FETCH_HEAD
        self.isEdit = NO;
    }
    return self;
}

kROTATE

- (void)va
{
    if (!self.isEdit) {
        self.rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightbtn:)];
        self.navigationItem.rightBarButtonItem = self.rightbtn;
        
        self.vc = [[CustomTVC alloc] init];
        self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, 30);
        self.vc.delegate = self;
        [self.view addSubview:self.vc.view];
        self.vc.view.frame = self.view.frame;
        [self.vc load];
    }
}

- (void)vd
{
    if (!self.isEdit) {
        self.vc.delegate = nil;
        self.navigationItem.rightBarButtonItem = nil;
        self.rightbtn = nil;
        [self.vc.view removeFromSuperview];
        self.vc = nil;
    }
}
- (void)reloadButton:(BOOL)isEdit
{
    self.isEdit = isEdit;
//    self.rightbtn = nil;
//    self.navigationItem.rightBarButtonItem = nil;
//    self.leftbtn = nil;
//    self.navigationItem.leftBarButtonItem = nil;
//    if (isEdit) {
//        self.leftbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftbtn:)];
//        self.navigationItem.leftBarButtonItem = self.leftbtn;
//        self.rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(rightbtn:)];
//        self.navigationItem.rightBarButtonItem = self.rightbtn;
//    } else {
//        self.rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightbtn:)];
//        self.navigationItem.rightBarButtonItem = self.rightbtn;
//    }
}

- (void)openEditWindow:(UIView*)editVC
{
//    if (editVC && [editVC isKindOfClass:[EditViewController class]]) {
//        NSLog(@"editVC = %@",editVC);
//        [self.navigationController pushViewController:editVC animated:YES];
//    } else {
//        NSLog(@"ERROR!!!");
//    }
    
//    [self presentViewController:editVC animated:YES completion:^{
        //[editVC.edit becomeFirstResponder];
//    }];
    self.leftbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftbtn:)];
    self.navigationItem.leftBarButtonItem = self.leftbtn;
    
    self.rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(rightbtn:)];
    self.navigationItem.rightBarButtonItem = self.rightbtn;
    [self.view addSubview:editVC];
}
- (void)closeEditWindow:(UIView*)editVC
{
//    NSLog(@"self.vc = %@",self.vc);
//    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    self.isEdit = false;
//    [self vd];
//    [self va];
//    [self.navigationController popToViewController:self.vc animated:YES];
//    [editVC dismissViewControllerAnimated:YES completion:^{
//        
//    }];
    self.rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightbtn:)];
    self.navigationItem.rightBarButtonItem = self.rightbtn;
    self.leftbtn = nil;
    self.navigationItem.leftBarButtonItem = nil;
    [editVC removeFromSuperview];
}

- (void)rightbtn:(id)sender
{
    if (self.isEdit) {
        [self.vc.edit rightbtn:self.rightbtn];
    } else {
        self.isEdit = YES;
        [self.vc rightbtn:self.rightbtn];
    }
}
- (void)leftbtn:(id)sender
{
    [self.vc.edit leftbtn:self.rightbtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
