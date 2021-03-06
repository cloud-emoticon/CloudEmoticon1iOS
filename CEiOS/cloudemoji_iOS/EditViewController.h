//
//  EditViewController.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-6.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PKCustomKeyboard.h"
//#import "PMCustomKeyboard.h"

@protocol EditViewControllerDelegate <NSObject>
- (void)addData:(NSArray*)arr;
- (void)EditViewClose;
@end

@interface EditViewController : UIViewController //<UITextViewDelegate>
@property (nonatomic, assign) id<EditViewControllerDelegate> delegate;
@property (nonatomic, retain) UIBarButtonItem *rightbtn;
@property (nonatomic, retain) UITextView *edit;
@property (nonatomic, retain) UITextField *ename;
@property (nonatomic, retain) UIView *bga;
@property (nonatomic, retain) NSString *tagStr;
@property (nonatomic, retain) UIBarButtonItem *tmpRightBtn;
- (void)rightbtn:(id)sender;
- (void)leftbtn:(id)sender;
@end
