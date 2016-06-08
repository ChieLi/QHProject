//
//  QHBaseViewController.m
//  QHProject
//
//  Created by Chie Li on 16/4/6.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHBaseViewController.h"

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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
}

#pragma mark - event response
- (void)didClickBackButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
