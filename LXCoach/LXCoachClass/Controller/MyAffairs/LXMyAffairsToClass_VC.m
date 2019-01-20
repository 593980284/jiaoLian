//
//  LXMyAffairsToClass_VC.m
//  LXCoach
//
//  Created by slardar on 2019/1/20.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LXMyAffairsToClass_VC.h"
#import "LXAffairsClassSessionTask.h"
#import "LXMineModel.h"
@interface LXMyAffairsToClass_VC ()
@property (nonatomic,strong) LXAffairsClassSessionTask *classTask;
@end

@implementation LXMyAffairsToClass_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)loadLXMyAffairsToClassData{
    [self.classTask lxReuqestWithCompletionBlock:^(LXAffairsClassResponseObject * _Nonnull responseModel) {
        
    }];
}

-(LXAffairsClassSessionTask *)classTask{
    if (!_classTask) {
        _classTask = [LXAffairsClassSessionTask new];
        LXMineModel *model = [LXCacheManager objectForKey:@"LXMineModel"];
        _classTask.certNo = model.certNo;
    }
    return _classTask;
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
