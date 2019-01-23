//
//  LXStudentDetail_VC.m
//  LXCoach
//
//  Created by slardar on 2019/1/22.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LXStudentDetail_VC.h"
#import "LXCommonNavView.h"
#import "LXMineModel.h"
#import "LXStudentDetail_Cell.h"
#import "LXFindMyStudentDetilSessionTask.h"
#import "LXStudentDetaileHeaderView.h"

@interface LXStudentDetail_VC ()<LXCommonNavViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXStudentDetaileHeaderView *headerView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) LXFindMyStudentDetilSessionTask *studentDetailTask;
@end

@implementation LXStudentDetail_VC{
    NSString *_subName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
    [self requestStudentDetailData];
}

#pragma mark - LXCommonNavViewDelegate
- (void)lx_clickLeftButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requestStudentDetailData{
    [self.studentDetailTask lxReuqestFindMyStudentDetilWithCompletionBlock:^(LXFindMyStudentDetilResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            self->_subName = responseModel.data.subject;
            self.dataArray = responseModel.data.list;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kIdentifier = @"LXStudentDetailCell";
    LXStudentDetail_Cell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
    if (!cell) {
        cell = [[LXStudentDetail_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentifier];
    }
    [cell updateWithModel:_dataArray[indexPath.row] andSubjectName:_subName];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc]initWithTitle:@"学员详情"];
        _navView.delegate = self;
        _navView.leftButtonImage = [UIImage imageNamed:@"lx_nav_back"];
    }
    return _navView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_navView.frame), self.view.width, self.view.height - CGRectGetMaxY(_navView.frame)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _headerView = [LXStudentDetaileHeaderView new];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, 103);
        [_headerView configValue:_headerModel];
        _tableView.tableHeaderView = _headerView;
    }
    return _tableView;
}
- (LXFindMyStudentDetilSessionTask *)studentDetailTask {
    if (!_studentDetailTask) {
        LXMineModel *mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
        _studentDetailTask = [[LXFindMyStudentDetilSessionTask alloc] init];
        _studentDetailTask.rows = 500;
        _studentDetailTask.page = 1;
        NSString *cerNo;
        if (self.cerNoState) {
            cerNo = mineModel.certNo;
        }else {
            cerNo = @"";
        }
        _studentDetailTask.certNo = cerNo;
        _studentDetailTask.studentId = _headerModel.studentId;
    }
    return _studentDetailTask;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
