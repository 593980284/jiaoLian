//
//  LXMineMainSubView.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMineMainSubView.h"
#import "LXMainMessageHeaderView.h"

@interface LXMineMainSubView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXMainMessageHeaderView *headerView;
@end

@implementation LXMineMainSubView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self subView];
    }
    return self;
}
- (void)subView {
    [self addSubview:self.tableView];
    @weakify(self)
    [self.headerView setClickHeadActionBlock:^{
        @strongify(self)
        if ([self.mainMineDelegate respondsToSelector:@selector(lx_clickHeaderAction)]) {
            [self.mainMineDelegate lx_clickHeaderAction];
        }
    }];
    
#ifdef __IPHONE_11_0
    if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
#endif
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width;
    CGFloat h = self.height;
    self.tableView.frame = CGRectMake(x, y, w, h);
}
#pragma mark - publicMethod
/**
 刷新数据
 
 @param model model
 */
- (void)lx_updateMineMessage:(LXMineModel *)model {
    [self.headerView assignmentMineHeaderValue:model];
}

#pragma mark - UITableViewDataSource/UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sectionNumber = 0;
    if ([self.mainMineDelegate respondsToSelector:@selector(lx_numberOfSectionsInTableView:)]) {
        sectionNumber = [self.mainMineDelegate lx_numberOfSectionsInTableView:tableView];
    }
    return sectionNumber;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rowNumber = 0;
    if ([self.mainMineDelegate respondsToSelector:@selector(lx_tableView:numberOfRowsInSection:)]) {
        rowNumber = [self.mainMineDelegate lx_tableView:tableView numberOfRowsInSection:section];
    }
    return rowNumber;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    if ([self.mainMineDelegate respondsToSelector:@selector(lx_tableView:cellForRowAtIndexPath:)]) {
        cell = [self.mainMineDelegate lx_tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat rowHeight = 0.0;
    if ([self.mainMineDelegate respondsToSelector:@selector(lx_tableView:heightForRowAtIndexPath:)]) {
        rowHeight = [self.mainMineDelegate lx_tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return rowHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat headerSectionHeight = 0.0;
    if ([self.mainMineDelegate respondsToSelector:@selector(lx_tableView:heightForHeaderInSection:)]) {
        headerSectionHeight = [self.mainMineDelegate lx_tableView:tableView heightForHeaderInSection:section];
    }
    return headerSectionHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat footerSectionHeight = 0.0;
    if ([self.mainMineDelegate respondsToSelector:@selector(lx_tableView:heightForFooterInSection:)]) {
        footerSectionHeight = [self.mainMineDelegate lx_tableView:tableView heightForFooterInSection:section];
    }
    return footerSectionHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.mainMineDelegate respondsToSelector:@selector(lx_tableView:didSelectRowAtIndexPath:)]) {
        [self.mainMineDelegate lx_tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
#pragma mark - getter
- (LXMainMessageHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[LXMainMessageHeaderView alloc] init];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, 168*kAutoSizeScaleX+90);
    }
    return _headerView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
@end
