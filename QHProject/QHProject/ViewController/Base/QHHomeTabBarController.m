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
#import "QHMessageHomeViewController.h"
#import "QHAdressBookViewController.h"
#import "QHMyMainViewController.h"
#import "QHTabBar.h"
#import "QHTabBarItem.h"

@interface QHHomeTabBarController () <QHTabBarDelegate>

@property (nonatomic, strong) QHHomeViewController *homeVC;
@property (nonatomic, strong) QHMessageHomeViewController *messageHomeVC;
@property (nonatomic, strong) QHAdressBookViewController *addressBookVC;
@property (nonatomic, strong) QHMyMainViewController *myMainVC;

@end

@implementation QHHomeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    QHBaseNavigationController *homeNC = [[QHBaseNavigationController alloc] initWithRootViewController:self.homeVC];
    
    QHBaseNavigationController *messageHomeNC = [[QHBaseNavigationController alloc] initWithRootViewController:self.messageHomeVC];
    
    QHBaseNavigationController *addressBookNC = [[QHBaseNavigationController alloc] initWithRootViewController:self.addressBookVC];
    
    QHBaseNavigationController *myMainNC = [[QHBaseNavigationController alloc] initWithRootViewController:self.myMainVC];
    
    self.viewControllers = @[homeNC, messageHomeNC, addressBookNC, myMainNC];
    

    
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
    QHTabBarItem *addressBookTabBarItem = [QHTabBarItem tabBarItemWithFrame:CGRectMake(CGRectGetMaxX(centerButton.frame), 0, normalButtonWith, tabBarHeight)
                                                                      title:@"通讯录"
                                                                normalImage:nil selectedImage:nil type:(QHTabBarItemTypeNormal)];
    QHTabBarItem *myMainTabBarItem = [QHTabBarItem tabBarItemWithFrame:CGRectMake(CGRectGetMaxX(addressBookTabBarItem.frame), 0, normalButtonWith, tabBarHeight)
                                                                 title:@"我的"
                                                           normalImage:nil
                                                         selectedImage:nil
                                                                  type:(QHTabBarItemTypeNormal)];
    
    QHTabBar *qhTabBar = [[QHTabBar alloc] initWithFrame:self.tabBar.bounds];
    qhTabBar.tabBarItems = @[homeTabBarItem, messageHomeTabBarItem, centerButton, addressBookTabBarItem, myMainTabBarItem];
    qhTabBar.delegate = self;
    [self.tabBar addSubview:qhTabBar];
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

- (QHMessageHomeViewController *)messageHomeVC
{
    if (!_messageHomeVC) {
        _messageHomeVC = [[QHMessageHomeViewController alloc] init];
    }
    return _messageHomeVC;
}

- (QHAdressBookViewController *)addressBookVC
{
    if (!_addressBookVC) {
        _addressBookVC = [[QHAdressBookViewController alloc] init];
    }
    return _addressBookVC;
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
