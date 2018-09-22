//
//  LXMessageDetaileSubView.m
//  LXCoach
//
//  Created by GDD on 2018/9/22.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMessageDetaileSubView.h"
#import "LXMessageDetaileCell.h"

static NSString *detaile_Identify = @"LXMessageDetaileCell";

@interface LXMessageDetaileSubView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation LXMessageDetaileSubView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.tableView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.width, self.height);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detileArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXMessageDetaileCell *cell = [tableView dequeueReusableCellWithIdentifier:detaile_Identify];
    if (cell == nil) {
        cell = [[LXMessageDetaileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detaile_Identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.detileArr[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 175;
}
#pragma mark - setter
- (void)setDetileArr:(NSArray<LXFindSingleCoachMsgModel *> *)detileArr {
    _detileArr = detileArr;
    [self.tableView reloadData];
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
@end
