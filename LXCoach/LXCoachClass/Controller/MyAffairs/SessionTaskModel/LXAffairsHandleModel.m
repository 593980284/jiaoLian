//
//  LXAffairsHandleModel.m
//  LXCoach
//
//  Created by slardar on 2019/1/21.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LXAffairsHandleModel.h"
@implementation LXAffairsHandleModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [LXAffairsHandleList class]};
}
@end
@implementation LXAffairsHandleList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"sslist" : [LXAffairsHandleSSlist class]};
}
@end
@implementation LXAffairsHandleSSlist

@end
