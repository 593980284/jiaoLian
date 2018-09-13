//
//  LXFindMyStudentDetilSessionTask.m
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXFindMyStudentDetilSessionTask.h"
#import "LXStudentSubjectDetailModel.h"

@implementation LXFindMyStudentDetilSessionTask
- (void)lxReuqestFindMyStudentDetilWithCompletionBlock:(void(^)(LXFindMyStudentDetilResponseObject *responseModel))block {
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kFindMyStudentDetil] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXFindMyStudentDetilResponseObject class] completionBlock:block];
}
@end

@implementation LXFindMyStudentDetilResponseObject
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list_1" : [LXStudentSubjectDetailModel class],
             @"list_2" : [LXStudentSubjectDetailModel class],
             @"list_3" : [LXStudentSubjectDetailModel class],
             @"list_4" : [LXStudentSubjectDetailModel class]
             };
}
@end
