//
//  LXAffairsHandleModel.h
//  LXCoach
//
//  Created by slardar on 2019/1/21.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface LXAffairsHandleModel : NSObject
@property (nonatomic, copy) NSArray *list;
@end
@interface LXAffairsHandleList : NSObject
@property (nonatomic, copy) NSString *shortPeriodTime;
@property (nonatomic, copy) NSArray *sslist;
@end
@interface LXAffairsHandleSSlist : NSObject
//1:学员签到 4:未签到
@property (nonatomic, copy) NSString *status;
//普通班
@property (nonatomic, copy) NSString *className;
//图片
@property (nonatomic, copy) NSString *studentPhoto;
//性别  男 女
@property (nonatomic, copy) NSString *studentSex;
//课程id
@property (nonatomic, copy) NSString *courseRecordId;
//名字
@property (nonatomic, copy) NSString *studentName;
//科目二
@property (nonatomic, copy) NSString *subjectName;
@end
NS_ASSUME_NONNULL_END
