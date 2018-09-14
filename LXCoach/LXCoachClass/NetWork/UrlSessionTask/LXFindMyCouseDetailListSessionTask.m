//
//  LXFindMyCouseDetailListSessionTask.m
//  LXCoach
//
//  Created by GDD on 2018/9/14.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXFindMyCouseDetailListSessionTask.h"

@implementation LXFindMyCouseDetailListSessionTask

- (void)lxReuqestFindMyCouseDetailListWithCompletionBlock:(void(^)(LXFindMyCouseDetailListResponseObject *responseModel))block {
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kfindMyCouseDetailList] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXFindMyCouseDetailListResponseObject class] completionBlock:block];
}

@end


@implementation LXFindMyCouseDetailListResponseObject

@end
