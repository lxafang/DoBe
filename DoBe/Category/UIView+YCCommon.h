//
//  UIView+YCCommon.h
//  iWeidao
//
//  Created by yongche_w on 14-11-3.
//  Copyright (c) 2014年 yongche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface UIView(YCCommon)

- (void)showProgressHUD;

- (void)hideProgressHUD;

- (void)showToastMessage:(NSString *)message;

@end
