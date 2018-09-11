//
//  LXStudentSubView.h
//  LXCoach
//
//  Created by GDD on 2018/9/7.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LXStudentSubViewDelegate <NSObject>
- (NSInteger)lx_myStudentListTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)lx_myStudentListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)lx_myStudentListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)lx_myStudentListTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface LXStudentSubView : UIView
@property (nonatomic, assign) id <LXStudentSubViewDelegate> studentSubViewDelegate;
@end
