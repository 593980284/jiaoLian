//
//  LXStudentDetailController.m
//  LXCoach
//
//  Created by GDD on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXStudentDetailController.h"
#import <VTMagic/VTMagic.h>
#import "LXStudentDetaileListController.h"
#import "LXCommonNavView.h"
#import "LXStudentDetaileHeaderView.h"
#import "LXMyStudentListModel.h"
#import "LXStudentDataController.h"
#import "LXFindMyStudentDetilSessionTask.h"
#import "LXMineModel.h"
#import "LXMyStudentDetailSubjectModel.h"
#import "LXStudentSubjectDetailModel.h"

@interface LXStudentDetailController ()<LXCommonNavViewDelegate,VTMagicViewDelegate,VTMagicViewDataSource>
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXStudentDetaileHeaderView *headerView;
@property (nonatomic, strong) VTMagicController *magicController;
@property (nonatomic, strong) LXStudentDataController *studentDataController;
/// 科目预约数据
@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation LXStudentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestSubject];
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    [self.magicController.magicView reloadData];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.headerView];
    [self.headerView configValue:self.headerModel];
}

#pragma mark - request
// 学员详情
- (void)requestSubject {
    LXMineModel *mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
    [self.studentDataController lxReuqestFindMyStudentDetilWithCertNo:mineModel.certNo andStudentId:self.headerModel.studentId completionBlock:^(LXFindMyStudentDetilResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            NSArray * list_1Arr = [NSArray yy_modelArrayWithClass:[LXStudentSubjectDetailModel class] json:[responseModel.data.list_1 yy_modelToJSONData]];
            NSArray * list_2Arr = [NSArray yy_modelArrayWithClass:[LXStudentSubjectDetailModel class] json:[responseModel.data.list_2 yy_modelToJSONData]];
            NSArray * list_3Arr = [NSArray yy_modelArrayWithClass:[LXStudentSubjectDetailModel class] json:[responseModel.data.list_3 yy_modelToJSONData]];
            NSArray * list_4Arr = [NSArray yy_modelArrayWithClass:[LXStudentSubjectDetailModel class] json:[responseModel.data.list_4 yy_modelToJSONData]];
            self.listArr = [[NSMutableArray alloc] initWithObjects:list_1Arr,list_2Arr, list_3Arr,list_4Arr,nil];
            
        }else {
//            [self.view makeToast:responseModel.msg];
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
    NSArray *titleArr = @[@"科目一",@"科目二",@"科目三",@"文明驾驶"];
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
    static NSString *string = @"LXStudentDetaileListController";
    LXStudentDetaileListController *tableView = [magicView dequeueReusablePageWithIdentifier:string];
    if (!tableView) {
        tableView = [[LXStudentDetaileListController alloc]init];
    }
    return tableView;
}
- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    LXStudentDetaileListController *vc = (LXStudentDetaileListController *)viewController;
    vc.dataArr = self.listArr[pageIndex];
}

#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc]initWithTitle:@"学员详情"];
        _navView.delegate = self;
        _navView.leftButtonImage = [UIImage imageNamed:@"lx_nav_back"];
    }
    return _navView;
}
- (LXStudentDetaileHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[LXStudentDetaileHeaderView alloc] init];
        _headerView.frame = CGRectMake(0, CGRectGetMaxY(self.navView.frame), kScreenWidth, 110*kAutoSizeScaleX);
    }
    return _headerView;
}
- (VTMagicController *)magicController
{
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.headerView.backgroundColor = [UIColor clearColor];
        _magicController.magicView.headerHeight = CGRectGetHeight(self.navView.frame)+CGRectGetHeight(self.headerView.frame);
        _magicController.magicView.navigationHeight = 45;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        _magicController.magicView.sliderStyle = VTSliderStyleDefault;
        _magicController.magicView.sliderHeight = 2;
        _magicController.magicView.sliderWidth = 50;
        _magicController.magicView.sliderColor = [UIColor colorWithHexString:@"#309CF5"];
        _magicController.magicView.bubbleRadius = 0;
        _magicController.magicView.headerHidden = NO;
    }
    return _magicController;
}
- (LXStudentDataController *)studentDataController {
    if (!_studentDataController) {
        _studentDataController = [[LXStudentDataController alloc] init];
    }
    return _studentDataController;
}
@end
