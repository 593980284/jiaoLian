//
//  LXUploadCoachImageDataController.m
//  LXCoach
//
//  Created by GDD on 2018/9/12.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXUploadCoachImageDataController.h"
#import "LXUploadCoachImageSessionTask.h"

@implementation LXUploadCoachImageDataController
/**
 上传图片
 
 @param certNo 教练证号
 @param imageCode imageCode
 @param block block
 */
- (void)lxReuqestSaveNewPhoneNumWithCertNo:(NSString *)certNo imageCodeString:(NSString *)imageCode  completionBlock:(void(^)(LXUploadCoachImageResponseObject *responseModel))block {
    LXUploadCoachImageSessionTask *task = [[LXUploadCoachImageSessionTask alloc] init];
    task.certNo = certNo;
    task.imageCode = imageCode;
    [task lxReuqestUploadCoachImageWithCompletionBlock:^(LXUploadCoachImageResponseObject *responseModel) {
        block(responseModel);
    }];
}
@end
