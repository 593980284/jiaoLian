//
//  LXTabBarController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXTabBarController.h"
#import "LXNavigationController.h"
#import "LXStudentController.h"
#import "LXMessageController.h"
#import "LXCourseController.h"
#import "LXMineController.h"

@interface LXTabBarController ()<UITabBarControllerDelegate>

@end

@implementation LXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController];
}

- (void)addChildViewController {
    self.delegate = self;
    NSArray *itemControllerArray = @[@"LXCourseController", @"LXMessageController", @"LXStudentController", @"LXMineController"];
    NSArray *itemTitleArray = @[@"我的课程", @"我的消息", @"我的学员", @"我的"];
    NSArray *itemImageArray = @[@"lx_tabbar_class_normal", @"lx_tabbar_news_normal", @"lx_tabbar_student_normal", @"lx_tabbar_mine_normal"];
    NSArray *itemSelectImageArray = @[@"lx_tabbar_class_select", @"lx_tabbar_news_select", @"lx_tabbar_student_select", @"lx_tabbar_mine_select"];
    NSMutableArray *controllersArray = [NSMutableArray new];
    for (NSInteger i = 0; i < [itemControllerArray count]; i++) {
        LXNavigationController *itemNavigation = [self configControllerWith:itemControllerArray[i] itemTag:i itemTitle:itemTitleArray[i] itemImage:itemImageArray[i] itemSelectImage:itemSelectImageArray[i]];
        [controllersArray addObject:itemNavigation];
    }
    // 加入子控制器
    self.viewControllers = [NSArray arrayWithArray:controllersArray];
    self.selectedIndex = 0;
    [self.tabBar setTintColor:[UIColor colorWithHexString:@"#309CF5"]];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.backgroundImage = [UIImage imageWithColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    // 未选中字体
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} forState:UIControlStateNormal];
    // 选中字体
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} forState:UIControlStateSelected];
}

- (LXNavigationController *)configControllerWith:(NSString *)itemControllerString itemTag:(NSInteger)itemTag itemTitle:(NSString *)itemTitle itemImage:(NSString *)itemImage itemSelectImage:(NSString *)itemSelectImage {
    Class class = NSClassFromString(itemControllerString);
    id itemController = [[class alloc] init];
    LXNavigationController *itemNavigation = [[LXNavigationController alloc]initWithRootViewController:itemController];
    itemNavigation.navigationBar.translucent = NO;
    itemNavigation.tabBarItem.image = [[UIImage imageNamed:itemImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemNavigation.tabBarItem.selectedImage = [[UIImage imageNamed:itemSelectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemNavigation.tabBarItem.title = itemTitle;
    itemNavigation.tabBarItem.tag = itemTag;
    itemNavigation.tabBarItem.imageInsets = UIEdgeInsetsMake(-3.5, 0, 3.5, 0);
    return itemNavigation;
}

#pragma mark - delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (tabBarController.selectedIndex) {
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
