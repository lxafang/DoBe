//
//  DBMainController.m
//  BYDailyNews
//
//  Created by bassamyan on 15/1/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "DBMainController.h"
#import "BYListBar.h"
#import "BYArrow.h"
#import "BYDetailsList.h"
#import "BYDeleteBar.h"
#import "BYScroller.h"

#import "DBMyController.h"
#import "DBSearchController.h"
#import "DBArticleDetailVC.h"

#import "DBCommendView.h"

#define kListBarH 30
#define kArrowW 40
#define kAnimationTime 0.8

@interface DBMainController () <UIScrollViewDelegate>

@property (nonatomic,strong) BYListBar *listBar;

@property (nonatomic,strong) BYDeleteBar *deleteBar;

@property (nonatomic,strong) BYDetailsList *detailsList;

@property (nonatomic,strong) BYArrow *arrow;

@property (nonatomic,strong) UIScrollView *mainScroller;

@end

@implementation DBMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"豆比";
    if (IOS7) {
        //self.edgesForExtendedLayout = UIRectEdgeNone;
        //self.extendedLayoutIncludesOpaqueBars = NO; //不透明的操作栏
        //self.modalPresentationCapturesStatusBarAppearance = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;//ios7 导航控制器切换影响UIScrollView布局的问题
    }
    
    [self showBackButtonWithImage:@"home-my"];
    [self showRightButtonWithImage:[UIImage imageNamed:@"icon_search"] andHigImage:nil];
    
    if (!_loadedSortList) {
        _loadedSortList = [[NSMutableArray alloc] init];
    }
    self.currentIndex = 0;
    self.currentItem = @"推荐";

    [self makeContent];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

-(void)makeContent
{
    
    NSMutableArray *listTop = [[NSMutableArray alloc] initWithArray:@[@"推荐",@"热点",@"杭州",@"社会",@"娱乐",@"科技",@"汽车",@"体育",@"订阅",@"财经",@"军事",@"国际",@"正能量",@"段子",@"趣图",@"美女",@"健康",@"教育",@"特卖",@"彩票",@"辟谣"]];
    NSMutableArray *listBottom = [[NSMutableArray alloc] initWithArray:@[@"电影",@"数码",@"时尚",@"奇葩",@"游戏",@"旅游",@"育儿",@"减肥",@"养生",@"美食",@"政务",@"历史",@"探索",@"故事",@"美文",@"情感",@"语录",@"美图",@"房产",@"家居",@"搞笑",@"星座",@"文化",@"毕业生",@"视频"]];
    
    __weak typeof(self) unself = self;
    
    if (!self.detailsList) {
        self.detailsList = [[BYDetailsList alloc] initWithFrame:CGRectMake(0, -(kScreenH-kListBarH), kScreenW, kScreenH-kListBarH)];
        self.detailsList.listAll = [NSMutableArray arrayWithObjects:listTop,listBottom, nil];
        self.detailsList.longPressedBlock = ^(){
            [unself.deleteBar sortBtnClick:unself.deleteBar.sortBtn];
        };
        self.detailsList.opertionFromItemBlock = ^(animateType type, NSString *itemName, int index){
            [unself.listBar operationFromBlock:type itemName:itemName index:index];
        };
        [self.view addSubview:self.detailsList];
    }
    
    if (!self.listBar) {
        self.listBar = [[BYListBar alloc] initWithFrame:CGRectMake(0, 64.0f, kScreenW, kListBarH)];
        self.listBar.visibleItemList = listTop;
        self.listBar.arrowChange = ^(){
            if (unself.arrow.arrowBtnClick) {
                unself.arrow.arrowBtnClick();
            }
        };
        self.listBar.listBarItemClickBlock = ^(NSString *itemName , NSInteger itemIndex){
            //顶部显示button
            [unself.detailsList itemRespondFromListBarClickWithItemName:itemName];
            DLog(@"%@",itemName);
            unself.currentItem = itemName;
            unself.currentIndex = itemIndex;
            [unself addScrollViewWithItemName:itemName index:itemIndex];
            //移动到该位置
            unself.mainScroller.contentOffset = CGPointMake(itemIndex * unself.mainScroller.frame.size.width,0);
        };
        [self.view addSubview:self.listBar];
    }
    
    if (!self.deleteBar) {
        self.deleteBar = [[BYDeleteBar alloc] initWithFrame:self.listBar.frame];
        [self.view addSubview:self.deleteBar];
    }
    
    
    if (!self.arrow) {
        self.arrow = [[BYArrow alloc] initWithFrame:CGRectMake(kScreenW-kArrowW, 64.0f, kArrowW, kListBarH)];
        self.arrow.arrowBtnClick = ^(){
            unself.deleteBar.hidden = !unself.deleteBar.hidden;
            [UIView animateWithDuration:kAnimationTime animations:^{
                CGAffineTransform rotation = unself.arrow.imageView.transform;
                unself.arrow.imageView.transform = CGAffineTransformRotate(rotation,M_PI);
                unself.detailsList.transform = (unself.detailsList.frame.origin.y<0)?CGAffineTransformMakeTranslation(0, kScreenH + 64.0f):CGAffineTransformMakeTranslation(0, -kScreenH - 64.0f);
            }];
        };
        [self.view addSubview:self.arrow];
    }
    
    if (!self.mainScroller) {
        self.mainScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kListBarH + 64.0f, kScreenW, kScreenH-kListBarH-64)];
        self.mainScroller.backgroundColor = [UIColor yellowColor];
        self.mainScroller.bounces = NO;
        self.mainScroller.pagingEnabled = YES;
        self.mainScroller.showsHorizontalScrollIndicator = NO;
        self.mainScroller.showsVerticalScrollIndicator = NO;
        self.mainScroller.delegate = self;
        [self.view insertSubview:self.mainScroller atIndex:0];
        self.mainScroller.contentSize = CGSizeMake(kScreenW*10,_mainScroller.height);
        [self addScrollViewWithItemName:_currentItem index:_currentIndex];
    }
}

