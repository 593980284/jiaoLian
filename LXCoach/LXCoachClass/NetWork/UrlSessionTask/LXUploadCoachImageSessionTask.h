//
//  LXUploadCoachImageSessionTask.h
//  LXCoach
//
//  Created by GDD on 2018/9/11.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXMineModel;
@class LXUploadCoachImageResponseObject;

@interface LXUploadCoachImageSessionTask : LXBaseUrlSessionTask
///教练证号
@property (nonatomic, copy) NSString *certNo;
/// 图片数据（格式为base64）
@property (nonatomic, copy) NSString *imageCode;

- (void)lxReuqestUploadCoachImageWithCompletionBlock:(void(^)(LXUploadCoachImageResponseObject *responseModel))block;

@end


@interface LXUploadCoachImageResponseObject : LXNetWorkResponseBaseObject
@property (nonatomic, copy) LXMineModel *data;
@end
