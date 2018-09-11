//
//  LXStudentController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXStudentController.h"
#import "LXStudentDetailController.h"
#import "LXCommonNavView.h"
#import "LXStudentSubView.h"
#import "LXStudentSubViewCell.h"

static NSString *studentList_Identify = @"LXStudentSubViewCell";

@interface LXStudentController ()<LXCommonNavViewDelegate,LXStudentSubViewDelegate>
@property (nonatomic, strong)LXCommonNavView *navView;
@property (nonatomic, strong)LXStudentSubView *subView;
@property (nonatomic, strong)NSMutableArray *dataSourceArr;
@end

@implementation LXStudentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.subView];
}
#pragma mark - private
- (void)callMobile:(NSString *)mobile {
    
}
#pragma mark - LXStudentSubViewDelegate
- (NSInteger)lx_myStudentListTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    return self.dataSourceArr.count;
    return 10;
}
- (UITableViewCell *)lx_myStudentListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXStudentSubViewCell *cell = [tableView dequeueReusableCellWithIdentifier:studentList_Identify];
    if (cell == nil) {
        cell = [[LXStudentSubViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:studentList_Identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    @weakify(self)
    [cell setCallMobileBlock:^{
        @strongify(self)
        [self callMobile:@""];
    }];
    return cell;
}
- (CGFloat)lx_myStudentListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 15 + 94 * kAutoSizeScaleX;
}
- (void)lx_myStudentListTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LXStudentDetailController *studentDetailVC = [[LXStudentDetailController alloc] init];
    [self.navigationController pushViewController:studentDetailVC animated:YES];
    
}
#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc]initWithTitle:@"我的学员"];
    }
    return _navView;
}
- (LXStudentSubView *)subView {
    if (!_subView) {
        _subView = [[LXStudentSubView alloc] init];
        _subView.frame = CGRectMake(0, CGRectGetMaxY(self.navView.frame), kScreenWidth, kScreenHeight-(CGRectGetHeight(self.navView.frame) +CGRectGetHeight(self.tabBarController.tabBar.frame)));
        _subView.studentSubViewDelegate = self;
    }
    return _subView;
}
- (NSMutableArray *)dataSourceArr {
    if (!_dataSourceArr) {
        _dataSourceArr = [[NSMutableArray alloc] init];
    }
    return _dataSourceArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