-(void)addScrollViewWithItemName:(NSString *)itemName index:(NSInteger)index{
    BOOL loadedFlag = NO;
    if (_loadedSortList.count > 0) {
        for (NSString *item in _loadedSortList) {
            if ([item isEqualToString:itemName]) {
                loadedFlag = YES;
                break;
            }
        }
    }
    if (!loadedFlag) {
        [_loadedSortList addObject:itemName];
        
        CGFloat width = _mainScroller.width;
        CGFloat height = _mainScroller.height;
        CGRect iFrame = CGRectMake(index *width, 0.f, width, height);

        if ([itemName isEqualToString:@"推荐"]) {
            DBCommendView *commendView = [[DBCommendView alloc] initWithFrame:iFrame];
            [_mainScroller addSubview:commendView];
            commendView.didSelectRowBlock = ^(NSInteger row){
                NSLog(@"点击第%ld行",(long)row);
                //选择数据
                DBArticleDetailVC *detailVC = (DBArticleDetailVC *)[self instantiateViewControllerWithIdentifier:@"DBArticleDetailVC"
                                                                         withStoryboardName:@"DBArticle"];
                [self.navigationController pushViewController:detailVC animated:YES];
            };
        }else {
            UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(index * width, 0.0f, width, height)];
            scroller.backgroundColor = RGBColor(arc4random()%255, arc4random()%255, arc4random()%255);
            [_mainScroller addSubview:scroller];
        }
    }
}

#pragma mark - event

- (void)backBarButtonPressed:(id)sender {
    //my
    UIStoryboard *myStoryBoard = [UIStoryboard storyboardWithName:@"My"
                                                            bundle:nil];
    DBMyController *myVC = [myStoryBoard instantiateViewControllerWithIdentifier:@"DBMyVC"];
    [self.navigationController pushViewController:myVC animated:YES];
}

- (void)rightBarButtonPressed:(id)sender {
    //search
    DBSearchController *searchVC = [[DBSearchController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self.listBar itemClickByScrollerWithIndex:scrollView.contentOffset.x / self.mainScroller.frame.size.width];
}
@end
