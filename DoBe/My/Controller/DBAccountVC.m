//
//  DBAccountVC.m
//  DoBe
//
//  Created by liuxuan on 15/6/3.
//  Copyright (c) 2015年 liuxuan. All rights reserved.
//

#import "DBAccountVC.h"

@interface DBAccountVC ()

@property (weak, nonatomic) IBOutlet UIButton *loginOutBtn;
@end

@implementation DBAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号管理";
    [self showBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginOutTouchUpInside:(id)sender {
    
    NSLog(@"退出登录");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
