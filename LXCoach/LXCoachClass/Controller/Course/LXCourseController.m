//
//  LXCourseController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourseController.h"
#import "LXCommonNavView.h"
#import "LXCourseSubView.h"
#import "LXCourseListModel.h"

@interface LXCourseController ()
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXCourseSubView *courseSubView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation LXCourseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    self.courseSubView.height = kScreenHeight-self.navView.height-CGRectGetHeight(self.tabBarController.tabBar.frame)-self.view.safeAreaInsets.bottom;
}

- (void)createUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.courseSubView];
    if (@available(iOS 11, *)) {
        
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc] initWithTitle:@"我的课程"];
    }
    return _navView;
}

- (LXCourseSubView *)courseSubView {
    if (!_courseSubView) {
        _courseSubView = [[LXCourseSubView alloc]initWithFrame:CGRectMake(0, self.navView.height, kScreenWidth, kScreenHeight-self.navView.height-CGRectGetHeight(self.tabBarController.tabBar.frame))];
    }
    return _courseSubView;
}

@end
