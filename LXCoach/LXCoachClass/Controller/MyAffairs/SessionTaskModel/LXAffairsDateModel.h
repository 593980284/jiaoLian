//
//  LXAffairsDateModel.h
//  LXCoach
//
//  Created by slardar on 2019/1/21.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXAffairsDateModelList: NSObject
@property (nonatomic, strong) NSArray *list;
@end

@interface LXAffairsDateModel : NSObject
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *has;

@property (nonatomic, copy) NSString *week;
@property (nonatomic, copy) NSString *oneDate;
@property (nonatomic, copy) NSString *firstIsOption;

@end

NS_ASSUME_NONNULL_END
