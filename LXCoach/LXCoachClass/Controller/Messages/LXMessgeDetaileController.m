//
//  LXMessgeDetaileController.m
//  LXCoach
//
//  Created by GDD on 2018/9/22.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMessgeDetaileController.h"
#import "LXCommonNavView.h"
#import "LXMessageDataController.h"
#import "LXFindSingleCoachMsgSessionTask.h"
#import "LXMessageDetaileSubView.h"
#import "LXFindSingleCoachMsgModel.h"

@interface LXMessgeDetaileController ()<LXCommonNavViewDelegate>
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXMessageDataController *dataController;
@property (nonatomic, strong) LXMessageDetaileSubView *subView;
@end

@implementation LXMessgeDetaileController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.subView];
    [self requestMsgIdToSubject];
}

- (void)requestMsgIdToSubject {
    [self.dataController lxReuqestFindSingleCoachMsgWithMsgId:[NSString stringWithFormat:@"%ld",self.msgId] completionBlock:^(LXFindSingleCoachMsgResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            NSArray *dataArr = [[NSArray alloc] initWithObjects:responseModel.data, nil];
            self.subView.detileArr = dataArr;
        }else {
            [self.view makeToast:responseModel.msg];
        }
    }];
}

#pragma mark - LXCommonNavViewDelegate
- (void)lx_clickLeftButton {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc] initWithTitle:@"我的消息"];
        _navView.leftButtonImage = [UIImage imageNamed:@"lx_nav_back"];
        _navView.delegate = self;
    }
    return _navView;
}
- (LXMessageDetaileSubView *)subView {
    if (!_subView) {
        _subView = [[LXMessageDetaileSubView alloc] init];
        _subView.frame = CGRectMake(0, CGRectGetMaxY(self.navView.frame), kScreenWidth, kScreenHeight-CGRectGetHeight(self.navView.frame));
    }
    return _subView;
}
- (LXMessageDataController *)dataController {
    if (!_dataController) {
        _dataController = [[LXMessageDataController alloc] init];
    }
    return _dataController;
}

@end
