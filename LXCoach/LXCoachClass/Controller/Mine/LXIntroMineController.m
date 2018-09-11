//
//  LXIntroMineController.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXIntroMineController.h"
#import "LXCommonNavView.h"
#import "LXIntroMineSubView.h"

@interface LXIntroMineController ()<LXCommonNavViewDelegate,LXIntroMineSubViewDelegate>
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXIntroMineSubView *subView;
@end

@implementation LXIntroMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.subView];
}
#pragma mark - LXIntroMineSubViewDelegate
/**
 确认修改简介
 
 @param introMessage 修改后的简介
 */
- (void)lx_alterMineMessage:(NSString *)introMessage {
    
}
#pragma mark - LXCommonNavViewDelegate

- (void)lx_clickLeftButton {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc] initWithTitle:@"个人简介"];
        _navView.delegate = self;
        _navView.leftButtonImage = [UIImage imageNamed:@"lx_nav_back"];
    }
    return _navView;
}
- (LXIntroMineSubView *)subView {
    if (!_subView) {
        _subView = [[LXIntroMineSubView alloc] init];
        _subView.frame = CGRectMake(0, CGRectGetMaxY(self.navView.frame), kScreenWidth, kScreenHeight-CGRectGetHeight(self.navView.frame));
        _subView.delegate = self;
    }
    return _subView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
