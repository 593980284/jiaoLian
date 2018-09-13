//
//  LXCourceListController.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourceListController.h"
#import <VTMagic/VTMagic.h>
#import "LXCourseDataController.h"
#import "LXFindCoachCourseRecordSessionTask.h"
#import "LXCoureListSubViewController.h"
#import "LXCourseNoHaveListController.h"
#import "LXCommonNavView.h"
#import "LXMineModel.h"
#import "LXFindCourseRecordArrModel.h"

@interface LXCourceListController ()<VTMagicViewDelegate,VTMagicViewDataSource,LXCommonNavViewDelegate>
@property (nonatomic, strong) VTMagicController *magicController;
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXCourseDataController *courseDataController;
/// 已完成课程
@property (nonatomic, strong) NSArray *clistArr;
/// 未完成课程
@property (nonatomic, strong) NSArray *ulistArr;
@end

@implementation LXCourceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    [self.magicController.magicView reloadData];
    [self requestMyCourceList];
    [self.view addSubview:self.navView];
}
#pragma mark - request
// 查询教练课程记录
- (void)requestMyCourceList {
    LXMineModel *mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
    [self.courseDataController lxReuqestFindCoachCourseRecordListWithCertNo:mineModel.certNo completionBlock:^(LXFindCoachCourseResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            self.clistArr = [NSArray arrayWithArray:responseModel.data.clist];
            self.ulistArr = [NSArray arrayWithArray:responseModel.data.ulist];
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
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [menuItem setTitleColor:[UIColor colorWithHexString:@"#309CF5"] forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont systemFontOfSize:16];
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
    if (pageIndex == 0) {
        static NSString *string = @"LXCoureListSubViewController";
        LXCoureListSubViewController *tableView = [magicView dequeueReusablePageWithIdentifier:string];
        if (!tableView) {
            tableView = [[LXCoureListSubViewController alloc]init];
        }
        tableView.dataSource = self.clistArr;
        return tableView;
    }else if (pageIndex == 1) {
        static NSString *string = @"LXCourseNoHaveListController";
        LXCourseNoHaveListController *tableView = [magicView dequeueReusablePageWithIdentifier:string];
        if (!tableView) {
            tableView = [[LXCourseNoHaveListController alloc]init];
        }
        tableView.dataSource = self.ulistArr;
        return tableView;
    }
    return [UIViewController new];
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
- (LXCourseDataController *)courseDataController {
    if (!_courseDataController) {
        _courseDataController = [[LXCourseDataController alloc] init];
    }
    return _courseDataController;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
