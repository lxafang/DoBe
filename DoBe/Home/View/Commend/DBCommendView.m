//
//  DBCommendView.m
//  DoBe
//
//  Created by liuxuan on 15/6/4.
//  Copyright (c) 2015年 liuxuan. All rights reserved.
//

#import "DBCommendView.h"
#import "DBNormalCell.h"
#import "DBMultiImageCell.h"

@implementation DBCommendView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubView];
    }
    return self;
}

- (void)loadSubView {
    _tableView = [[UITableView alloc] initWithFrame:self.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self addSubview:_tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"NormalCellID";
    //单图
    DBNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[DBNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell.textLabel setText:[NSString stringWithFormat:@"第%ld行",(long)indexPath.row]];
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_didSelectRowBlock) {
        _didSelectRowBlock(indexPath.row);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
