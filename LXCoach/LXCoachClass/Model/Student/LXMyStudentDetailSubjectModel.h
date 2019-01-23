//
//  LXMyStudentDetailSubjectModel.h
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 科目model
 */
@interface LXMyStudentDetailSubjectModel : NSObject

/**
 1:科目一，2：科目二，3：科目三，4：科目四，23：科目二,三
 */
@property (nonatomic,copy) NSString *subject;
@property (nonatomic,copy) NSString *className;
@property (nonatomic,strong) NSArray *list;
@end

@interface LXMyStudentDetailModel : NSObject
/**
 状态
 2，6：已完成
 3，7：缺勤
 0：已预约
 1：学员签到
 4：未签到
 5：等待确认
 10：已取消
 */
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *time;
@end
