//
//  LXMyAffairsToClass_VC.m
//  LXCoach
//
//  Created by slardar on 2019/1/20.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LXMyAffairsToClass_VC.h"
#import "LXAffairsClassSessionTask.h"
#import "LXMineModel.h"
#import "LXAffairsClassModel.h"
#import "LXMyAffairClassCell.h"
#import "LXCourseDetailController.h"
@interface LXMyAffairsToClass_VC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) LXAffairsClassSessionTask *classTask;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation LXMyAffairsToClass_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.tableView];
    
#ifdef __IPHONE_11_0
    if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
#endif
}
-(void)loadLXMyAffairsToClassData{
    [self.classTask lxReuqestWithCompletionBlock:^(LXAffairsClassResponseObject * _Nonnull responseModel) {
        if (responseModel.flg == 1) {
            self.dataArr = responseModel.data.list;
            [self.tableView reloadData];
        }else {
            [self.view makeToast:responseModel.msg];
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXMyAffairClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXMyAffairClassCell"];
    if (cell == nil) {
        cell = [[LXMyAffairClassCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LXMyAffairClassCell"];
    }
    [cell configCellValue:self.dataArr[indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    LXMyAffairsClassModel *recordModel = self.dataArr[indexPath.row];
//    LXCourseDetailController *detailVC = [[LXCourseDetailController alloc] init];
//    detailVC.appointmentId = [recordModel.appointmentId integerValue];
//    detailVC.cheekPageOption = 2;
//    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat navHeight = LXNavigationViewHeight+CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-(navHeight+45)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


-(LXAffairsClassSessionTask *)classTask{
    if (!_classTask) {
        _classTask = [LXAffairsClassSessionTask new];
        LXMineModel *model = [LXCacheManager objectForKey:@"LXMineModel"];
        _classTask.certNo = model.certNo;
    }
    return _classTask;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
