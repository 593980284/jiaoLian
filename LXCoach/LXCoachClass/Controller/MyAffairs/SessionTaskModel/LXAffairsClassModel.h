//
//  LXMyAffairsClassModel.h
//  LXCoach
//
//  Created by slardar on 2019/1/21.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXMyAffairsClassModelList: NSObject
@property (nonatomic, strong) NSArray *list;
@end

@interface LXMyAffairsClassModel : NSObject
//科目id
@property (nonatomic, copy) NSString *subjectId;
//科目名称
@property (nonatomic, copy) NSString *subjectName;
//约课时间段
@property (nonatomic, copy) NSString *periodTime;
//班级
@property (nonatomic, copy) NSString *className;
//报名人数
@property (nonatomic, copy) NSString *appointmentNum;
//最大人数
@property (nonatomic, copy) NSString *maxNum;
//课程id
@property (nonatomic, copy) NSString *appointmentId;
@end

NS_ASSUME_NONNULL_END
