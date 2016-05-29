//
//  QHHomeContainerViewController.m
//  QHProject
//
//  Created by Chie Li on 16/5/29.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHHomeContainerViewController.h"
#import "QHLoginViewController.h"
#import "QHHomeTabBarController.h"

@interface QHHomeContainerViewController ()

@property (nonatomic, assign) QHHomeContainerViewControllerStatus status;
@property (nonatomic, strong) UIViewController *currentViewController;
@end

@implementation QHHomeContainerViewController

- (instancetype)initWithSatus:(QHHomeContainerViewControllerStatus)status
{
    if (self = [super init]) {
        self.status = status;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.status == QHHomeContainerViewControllerStatusLogin) {
        QHLoginViewController *loginVC = [[QHLoginViewController alloc] init];
        [self addChildViewController:loginVC];
        [self.view addSubview:loginVC.view];
        self.currentViewController = loginVC;
    } else {
        QHHomeTabBarController *homeTBC = [[QHHomeTabBarController alloc] init];
        [self addChildViewController:homeTBC];
        [self.view addSubview:homeTBC.view];
        self.currentViewController = homeTBC;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - private method
- (void)transitionToViewController:(UIViewController *)viewController completion:(void(^)(BOOL finished))completion
{
    [self addChildViewController:viewController];
    
    [self transitionFromViewController:self.currentViewController toViewController:viewController duration:0.5 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        
    } completion:^(BOOL finished) {
       
    }];
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
