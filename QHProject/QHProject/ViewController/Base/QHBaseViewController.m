//
//  QHBaseViewController.m
//  QHProject
//
//  Created by Chie Li on 16/4/6.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHBaseViewController.h"

@interface QHBaseViewController ()<QHConversationDelegate>

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
