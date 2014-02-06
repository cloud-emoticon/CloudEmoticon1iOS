//
//  Custom.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-9.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "Custom.h"

@interface Custom ()

@end

@implementation Custom

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isEdit = NO;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!self.isEdit) {
        self.rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightbtn:)];
        self.navigationItem.rightBarButtonItem = self.rightbtn;
        
        self.vc = [[CustomTVC alloc] init];
        self.vc.delegate = self;
        [self.view addSubview:self.vc.view];
        [super viewWillAppear:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (!self.isEdit) {
        self.vc.delegate = nil;
        self.navigationItem.rightBarButtonItem = nil;
        self.rightbtn = nil;
        [self.vc.view removeFromSuperview];
        self.vc = nil;
        [super viewWillDisappear:YES];
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

- (void)openEditWindow:(UIViewController*)editVC
{
    [self.navigationController pushViewController:editVC animated:YES];
//    [self presentViewController:editVC animated:YES completion:^{
//        //[editVC.edit becomeFirstResponder];
//    }];
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
