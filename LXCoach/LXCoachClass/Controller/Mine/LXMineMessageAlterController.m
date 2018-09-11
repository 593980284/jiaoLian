//
//  LXMineMessageAlterController.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMineMessageAlterController.h"
#import "LXAlterOrFindStepTwoPasswordController.h"
#import "LXChangeOrFindPasswordController.h"
#import "LXCommonNavView.h"
#import "LXMineMessageAlterSubView.h"
#import "LXAlterMessageCell.h"

static NSString *alterMessage_Identify = @"LXAlterMessageCell";

@interface LXMineMessageAlterController ()<LXCommonNavViewDelegate,LXMineMessageAlterSubViewDelegate>
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXMineMessageAlterSubView *subView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation LXMineMessageAlterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.subView];
}
#pragma mark - LXMineMessageAlterSubViewDelegate
- (NSInteger)lx_alterMessageTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)lx_alterMessageTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LXAlterMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:alterMessage_Identify];
    if (cell == nil) {
        cell = [[LXAlterMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:alterMessage_Identify];
    }
    if (indexPath.row == 0) {
        [cell hiddenCurrenViewType:1];
    }else{
        [cell hiddenCurrenViewType:2];
        cell.nameString = self.dataSource[indexPath.row];
    }
    return cell;
}

- (CGFloat)lx_alterMessageTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
- (void)lx_alterMessageTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            // 修改头像
            break;
        case 1:
            // 密码修改
        {
            LXAlterOrFindStepTwoPasswordController *alterPassword = [[LXAlterOrFindStepTwoPasswordController alloc] init];
            alterPassword.type = 2;
            alterPassword.navTitleString = @"修改密码";
            [self.navigationController pushViewController:alterPassword animated:YES];
        }
            break;
        case 2:
            // 更换绑定手机号
        {
            LXChangeOrFindPasswordController *changeLoginNumber = [[LXChangeOrFindPasswordController alloc] init];
            changeLoginNumber.type = 2;            
            [self.navigationController pushViewController:changeLoginNumber animated:YES];
        }
            break;
        
    }
}

#pragma mark - LXCommonNavViewDelegate
- (void)lx_clickLeftButton {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc]initWithTitle:@"个人设置"];
        _navView.delegate = self;
        _navView.leftButtonImage = [UIImage imageNamed:@"lx_nav_back"];
    }
    return _navView;
}
- (LXMineMessageAlterSubView *)subView {
    if (!_subView) {
        _subView = [[LXMineMessageAlterSubView alloc] init];
        _subView.frame = CGRectMake(0, CGRectGetMaxY(self.navView.frame), kScreenWidth, kScreenHeight-CGRectGetHeight(self.navView.frame));
        _subView.alterMessageDelegate = self;
    }
    return _subView;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] initWithArray:@[@"",@"密码修改",@"更换绑定手机号"]];
    }
    return _dataSource;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
