//
//  LXVersionUpdateModel.h
//  LXCoach
//
//  Created by GDD on 2018/9/21.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXVersionUpdateModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *downloadUrl;

@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *desc;
@end
