//
//  QHLaunchViewController.m
//  QHProject
//
//  Created by Chie Li on 16/5/16.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHLaunchViewController.h"
#import "QHLoginViewController.h"
#import "QHHomeTabBarController.h"
#import "AppDelegate.h"

@interface QHLaunchViewController ()

@property (nonatomic, assign) BOOL isLogined;
@property (nonatomic, strong) QHLoginViewController *loginVC;
@property (nonatomic, strong) QHHomeTabBarController *homeTBC;

@end

@implementation QHLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    if (self.isLogined) {
        self.homeTBC = [[QHHomeTabBarController alloc] init];
    } else {
        self.loginVC = [[QHLoginViewController alloc] init];
    }
    
    // Temp
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(finishedLaunching) userInfo:nil repeats:NO];
    
}

- (void)initialViews
{
    [super initialViews];
    
    //Temp
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"这是App加载页面";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
- (void)finishedLaunching
{
    UIViewController *toViewController;
    
    if (self.isLogined) {
        toViewController = self.homeTBC;
    } else {
        UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:self.loginVC];
        toViewController = rootNC;
    }
    
    [UIView transitionFromView:self.view
                        toView:toViewController.view
                      duration:0.4
                       options:(UIViewAnimationOptionTransitionCrossDissolve)
                    completion:^(BOOL finished) {
                        
                        [AppDelegate getAppDelegate].window.rootViewController = toViewController;
                        [self.view removeAllSubViews];
        
                    }];
}

#pragma mark - property getter
- (BOOL)isLogined
{
    return ![QHUserManager currentUser] ? NO : YES;
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
