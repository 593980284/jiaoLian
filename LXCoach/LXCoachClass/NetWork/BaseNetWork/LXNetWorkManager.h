//
//  LXNetWorkManager.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 定义请求类型的枚举
typedef NS_ENUM(NSInteger, LXHttpRequestType) {
    LXHttpRequestTypeGet = 0,
    LXHttpRequestTypePost,
};

/// 定义请求成功的block
typedef void(^requestSuccess)(NSDictionary *object);
/// 定义请求失败的block
typedef void(^requestFailure)(NSError *error);
/// 定义上传进度block
typedef void(^uploadProgress)(float progress);
/// 定义下载进度block
typedef void(^downloadProgress)(float progress);

@interface LXNetWorkManager : NSObject

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
               progress:(downloadProgress)progress;



@end
