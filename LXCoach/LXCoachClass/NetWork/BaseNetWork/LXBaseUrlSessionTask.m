//
//  LXBaseUrlSessionTask.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
#import <AFNetworking/AFNetworking.h>
#import <YYModel/YYModel.h>
#import <YYCategories/NSDictionary+YYAdd.h>
#import "LXNetWorkCacheManager.h"

@implementation LXBaseUrlSessionTask

/**
 处理请求通用方法
 
 @param urlString  Url
 @param parameters 接口所需参数
 @param needCache  是否需要缓存该请求数据
 @param cacheParameters 缓存keyNSDictionary
 @param modelClass 解析数据的Model
 @param block 回调的block
 */
- (void)lxRequestWithUrlString:(NSString *)urlString requestType:(LXHttpRequestType)requestType parameters:(NSDictionary *)parameters needCache:(BOOL)needCache cacheParameters:(NSDictionary *)cacheParameters reponseModelClass:(Class)modelClass completionBlock:(void(^)(id responseModel))block {
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    [LXNetWorkManager requestWithType:LXHttpRequestTypePost withUrlString:urlString withParaments:postParameters withSuccessBlock:^(NSDictionary *object) {
        if (block) {
            LXNetWorkResponseBaseObject *responseModel = [LXNetWorkResponseBaseObject yy_modelWithJSON:object];
            NSInteger status = responseModel.flg;
            if (status == 1) {
                NSMutableDictionary *modifyResponseDic = [NSMutableDictionary dictionaryWithDictionary:object];
                if (needCache) {
                    [LXNetWorkCacheManager lxSetHttpCache:modifyResponseDic URL:urlString parameters:cacheParameters];
                }
                id decrypteDataModel = [modelClass yy_modelWithJSON:modifyResponseDic];
                [decrypteDataModel setResponseType:LXNetWorkResponseTypeSuccess];
                block(decrypteDataModel);
                [self logUrl:urlString parameters:postParameters responseData:modifyResponseDic];
            } else {
                // 返回缓存数据
                id cacheModel = [modelClass yy_modelWithJSON:[LXNetWorkCacheManager lxGetHttpCacheForURL:urlString parameters:cacheParameters]];
                if (needCache && [cacheModel isKindOfClass:[LXNetWorkResponseBaseObject class]] && block) {
                    [cacheModel setResponseType:LXNetWorkResponseTypeCacheData];
                    block(cacheModel);
                } else {
                    [responseModel setResponseType:LXNetWorkResponseTypeUnknownError];
                    block(responseModel);
                }
                [self logUrl:urlString parameters:postParameters responseData:object];
            }
            // 保存Cookie
            [self saveCookies];
        }
    } withFailureBlock:^(NSError *error) {
        [self logUrl:urlString parameters:postParameters responseData:error];
        if (block) {
            LXNetWorkResponseBaseObject *model = [LXNetWorkResponseBaseObject new];
            switch (error.code) {
                case NSURLErrorNotConnectedToInternet:
                case NSURLErrorNetworkConnectionLost:
                case NSURLErrorCannotConnectToHost:
                case NSURLErrorBadServerResponse:{
                    model.responseType = LXNetWorkResponseTypeErrorLoseInternet;
                    model.msg = @"网络错误，请稍后重试";
                }
                    break;
                case NSURLErrorTimedOut: {
                    model.responseType = LXNetWorkResponseTypeErrorTimeOut;
                    model.msg = @"请求超时";
                }
                    break;
                default: {
                    model.responseType = LXNetWorkResponseTypeUnknownError;
                    model.msg = @"请求失败";
                }
                    break;
            }
            // 被取消的请求不返回缓存
            if (needCache && error.code != NSURLErrorCancelled) {
                id cacheModel = [modelClass yy_modelWithJSON:[LXNetWorkCacheManager lxGetHttpCacheForURL:urlString parameters:cacheParameters]];
                if ([cacheModel isKindOfClass:[LXNetWorkResponseBaseObject class]]) {
                    [cacheModel setResponseType:model.responseType];
                }
                [cacheModel setResponseType:LXNetWorkResponseTypeCacheData];
                block(cacheModel);
            }
            else {
                block(model);
            }
        }
    } progress:nil];
}

/**
 打印返回数据
 */
- (void)logUrl:(NSString *)urlString parameters:(NSDictionary *)parameters responseData:(id)responseData {
#ifdef DEBUG
    if ([responseData isKindOfClass:[NSError class]]) {
        NSDictionary *errorInfo = [[(NSError *)responseData userInfo][NSUnderlyingErrorKey] userInfo];
        NSData *errorData = errorInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSString* errorResponse = [[NSString alloc] initWithData:errorData encoding:NSUTF8StringEncoding];
        // json串打印
        NSLog(@"数据请求失败 Url: %@\n请求参数：%@ \n responseError:%@", urlString,[parameters jsonStringEncoded], (errorResponse.length != 0)? errorResponse:responseData);
    } else {
        // json串打印
        NSLog(@"数据请求成功 Url: %@\n请求参数：%@\nresponseData:%@", urlString,[parameters jsonStringEncoded], [responseData yy_modelToJSONString]);
    }
#endif
}

    
//保存Cookie
- (void)saveCookies
{
    NSData*cookiesData = [NSKeyedArchiver archivedDataWithRootObject:[[NSHTTPCookieStorage sharedHTTPCookieStorage]cookies]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:cookiesData forKey:@"org.skyfox.cookie"];
    [defaults synchronize];
}

@end
