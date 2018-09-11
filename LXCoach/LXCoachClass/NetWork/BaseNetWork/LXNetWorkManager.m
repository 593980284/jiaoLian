//
//  LXNetWorkManager.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXNetWorkManager.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>


@implementation LXNetWorkManager

static AFHTTPSessionManager *_sessionManager;

#pragma mark - 初始化AFHTTPSessionManager相关属性
+ (void)initialize {
    _sessionManager = [AFHTTPSessionManager manager];
    // 设置请求参数的类型:JSON (AFJSONRequestSerializer,AFHTTPRequestSerializer)
     _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _sessionManager.requestSerializer.timeoutInterval = 10.0f;
    
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    _sessionManager.responseSerializer = response;
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil];
    [_sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
}

#pragma mark - 网络请求的类方法
/**
 *  网络请求的实例方法
 *
 *  @param type         get / post
 *  @param urlString    请求的地址
 *  @param paraments    请求的参数
 *  @param successBlock 请求成功的回调
 *  @param failureBlock 请求失败的回调
 *  @param progress 进度
 */
+ (void)requestWithType:(LXHttpRequestType)type
          withUrlString:(NSString *)urlString
          withParaments:(id)paraments
       withSuccessBlock:(requestSuccess)successBlock
       withFailureBlock:(requestFailure)failureBlock
               progress:(downloadProgress)progress {
    switch (type) {
        case LXHttpRequestTypeGet: {
            [_sessionManager GET:urlString parameters:paraments progress:^(NSProgress * _Nonnull downloadProgress) {
                if (progress) {
                    progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successBlock) {
                    successBlock(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
            break;
        }
        case LXHttpRequestTypePost: {
            [_sessionManager POST:urlString parameters:paraments progress:^(NSProgress * _Nonnull uploadProgress) {
                if (progress) {
                    progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successBlock) {
                    successBlock(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
        }
            break;
    }
}

@end
