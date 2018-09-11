//
//  LXChangePassWordUrlSessionTask.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXChangePassWordUrlSessionTask.h"

@implementation LXChangePassWordUrlSessionTask

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    /// 教练证
    [dic setObject:_certNo forKey:@"certNo"];
    /// 教练旧密码
    [dic setObject:_oldPassword forKey:@"oldPassword"];
    /// 教练新密码
    [dic setObject:_password forKey:@"newPassword"];
    return YES;
}

- (void)lxReuqestChangePassWordWithCompletionBlock:(void(^)(LXChangePassWordResponseObject *responseModel))block {
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kChangePassWord] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXChangePassWordResponseObject class] completionBlock:block];
}
@end


@implementation LXChangePassWordResponseObject

@end
