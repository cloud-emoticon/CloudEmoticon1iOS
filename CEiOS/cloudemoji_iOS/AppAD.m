//
//  AppAD.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-25.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "AppAD.h"

@interface AppAD ()

@end

@implementation AppAD

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    self.vc = [[AppADTVC alloc] init];
    [self.view addSubview:self.vc.view];
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.vc.view removeFromSuperview];
    self.vc = nil;
    [super viewWillDisappear:YES];
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
