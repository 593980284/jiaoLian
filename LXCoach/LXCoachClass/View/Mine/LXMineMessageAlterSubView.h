//
//  LXMineMessageAlterSubView.h
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXMineMessageAlterSubViewDelegate <NSObject>
@required
- (NSInteger)lx_alterMessageTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)lx_alterMessageTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@optional
- (CGFloat)lx_alterMessageTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)lx_alterMessageTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
/// 退出登录
- (void)lx_outLogin;
@end


@interface LXMineMessageAlterSubView : UIView

@property (nonatomic, assign) id <LXMineMessageAlterSubViewDelegate> alterMessageDelegate;
/**
 刷新tableView
 */
- (void)uploadTableView;
@end
