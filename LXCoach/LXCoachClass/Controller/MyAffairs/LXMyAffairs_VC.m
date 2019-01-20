//
//  LXMyAffairs_VC.m
//  LXCoach
//
//  Created by slardar on 2019/1/20.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LXMyAffairs_VC.h"
#import <VTMagic/VTMagic.h>
#import "LXCommonNavView.h"
#import "LXMyAffairsToClass_VC.h"
#import "LXMyAffairsToHandle_VC.h"
@interface LXMyAffairs_VC ()<VTMagicViewDelegate,VTMagicViewDataSource>
@property (nonatomic, strong) VTMagicController *magicController;
@property (nonatomic, strong) LXCommonNavView *navView;
@end

@implementation LXMyAffairs_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    [self.magicController.magicView reloadData];
    [self.view addSubview:self.navView];
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
    NSArray *titleArr = @[@"待上课信息",@"待处理课程"];
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
    if (pageIndex == 0) {
        static NSString *string = @"LXMyAffairsToClass_VC";
        LXMyAffairsToClass_VC *vc = [magicView dequeueReusablePageWithIdentifier:string];
        if (!vc) {
            vc = [[LXMyAffairsToClass_VC alloc]init];
        }
        return vc;
    }else{
        static NSString *string = @"LXMyAffairsToHandle_VC";
        LXMyAffairsToHandle_VC *vc = [magicView dequeueReusablePageWithIdentifier:string];
        if (!vc) {
            vc = [[LXMyAffairsToHandle_VC alloc]init];
        }
        return vc;
    }
}
- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    if (pageIndex == 0) {
        LXMyAffairsToClass_VC *vc = viewController;
        [vc loadLXMyAffairsToClassData];
    }else{
        LXMyAffairsToHandle_VC *vc = viewController;
        [vc loadLXMyAffairsToHandleData];
    }
}

#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc] initWithTitle:@"我的事务"];
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
    }
    return _magicController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
