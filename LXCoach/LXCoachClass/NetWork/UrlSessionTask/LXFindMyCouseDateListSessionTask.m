//
//  LXFindMyCouseDateListSessionTask.m
//  LXCoach
//
//  Created by GDD on 2018/9/11.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXFindMyCouseDateListSessionTask.h"
#import "LXCourseFindDateListModel.h"
@implementation LXFindMyCouseDateListSessionTask

- (void)lxReuqestFindMyCouseDateListWithCompletionBlock:(void(^)(LXFindMyCouseDateListResponseObject *responseModel))block {
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kfindMyCouseDateList] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXFindMyCouseDateListResponseObject class] completionBlock:block];
}

@end

@implementation LXFindMyCouseDateListResponseObject


@end
