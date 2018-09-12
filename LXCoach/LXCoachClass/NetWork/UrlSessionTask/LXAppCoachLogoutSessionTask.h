//
//  LXAppCoachLogoutSessionTask.h
//  LXCoach
//
//  Created by GDD on 2018/9/12.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXAppCoachLogoutResponseObject;

@interface LXAppCoachLogoutSessionTask : LXBaseUrlSessionTask

- (void)lxReuqestAppCoachLogoutWithCompletionBlock:(void(^)(LXAppCoachLogoutResponseObject *responseModel))block;

@end

@interface LXAppCoachLogoutResponseObject : LXNetWorkResponseBaseObject

@end
