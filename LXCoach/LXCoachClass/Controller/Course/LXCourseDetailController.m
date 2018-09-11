//
//  LXCourseDetailController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourseDetailController.h"
#import "LXCommonNavView.h"
#import "LXCourseDetailView.h"

@interface LXCourseDetailController ()<LXCommonNavViewDelegate>

@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXCourseDetailView *courseDetailView;

@end

@implementation LXCourseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    self.courseDetailView.height = kScreenHeight-CGRectGetHeight(self.navView.frame)-self.view.safeAreaInsets.bottom;
}

- (void)createUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.courseDetailView];
    
    if (@available(iOS 11, *)) {
        
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - delegate
- (void)lx_clickLeftButton {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc] initWithTitle:@"课程详情"];
        _navView.showBackButton = YES;
        _navView.leftButtonImage = [UIImage imageNamed:@"lx_nav_back"];
        _navView.delegate = self;
    }
    return _navView;
}
- (LXCourseDetailView *)courseDetailView {
    if (!_courseDetailView) {
        _courseDetailView = [[LXCourseDetailView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.navView.frame), kScreenWidth, kScreenHeight-CGRectGetHeight(self.navView.frame))];
    }
    return _courseDetailView;
}
@end
