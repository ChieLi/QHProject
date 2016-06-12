//
//  QHBaseViewController.m
//  QHProject
//
//  Created by Chie Li on 16/4/6.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHBaseViewController.h"
#import "UIViewController+NavigationItem.h"

@interface QHBaseViewController ()<QHConversationDelegate>

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation QHBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[QHConversationManager sharedInstance] changeConversationDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initial
- (void)initialViews
{
    self.navigationItem.leftBarButtonItems = [self barItemsWithCustomView:self.backButton];
    self.navigationController.fd_interactivePopDisabled = NO;
}

#pragma mark - navigation setting
- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

#pragma mark - event response
- (void)didClickBackButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - property getter
- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        [_backButton setTitle:@"返回" forState:(UIControlStateNormal)];
        [_backButton addTarget:self action:@selector(didClickBackButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [_backButton sizeToFit];
        [_backButton setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -15, -10, -15)];
    }
    return _backButton;
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
