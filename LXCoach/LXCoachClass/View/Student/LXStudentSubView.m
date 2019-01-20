//
//  LXStudentSubView.m
//  LXCoach
//
//  Created by GDD on 2018/9/7.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXStudentSubView.h"

@interface LXStudentSubView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation LXStudentSubView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.tableView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.width, self.height);
}
#pragma mark - publicMethod
- (void)reloadTableView {
    [self.tableView reloadData];
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.studentSubViewDelegate respondsToSelector:@selector(lx_myStudentListTableView:numberOfRowsInSection:)]) {
        return  [self.studentSubViewDelegate lx_myStudentListTableView:tableView numberOfRowsInSection:section];
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.studentSubViewDelegate respondsToSelector:@selector(lx_myStudentListTableView:cellForRowAtIndexPath:)]) {
        return [self.studentSubViewDelegate lx_myStudentListTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return [UITableViewCell new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.studentSubViewDelegate  respondsToSelector:@selector(lx_myStudentListTableView:heightForRowAtIndexPath:)]) {
        return [self.studentSubViewDelegate lx_myStudentListTableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.studentSubViewDelegate respondsToSelector:@selector(lx_myStudentListTableView:didSelectRowAtIndexPath:)]) {
        [self.studentSubViewDelegate lx_myStudentListTableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
@end
