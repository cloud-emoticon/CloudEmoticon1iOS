//
//  Favorites.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-9.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "Favorites.h"
@interface Favorites ()

@end

@implementation Favorites

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
<<<<<<< HEAD
        self.view.backgroundColor = [UIColor whiteColor];
=======
        self.view.backgroundColor = [UIColor orangeColor];
>>>>>>> FETCH_HEAD
    }
    return self;
}

kROTATE

- (void)va
{
    self.vc = [[FavoritesTVC alloc] init];
    self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, 30);
    [self.view addSubview:self.vc.view];
    self.vc.view.frame = self.view.frame;
    [self.vc load];
}
- (void)vd
{
    [self.vc.view removeFromSuperview];
    self.vc = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
