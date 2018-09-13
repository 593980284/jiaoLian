//
//  LXMyStudentListModel.h
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 我的学员列表
 */
@interface LXMyStudentListModel : NSObject

/// 学员id
@property (nonatomic, copy)NSString *studentId;
/// 学员名称
@property (nonatomic, copy)NSString *studentName;
/// 学员相片路径
@property (nonatomic, copy)NSString *studentPhoto;
/// 学员手机号
@property (nonatomic, copy)NSString *mobile;
/// 科目名称
@property (nonatomic, copy)NSString *subjectName;

@end
