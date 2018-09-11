//
//  LXNetWorkCacheManager.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXNetWorkCacheManager.h"
#import <YYCache/YYCache.h>

@interface LXNetWorkCacheManager()

@property (nonatomic, strong) YYCache *dataCache;

@end

@implementation LXNetWorkCacheManager

static NSString *const LXNetWorkResponseCache = @"LXNetWorkResponseCache";

+ (instancetype)shareCache {
    static LXNetWorkCacheManager *cacheManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cacheManager = [[LXNetWorkCacheManager alloc]init];
        cacheManager.dataCache = [YYCache cacheWithName:LXNetWorkResponseCache];
    });
    return cacheManager;
}

+ (void)lxSetHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    YYCache *cache = [[self shareCache] dataCache];
    [cache setObject:httpData forKey:cacheKey withBlock:nil];
}


+ (id)lxGetHttpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    YYCache *cache = [[self shareCache] dataCache];
    return [cache objectForKey:cacheKey];
}


+ (NSInteger)lxGetAllHttpCacheSize {
    YYCache *cache = [[self shareCache] dataCache];
    return [cache.diskCache totalCost];
}


+ (void)LXRemoveAllHttpCache {
    YYCache *cache = [[self shareCache] dataCache];
    [cache.diskCache removeAllObjects];
}

+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    if(!parameters){return URL;};
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    // 将URL与转换好的参数字符串拼接在一起,成为最终存储的KEY值
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",URL,paraString] ;
    return cacheKey;
}


@end
