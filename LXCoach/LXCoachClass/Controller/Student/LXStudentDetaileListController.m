//
//  LXStudentDetaileListController.m
//  LXCoach
//
//  Created by GDD on 2018/9/9.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXStudentDetaileListController.h"
#import "LXStudentDetaileTitleCell.h"
#import "LXStudentDetaileListCell.h"

static NSString *detaileListTitle_Identify = @"LXStudentDetaileTitleCell";
static NSString *detaileList_Identify = @"LXStudentDetaileListCell";
@interface LXStudentDetaileListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation LXStudentDetaileListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LXStudentDetaileTitleCell * titleCell = [[LXStudentDetaileTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detaileListTitle_Identify];
        titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return titleCell;
    }else {
        LXStudentDetaileListCell *cell = [tableView dequeueReusableCellWithIdentifier:detaileList_Identify];
        if (cell == nil) {
            cell = [[LXStudentDetaileListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detaileList_Identify];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return [UITableViewCell new];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 56;
    }else {
        return 36;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.003;
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat navHeight = LXNavigationViewHeight+CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - (navHeight+110*kAutoSizeScaleX+45));
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
