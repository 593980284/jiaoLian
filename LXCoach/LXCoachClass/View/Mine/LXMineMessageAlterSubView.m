//
//  LXMineMessageAlterSubView.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMineMessageAlterSubView.h"

@interface LXMineMessageAlterSubView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *footerView;
/// 退出按钮
@property (nonatomic, strong) UIButton *quiteButton;
@end

@implementation LXMineMessageAlterSubView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self subView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width;
    CGFloat h = self.height;
    self.tableView.frame = CGRectMake(x, y, w, h);
    
    h = self.height - (15+45+55*3);
    self.footerView.frame = CGRectMake(x, y, w, h);
    
    x = 15;
    y = CGRectGetHeight(self.footerView.frame) - 15;
    w = self.width - 30;
    h = 45;
    self.quiteButton.frame = CGRectMake(x, y, w, h);
    
    
}

- (void)subView {
    [self addSubview:self.tableView];
    [self.footerView addSubview:self.quiteButton];
    self.tableView.tableFooterView = self.footerView;
    
#ifdef __IPHONE_11_0
    if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
#endif
}
#pragma mark - Event
- (void)quiteButtonAction {
    if ([self.alterMessageDelegate respondsToSelector:@selector(lx_outLogin)]) {
        [self.alterMessageDelegate lx_outLogin];
    }
}
#pragma mark - publicMethod
- (void)uploadTableView {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource/UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.alterMessageDelegate respondsToSelector:@selector(lx_alterMessageTableView:numberOfRowsInSection:)]) {
        return [self.alterMessageDelegate lx_alterMessageTableView:tableView numberOfRowsInSection:section];
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.alterMessageDelegate respondsToSelector:@selector(lx_alterMessageTableView:cellForRowAtIndexPath:)]) {
        return [self.alterMessageDelegate lx_alterMessageTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return [UITableViewCell new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.alterMessageDelegate respondsToSelector:@selector(lx_alterMessageTableView:heightForRowAtIndexPath:)]) {
        return [self.alterMessageDelegate lx_alterMessageTableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.alterMessageDelegate respondsToSelector:@selector(lx_alterMessageTableView:didSelectRowAtIndexPath:)]) {
        [self.alterMessageDelegate lx_alterMessageTableView:tableView didSelectRowAtIndexPath:indexPath];
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
- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        _footerView.userInteractionEnabled = YES;
    }
    return _footerView;
}
- (UIButton *)quiteButton {
    if (!_quiteButton) {
        _quiteButton = [[UIButton alloc] init];
        [_quiteButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_quiteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _quiteButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_quiteButton setBackgroundColor:[UIColor colorWithHexString:@"#309CF5"]];
        _quiteButton.layer.cornerRadius = 5;
        [_quiteButton addTarget:self action:@selector(quiteButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _quiteButton;
}
@end
