//
//  LXBaseUrlSessionTask.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import "LXUrlApi.h"
#import "LXNetWorkManager.h"
#import "LXNetWorkResponseBaseObject.h"

@interface LXBaseUrlSessionTask : NSObject

/**
 处理请求通用方法
 
 @param urlString  Url
 @param parameters 接口所需参数
 @param needCache  是否需要缓存该请求数据
 @param cacheParameters 缓存keyNSDictionary
 @param modelClass 解析数据的Model
 @param block 回调的block
 */
- (void)lxRequestWithUrlString:(NSString *)urlString requestType:(LXHttpRequestType)requestType parameters:(NSDictionary *)parameters needCache:(BOOL)needCache cacheParameters:(NSDictionary *)cacheParameters reponseModelClass:(Class)modelClass completionBlock:(void(^)(id responseModel))block;

@end
