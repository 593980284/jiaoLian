//
//  LXNetWorkCacheManager.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXNetWorkCacheManager : NSObject

/**
 *  缓存网络数据,根据请求的 URL与parameters
 *  做KEY存储数据, 这样就能缓存多级页面的数据
 *
 *  @param httpData   服务器返回的数据
 *  @param URL        请求的URL地址
 *  @param parameters 请求的参数
 */
+ (void)lxSetHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters;

/**
 *  根据请求的 URL与parameters 取出缓存数据
 *
 *  @param URL        请求的URL
 *  @param parameters 请求的参数
 *
 *  @return 缓存的服务器数据
 */
+ (id)lxGetHttpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters;

/**
 *  获取网络缓存的总大小 bytes(字节)
 */
+ (NSInteger)lxGetAllHttpCacheSize;

/**
 *  删除所有网络缓存,
 */
+ (void)LXRemoveAllHttpCache;


@end
