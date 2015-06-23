//
//  DBCommendView.h
//  DoBe
//
//  Created by liuxuan on 15/6/4.
//  Copyright (c) 2015年 liuxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidSelectRowBlock)(NSInteger row);

@interface DBCommendView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) DidSelectRowBlock didSelectRowBlock;

@end
