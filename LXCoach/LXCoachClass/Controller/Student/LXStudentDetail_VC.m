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

@interface LXStudentDetail_VC ()<LXCommonNavViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation LXStudentDetail_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.navView];
}

#pragma mark - LXCommonNavViewDelegate
- (void)lx_clickLeftButton {
    [self.navigationController popViewControllerAnimated:YES];
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
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 126;
}
#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc]initWithTitle:@"我的学员"];
        _navView.delegate = self;
        _navView.leftButtonImage = [UIImage imageNamed:@"lx_nav_back"];
    }
    return _navView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
