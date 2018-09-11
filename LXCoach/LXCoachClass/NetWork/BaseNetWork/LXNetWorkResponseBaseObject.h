//
//  LXNetWorkResponseBaseObject.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LXNetWorkResponseType) {
    LXNetWorkResponseTypeUnknownError = -1, // 未知错误
    LXNetWorkResponseTypeSuccess = 1000 ,//数据返回成功
    LXNetWorkResponseTypeErrorLoseInternet,//联网失败
    LXNetWorkResponseTypeErrorTimeOut, // 联网超时
    LXNetWorkResponseTypeCacheData //返回缓存数据
};


/**
 网络响应数据基类
 */
@interface LXNetWorkResponseBaseObject : NSObject

@property (nonatomic, assign) NSInteger flg;
@property (nonatomic, copy)   NSString *msg;
/** 数据响应状态 */
@property (nonatomic, assign) LXNetWorkResponseType responseType;


@end
