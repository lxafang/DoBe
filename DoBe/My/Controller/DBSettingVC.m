//
//  DBSettingVC.m
//  DoBe
//
//  Created by liuxuan on 15/6/3.
//  Copyright (c) 2015年 liuxuan. All rights reserved.
//

#import "DBSettingVC.h"

@interface DBSettingVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DBSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self showBackButton];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self setExtraCellLineHidden:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 2;
    if (section == 2) {
        count = 6;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"SettingCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    [cell.textLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:15.0f]];
    if (section == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (row == 0) {
            [cell.textLabel setText:[DBUser sharedInstance].name];
            [cell.detailTextLabel setText:@"退出登录"];
            [cell.detailTextLabel setTextColor:kOrangeColor];
        }else {
            [cell.textLabel setText:@"绑定设计账号"];
        }
        
    }else if (section == 1) {
        if (row == 0) {
            [cell.textLabel setText:@"清理缓存"];
        }else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell.textLabel setText:@"离线下载管理"];
        }
        
    }else {
        
        switch (row) {
            case 0:{
                [cell.textLabel setText:@"字体大小"];
            }
                break;
            case 1:{
                [cell.textLabel setText:@"图片显示"];

            }
                break;
            case 2:{
                [cell.textLabel setText:@"夜间模式"];

            }
                break;
            case 3:{
                [cell.textLabel setText:@"划屏切换文章"];

            }
                break;
            case 4:{
                [cell.textLabel setText:@"通知推送"];

            }
                break;
            case 5:{
                [cell.textLabel setText:@"推送声音"];

            }
                break;
                
            default:
                break;
        }
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        return 30.0f;
    }
    return 0.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
