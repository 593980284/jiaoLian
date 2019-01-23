//
//  LXCourceListController.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourceListController.h"
#import <VTMagic/VTMagic.h>
#import "LXFindCoachCourseRecordSessionTask.h"
#import "LXCoureListSubViewController.h"
#import "LXCommonNavView.h"
#import "LXMineModel.h"
#import "LXFindCourseRecordArrModel.h"
#import "LXFindCourseRecordModel.h"

@interface LXCourceListController ()<VTMagicViewDelegate,VTMagicViewDataSource,LXCommonNavViewDelegate>
@property (nonatomic, strong) VTMagicController *magicController;
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXFindCoachCourseRecordSessionTask *courseDataController;
/// 课程Arr
@property (nonatomic, strong) NSMutableArray *courseArr;

@end

@implementation LXCourceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    [self.magicController.magicView reloadData];
    [self.view addSubview:self.navView];
}
#pragma mark - request
// 查询教练课程记录
- (void)requestMyCourceListViewController:(LXCoureListSubViewController *)viewController andPageIndex:(NSInteger)pageIndex{
    [self.courseDataController lxReuqestFindCoachCourseRecordWithCompletionBlock:^(LXFindCoachCourseResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            if (pageIndex == 0) {
                self.courseArr = [[NSMutableArray alloc] init];
                NSArray *clistArr = [NSArray yy_modelArrayWithClass:[LXFindCourseRecordModel class] json:[responseModel.data.clist yy_modelToJSONData]];
                for (LXFindCourseRecordModel *model in  clistArr) {
                    model.courseState = 0;
                    [self.courseArr addObject:model];
                }
            }else if (pageIndex == 1) {
                self.courseArr = [[NSMutableArray alloc] init];
                NSArray *ulist = [NSArray yy_modelArrayWithClass:[LXFindCourseRecordModel class] json:[responseModel.data.ulist yy_modelToJSONData]];
                for (LXFindCourseRecordModel *model in ulist) {
                    model.courseState = 1;
                    [self.courseArr addObject:model];
                }
            }
            viewController.dataArr = self.courseArr;
        }else {
            [self.view makeToast:responseModel.msg];
        }
    }];
}

#pragma mark - LXCommonNavViewDelegate
- (void)lx_clickLeftButton {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - VTMagicViewDataSource
/**
 *  获取所有菜单名，数组中存放字符串类型对象
 *
 *  @param magicView self
 *
 *  @return header数组
 */
- (NSArray<__kindof NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView{
    NSArray *titleArr = @[@"已完成课程",@"未完成课程"];
    return titleArr;
}
/**
 *  根据itemIndex加载对应的menuItem
 *
 *  @param magicView self
 *  @param itemIndex 需要加载的菜单索引
 *
 *  @return 当前索引对应的菜单按钮
 */
- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifierImg";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        menuItem.titleLabel.font = [UIFont systemFontOfSize:13];
        [menuItem setTitleColor:TEXT_COLOR_GRAY forState:UIControlStateNormal];
        [menuItem setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        UIImage *imgU = [UIImage imageNamed:@"lx_btn_selected_n"];
        UIImage *imgS = [UIImage imageNamed:@"lx_btn_selected_y"];
        [menuItem setImage:imgU forState:UIControlStateNormal];
        [menuItem setImage:imgS forState:UIControlStateSelected];
        [menuItem setImageEdgeInsets:UIEdgeInsetsMake(0, 13 * 5/2, 0, -13 * 5/2)];
        [menuItem setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgS.size.width/2, 0, imgS.size.width/2)];
    }
    return menuItem;
}
/**
 *  根据pageIndex加载对应的页面控制器
 *
 *  @param magicView self
 *  @param pageIndex 需要加载的页面索引
 *
 *  @return 页面控制器
 */
- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex{
    static NSString *string = @"LXCoureListSubViewController";
    LXCoureListSubViewController *tableView = [magicView dequeueReusablePageWithIdentifier:string];
    if (!tableView) {
        tableView = [[LXCoureListSubViewController alloc]init];
    }
    return tableView;
}
- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    [self requestMyCourceListViewController:viewController andPageIndex:pageIndex];
}


#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc] initWithTitle:@"课程记录"];
        _navView.delegate = self;
        _navView.leftButtonImage = [UIImage imageNamed:@"lx_nav_back"];
    }
    return _navView;
}
- (VTMagicController *)magicController
{
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.headerView.backgroundColor = [UIColor clearColor];
        _magicController.magicView.headerHeight = CGRectGetHeight(self.navView.frame);
        _magicController.magicView.navigationHeight = 45;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        _magicController.magicView.sliderStyle = VTSliderStyleDefault;
        _magicController.magicView.sliderHeight = 2;
        _magicController.magicView.sliderWidth = 50;
        _magicController.magicView.sliderColor = [UIColor colorWithHexString:@"#309CF5"];
        _magicController.magicView.bubbleRadius = 0;
        _magicController.magicView.headerHidden = NO;
//        [_magicController.magicView setSliderView:self.myCustomliderView];
    }
    return _magicController;
}
- (LXFindCoachCourseRecordSessionTask *)courseDataController {
    if (!_courseDataController) {
        LXMineModel *mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
        _courseDataController = [[LXFindCoachCourseRecordSessionTask alloc] init];
        _courseDataController.certNo = mineModel.certNo;
        _courseDataController.rows = 500;
        _courseDataController.page = 1;
    }
    return _courseDataController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
