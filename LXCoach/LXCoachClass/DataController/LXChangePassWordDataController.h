//
//  LXChangePassWordDataController.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LXChangePassWordResponseObject;

@interface LXChangePassWordDataController : NSObject

- (void)lxReuqestChangePassWordWithCertNo:(NSString *)certNo oldPassword:(NSString *)oldPassword password:(NSString *)password completionBlock:(void(^)(LXChangePassWordResponseObject *responseModel))block;

@end
