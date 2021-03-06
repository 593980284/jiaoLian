//
//  LXMineModel.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXMineModel : NSObject <NSCoding, NSCopying>

/// 驾校名称
@property (nonatomic, copy)   NSString *schoolName;
/// 教练姓名
@property (nonatomic, copy)   NSString *coachName;
/// 教练证号
@property (nonatomic, copy)   NSString *certNo;
/// 教龄
@property (nonatomic, copy)   NSString *teachAge;
//科目一/安全
@property (nonatomic, copy)   NSString *teachType;
/// 当前学员数
@property (nonatomic, copy)   NSString *studentNum;
/// 头像地址
@property (nonatomic, copy)   NSString *photo;
/// 返回头像地址
@property (nonatomic, copy)   NSString *picUrl;
//身份标识
@property (nonatomic, copy)   NSString *identity;
//标签
@property (nonatomic, copy)   NSString *coachLabel;
//6.8
@property (nonatomic, copy)   NSString *coachStar;
/// 当前教练车车牌号
@property (nonatomic, copy)   NSString *carNo;
/// 电话号码
@property (nonatomic, copy)   NSString *phone;
/// 教练个人简介
@property (nonatomic, copy)   NSString *present;


@end

