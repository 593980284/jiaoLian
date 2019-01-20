//
//  LXMyAffairsToHandle_VC.m
//  LXCoach
//
//  Created by slardar on 2019/1/20.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LXMyAffairsToHandle_VC.h"
#import "LXAffairsHandleSessionTask.h"
#import "LXAffairsDateSessionTask.h"
#import "LXMineModel.h"
@interface LXMyAffairsToHandle_VC ()
@property (nonatomic,strong) LXAffairsHandleSessionTask *handleTask;
@property (nonatomic,strong) LXAffairsDateSessionTask *dateTask;
@end

@implementation LXMyAffairsToHandle_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)loadLXMyAffairsToHandleData{
    [self.dateTask lxReuqestWithCompletionBlock:^(LXAffairsDateResponseObject * _Nonnull responseModel) {
        
    }];
}
-(LXAffairsHandleSessionTask *)handleTask{
    if (!_handleTask) {
        _handleTask = [LXAffairsHandleSessionTask new];
        LXMineModel *model = [LXCacheManager objectForKey:@"LXMineModel"];
        _handleTask.certNo = model.certNo;
    }
    return _handleTask;
}
-(LXAffairsDateSessionTask *)dateTask{
    if (!_dateTask) {
        _dateTask = [LXAffairsDateSessionTask new];
        LXMineModel *model = [LXCacheManager objectForKey:@"LXMineModel"];
        _dateTask.certNo = model.certNo;
    }
    return _dateTask;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
