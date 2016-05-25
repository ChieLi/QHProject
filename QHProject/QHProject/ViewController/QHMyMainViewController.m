//
//  QHMyMainViewController.m
//  QHProject
//
//  Created by Chie Li on 16/5/14.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHMyMainViewController.h"
#import "QHLoginViewController.h"
#import "AppDelegate.h"

@interface QHMyMainViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *menuArray;

@end

@implementation QHMyMainViewController

- (void)dealloc
{
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.detailTextLabel.text = @"退出登录";
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - private method
- (void)didClickLogout
{
    [QHUserManager logout];
    QHLoginViewController *loginVC = [[QHLoginViewController alloc] init];
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    [UIView transitionFromView:self.view toView:rootNC.view duration:0.4 options:(UIViewAnimationOptionCurveEaseInOut) completion:^(BOOL finished) {
        [AppDelegate getAppDelegate].window.rootViewController = rootNC;
    }];
    
}

#pragma mark - property getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }

    return _tableView;
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
