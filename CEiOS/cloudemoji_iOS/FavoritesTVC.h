//
//  FavoritesTVC.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-31.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineLibraryCell.h"
#import "NoneView.h"
@protocol FavoritesTVCDelegate <NSObject>
- (void)loadInfo:(NSString*)type;
@end

@interface FavoritesTVC : UIViewController <OnlineLibraryCellDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) NSMutableArray *height;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) id<FavoritesTVCDelegate> delegate;
@property (nonatomic, retain) NoneView *noneview;
- (void)load;
@end
