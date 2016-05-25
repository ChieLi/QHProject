//
//  QHLoginViewController.m
//  QHProject
//
//  Created by Chie Li on 16/4/18.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHLoginViewController.h"
#import "QHChooseRegisterTypeViewController.h"
#import "QHHomeTabBarController.h"
#import "AppDelegate.h"
@interface QHLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation QHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event response
- (IBAction)clickLoginButton:(id)sender {
    
    [QHUserManager loginWithUsername:self.userNameTextField.text password:self.passwordTextField.text block:^(BOOL boolean, NSError *error) {
        if (boolean) {
            QHHomeTabBarController *homeTC = [[QHHomeTabBarController alloc] init];
            [UIView transitionFromView:self.view toView:homeTC.view duration:0.5 options:(UIViewAnimationOptionCurveEaseOut) completion:^(BOOL finished) {
                [AppDelegate getAppDelegate].window.rootViewController = homeTC;
            }];
            
        } else {
            [self alertViewWithTitle:@"警告" message:error.detail cancelBlock:nil];
        }
    }];
    
}

- (IBAction)clickRegisterButton:(id)sender {
    QHChooseRegisterTypeViewController *chooseVC = [[QHChooseRegisterTypeViewController alloc] init];
    [self.navigationController pushViewController:chooseVC animated:YES];
}

- (IBAction)clickForgetPasswordButton:(id)sender {
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
