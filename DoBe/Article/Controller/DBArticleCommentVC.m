//
//  DBArticleCommentVC.m
//  DoBe
//
//  Created by liuxuan on 15/6/4.
//  Copyright (c) 2015年 liuxuan. All rights reserved.
//

#import "DBArticleCommentVC.h"
#import "DBCommentCell.h"
#import "DBCommentBottomView.h"
#import "DBCommentModel.h"

@interface DBArticleCommentVC ()<UITableViewDataSource, UITableViewDelegate> {
    
    CGFloat keyboardHeight;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) DBCommentBottomView *bottomView;

@property (nonatomic, strong) UIView *colorView;
@end

@implementation DBArticleCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文章评论";
    [self showBackButton];
    
    [self addKeyboardNotification];
    
    if (_commentList.count == 0) {
        [_tableView setHidden:YES];
        [self loadNoCommentView];
    }else {
        [_tableView setHidden:NO];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    [self loadBottomView];
    [self handleSubviewsEvent];
}

- (void)loadNoCommentView {
    UIImage *image = [UIImage imageNamed:@"comment_defaultbg"];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
}

- (void)loadBottomView {
    _bottomView = [[NSBundle mainBundle] loadNibNamed:@"DBCommentBottomView" owner:self options:nil][0];
    _bottomView.frame = CGRectMake(0, kScreenHeight - 55.0f, kScreenWidth, 55.0f);
    [self.view addSubview:_bottomView];
}

- (void)loadColorViewInWindowBelowSubView:(UIView *)subView  {
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    
    _colorView = [[UIView alloc] initWithFrame:CGRectMake(window.frame.origin.x, window.frame.origin.y, window.frame.size.width, window.frame.size.height)];
    _colorView.backgroundColor = [UIColor blackColor];
    _colorView.alpha = 0.5;
    [window insertSubview:_colorView belowSubview:subView];
}

#pragma mark - event

- (void)handleSubviewsEvent {
    
    __weak typeof(self)weakSelf = self;
    
    _bottomView.cameraEventBlock = ^ {
        NSLog(@"选择图片");
    };
    
    _bottomView.sendEventBlock = ^(NSString *str, BOOL isSend) {
        if (isSend && str.length > 0) {
            NSLog(@"%@",str);
            //提交评论接口
            DBCommentModel *model = [[DBCommentModel alloc] init];
            model.detail = str;
            model.guestName = [DBUser sharedInstance].name;
            model.headImage = [UIImage imageNamed:[DBUser sharedInstance].headImage];
            [weakSelf.commentList insertObject:model atIndex:0];
            [_tableView reloadData];
        }
        
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.bottomView.frame = CGRectMake(0.f, kScreenHeight - 55.0f, kScreenWidth, 55.0f);
            [weakSelf.bottomView setFieldText:@""];
        }];
    };
}

#pragma mark notification

- (void)addKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    keyboardHeight = keyboardRect.size.height;
    
    [UIView animateWithDuration:0.5f animations:^{
        _bottomView.frame = CGRectMake(0.f, kScreenHeight - keyboardHeight - 55.0f, kScreenWidth, 55.0f);

    }];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _commentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"DBCommentCellID";
    DBCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DBCommentCell" owner:self options:nil][0];
    }    
    [cell setCommentModel:[_commentList objectAtIndexSafe:indexPath.row]];
    
    cell.cellMessageEventBlock = ^ {
        //回复
        NSLog(@"回复");

    };
    
    cell.cellPraiseEventBlock = ^ {
       //点赞
        DBCommentModel *model = [_commentList objectAtIndexSafe:indexPath.row];
        
        if (!model.isLiked) {
            model.isLiked = YES;
            model.likedCount =  [NSString stringWithFormat:@"%ld", model.likedCount.integerValue + 1];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
        }else {
            [self showToastMessage:@"您已顶过"];
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = 100.0f;
    DBCommentCell *cell = (DBCommentCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    height = cell.height;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-  (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    }
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
