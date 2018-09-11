//
//  LXMineController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMineController.h"
#import "LXCourceListController.h"
#import "LXMineMessageAlterController.h"
#import "LXAboutOursViewController.h"
#import "LXIntroMineController.h"
#import "LXCommonNavView.h"
#import "LXMineMainSubView.h"
#import "LXMineCell.h"
#import "LXMineModel.h"

static NSString *cell_Identify = @"LXMineCell";

@interface LXMineController ()<LXMineMainSubViewDelegate>
@property (nonatomic, strong)LXCommonNavView *navView;
@property (nonatomic, strong)LXMineMainSubView *subView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) LXMineModel *mineModel;
@end

@implementation LXMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.subView];
}

#pragma mark - LXMineMainSubViewDelegate
- (NSInteger)lx_numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)lx_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (UITableViewCell *)lx_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXMineCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_Identify];
    if (cell == nil) {
        cell = [[LXMineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_Identify];
    }
    [cell mineCellValuation:self.dataSource[indexPath.section][indexPath.row]];
    return cell;
}
- (CGFloat)lx_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
- (CGFloat)lx_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)lx_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.02;
}
- (void)lx_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger clickType = [[self.dataSource[indexPath.section][indexPath.row] objectForKey:@"clickType"] integerValue];
    switch (clickType) {
        case LXMineSlectTypeCourseList:
        {
            // 课程记录
            LXCourceListController *courceListVC = [[LXCourceListController alloc] init];
            [self.navigationController pushViewController:courceListVC animated:YES];
        }
            break;
        case LXMineSlectTypeMineIntro:
        {
            // 个人简介
            LXIntroMineController *introVC = [[LXIntroMineController alloc] init];
            [self.navigationController pushViewController:introVC animated:YES];
        }
            break;
        case LXMineSlectTypeRefreshCache:
        {
            // 刷新缓存
        }
            break;
        case LXMineSlectTypeCheckUpdate:
        {
            // 检查更新
        }
            break;
        case LXMineSlectTypeAboutOurs:
        {
            // 关于我们
            LXAboutOursViewController *aboutOursVC = [[LXAboutOursViewController alloc] init];
            [self.navigationController pushViewController:aboutOursVC animated:YES];
        }
            break;
        
            
       
    }
}
- (void)lx_clickHeaderAction {
    LXMineMessageAlterController *mineAlterVC = [[LXMineMessageAlterController alloc] init];
    [self.navigationController pushViewController:mineAlterVC animated:YES];
}
#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc] initWithTitle:@"我的"];
    }
    return _navView;
}
- (LXMineMainSubView *)subView {
    if (!_subView) {
        _subView = [[LXMineMainSubView alloc] init];
        _subView.frame = CGRectMake(0, CGRectGetMaxY(self.navView.frame), kScreenWidth, kScreenHeight-CGRectGetHeight(self.navView.frame));
        _subView.mainMineDelegate = self;
        [_subView lx_updateMineMessage:self.mineModel];
    }
    return _subView;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"LXMineMessageList" ofType:@"plist"];
        _dataSource = [[NSMutableArray alloc] initWithContentsOfFile:path];
    }
    return _dataSource;
}
- (LXMineModel *)mineModel {
    if (!_mineModel) {
        // 读取数据
        _mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
    }
    return _mineModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
