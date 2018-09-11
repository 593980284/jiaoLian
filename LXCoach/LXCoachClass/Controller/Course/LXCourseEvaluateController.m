//
//  LXCourseEvaluateController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourseEvaluateController.h"
#import "LXCommonNavView.h"
#import "LXCourseEvaluateView.h"

@interface LXCourseEvaluateController ()<LXCommonNavViewDelegate>

@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXCourseEvaluateView *subView;

@end

@implementation LXCourseEvaluateController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
}

- (void)createUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.subView];
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
        _navView = [[LXCommonNavView alloc] initWithTitle:@"课程评价"];
        _navView.showBackButton = YES;
        _navView.leftButtonImage = [UIImage imageNamed:@"lx_nav_back"];
        _navView.delegate = self;
    }
    return _navView;
}
- (LXCourseEvaluateView *)subView {
    if (!_subView) {
        _subView = [[LXCourseEvaluateView alloc] init];
        _subView.frame = CGRectMake(0, CGRectGetMaxY(self.navView.frame), kScreenWidth, kScreenHeight-CGRectGetHeight(self.navView.frame));
    }
    return _subView;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
