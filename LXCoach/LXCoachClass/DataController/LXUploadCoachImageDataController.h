//
//  LXUploadCoachImageDataController.h
//  LXCoach
//
//  Created by GDD on 2018/9/12.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LXUploadCoachImageResponseObject;

@interface LXUploadCoachImageDataController : NSObject

/**
 上传图片

 @param certNo 教练证号
 @param imageCode imageCode
 @param block block
 */
- (void)lxReuqestSaveNewPhoneNumWithCertNo:(NSString *)certNo imageCodeString:(NSString *)imageCode  completionBlock:(void(^)(LXUploadCoachImageResponseObject *responseModel))block;

@end
