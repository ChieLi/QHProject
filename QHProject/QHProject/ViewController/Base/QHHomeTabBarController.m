//
//  QHHomeTabBarController.m
//  QHProject
//
//  Created by Chie Li on 16/5/16.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHHomeTabBarController.h"
#import "QHBaseNavigationController.h"
#import "QHHomeViewController.h"
#import "QHMessageViewController.h"
#import "QHContactsViewController.h"
#import "QHMyMainViewController.h"
#import "QHTabBar.h"
#import "QHTabBarItem.h"

@interface QHHomeTabBarController () <QHTabBarDelegate>

@property (nonatomic, strong) QHHomeViewController *homeVC;
@property (nonatomic, strong) QHMessageViewController *messageVC;
@property (nonatomic, strong) QHContactsViewController *contactsVC;
@property (nonatomic, strong) QHMyMainViewController *myMainVC;

@end

@implementation QHHomeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[QHConversationManager sharedInstance] openClientWithCallBackBlock:^(BOOL boolean, NSError *error) {
        if (error) {
            [self alertViewWithTitle:@"警告" message:error.detail cancelBlock:nil];
        }
    }];
    
    QHBaseNavigationController *homeNC = [[QHBaseNavigationController alloc] initWithRootViewController:self.homeVC];
    
    QHBaseNavigationController *messageNC = [[QHBaseNavigationController alloc] initWithRootViewController:self.messageVC];
    
    QHBaseNavigationController *contactsNC = [[QHBaseNavigationController alloc] initWithRootViewController:self.contactsVC];
    
    QHBaseNavigationController *myMainNC = [[QHBaseNavigationController alloc] initWithRootViewController:self.myMainVC];
    
    self.viewControllers = @[homeNC, messageNC, contactsNC, myMainNC];
    

    
    CGFloat centerButtonWidth = kScreenWidth / 4.f;
    CGFloat normalButtonWith = (kScreenWidth - centerButtonWidth) / 4.f;
    CGFloat tabBarHeight = CGRectGetHeight(self.tabBar.frame);
    
    QHTabBarItem *homeTabBarItem = [QHTabBarItem tabBarItemWithFrame:CGRectMake(0, 0, normalButtonWith, tabBarHeight)
                                                               title:@"首页"
                                                         normalImage:[UIImage imageNamed:@"Home_Normal"]
                                                       selectedImage:[UIImage imageNamed:@"Home_HightLight"]
                                                                type:(QHTabBarItemTypeNormal)];
    
    QHTabBarItem *messageHomeTabBarItem = [QHTabBarItem tabBarItemWithFrame:CGRectMake(CGRectGetMaxX(homeTabBarItem.frame), 0, normalButtonWith, tabBarHeight)
                                                                      title:@"消息"
                                                                normalImage:nil
                                                              selectedImage:nil
                                                                       type:(QHTabBarItemTypeNormal)];
    
    QHTabBarItem *centerButton = [QHTabBarItem tabBarItemWithFrame:CGRectMake(CGRectGetMaxX(messageHomeTabBarItem.frame), 0, centerButtonWidth, tabBarHeight)
                                                              title:@"发布"
                                                        normalImage: [UIImage imageNamed:@"CenterButton"]
                                                      selectedImage:[UIImage imageNamed:@"CenterButton"]
                                                               type:(QHTabBarItemTypeAbnormal)];
    QHTabBarItem *contactsTabBarItem = [QHTabBarItem tabBarItemWithFrame:CGRectMake(CGRectGetMaxX(centerButton.frame), 0, normalButtonWith, tabBarHeight)
                                                                      title:@"通讯录"
                                                                normalImage:nil selectedImage:nil type:(QHTabBarItemTypeNormal)];
    QHTabBarItem *myMainTabBarItem = [QHTabBarItem tabBarItemWithFrame:CGRectMake(CGRectGetMaxX(contactsTabBarItem.frame), 0, normalButtonWith, tabBarHeight)
                                                                 title:@"我的"
                                                           normalImage:nil
                                                         selectedImage:nil
                                                                  type:(QHTabBarItemTypeNormal)];
    
    QHTabBar *qhTabBar = [[QHTabBar alloc] initWithFrame:self.tabBar.bounds];
    qhTabBar.tabBarItems = @[homeTabBarItem, messageHomeTabBarItem, centerButton, contactsTabBarItem, myMainTabBarItem];
    qhTabBar.delegate = self;
    [self.tabBar addSubview:qhTabBar];
    
    [[UITabBar appearance]setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - QHTabBArDelegate
- (void)qhTabBarDidClickedAbNormalButton:(QHTabBarItem *)tabBarItem
{
    NSLog(@"123");
}


#pragma mark - property getter
- (QHHomeViewController *)homeVC
{
    if (!_homeVC) {
        _homeVC = [[QHHomeViewController alloc] init];
    }
    return _homeVC;
}

- (QHMessageViewController *)messageVC
{
    if (!_messageVC) {
        _messageVC = [[QHMessageViewController alloc] init];
    }
    return _messageVC;
}

- (QHContactsViewController *)contactsVC
{
    if (!_contactsVC) {
        _contactsVC = [[QHContactsViewController alloc] init];
    }
    return _contactsVC;
}

- (QHMyMainViewController *)myMainVC
{
    if (!_myMainVC) {
        _myMainVC = [[QHMyMainViewController alloc] init];
    }
    return _myMainVC;
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
