//
//  LXAffairsClassSessionTask.m
//  LXCoach
//
//  Created by slardar on 2019/1/20.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LXAffairsClassSessionTask.h"

@implementation LXAffairsClassSessionTask
-(void)lxReuqestWithCompletionBlock:(void (^)(LXAffairsClassResponseObject * _Nonnull))block{
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kFindMyAffairsToClassList] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXAffairsClassResponseObject class] completionBlock:block];
}
@end

@implementation LXAffairsClassResponseObject

@end
