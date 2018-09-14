//
//  LXMessageController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMessageController.h"
#import "LXMessgaeListController.h"
#import "LXCommonNavView.h"
#import <VTMagic/VTMagic.h>
#import "LXMessageDataController.h"
#import "LXFfindCoachMsgSessionTask.h"
#import "LXMineModel.h"

@interface LXMessageController ()<VTMagicViewDelegate,VTMagicViewDataSource>
@property (nonatomic, strong) VTMagicController *magicController;
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) LXMessageDataController *dataController;
@property (nonatomic, strong) LXMineModel *mineModel;

@end

@implementation LXMessageController

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
- (void)requestMyMessageViewController:(LXMessgaeListController *)viewController andMessageType:(NSInteger)type {
    NSString *messageType ;
    if (type == 0) {
        messageType = @"1";
    }else if (type == 1) {
        messageType = @"2";
    }
    [self.dataController lxReuqestFindCoachMsgWithCertNo:self.mineModel.certNo andMessageTyep:messageType completionBlock:^(LXFindCoachMsgResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            self.dataArr = responseModel.data;
            viewController.dataArr = self.dataArr;
        }
    }];
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
    NSArray *titleArr = @[@"系统",@"驾校"];
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
    static NSString *string = @"LXMessgaeListController";
    LXMessgaeListController *tableView = [magicView dequeueReusablePageWithIdentifier:string];
    if (!tableView) {
        tableView = [[LXMessgaeListController alloc]init];
    }
    return tableView;
}

- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    [self requestMyMessageViewController:viewController andMessageType:pageIndex];
}

#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc] initWithTitle:@"我的消息"];
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

- (LXMessageDataController *)dataController {
    if (!_dataController) {
        _dataController = [[LXMessageDataController alloc] init];        
    }
    return _dataController;
}
- (LXMineModel *)mineModel {
    if (!_mineModel) {
        _mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
    }
    return _mineModel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
