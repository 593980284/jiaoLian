//
//  LXMineMainSubView.h
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXMineModel;

@protocol LXMineMainSubViewDelegate <NSObject>
@required
- (NSInteger)lx_numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)lx_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
@optional
- (UITableViewCell *)lx_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)lx_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)lx_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)lx_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
- (void)lx_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/// 点击头像
- (void)lx_clickHeaderAction;

@end

@interface LXMineMainSubView : UIView
@property (nonatomic, assign) id <LXMineMainSubViewDelegate> mainMineDelegate;
/**
 刷新数据
 
 @param model model
 */
- (void)lx_updateMineMessage:(LXMineModel *)model;
@end
