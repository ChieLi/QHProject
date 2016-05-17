//
//  QHRegisterViewController.m
//  QHProject
//
//  Created by Chie Li on 16/5/12.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHRegisterViewController.h"
#import "QHHomeTabBarController.h"
#import "AppDelegate.h"

@interface QHRegisterViewController ()

@property (weak, nonatomic) IBOutlet UILabel *emailTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *verifyCodeTitleLabel;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *verifyCodeButton;
@property (nonatomic, strong) NSTimer *verifyCodeTimer;
@property (nonatomic, assign) NSInteger restTimeOfVerifyCode;
@property (nonatomic, assign) QHRegisterViewControllerType type;

@end

@implementation QHRegisterViewController

#pragma mark - init

- (instancetype)initWithType:(QHRegisterViewControllerType)type
{
    if (self = [super init]) {
        self.type = type;
        self.restTimeOfVerifyCode = 60;
    }
    
    return self;
}

#pragma mark - life cycle

- (void)dealloc
{
    if (self.verifyCodeTimer) {
        [self.verifyCodeTimer invalidate];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

}

- (void)initialViews
{
    [super initialViews];
    
    if (self.type == QHRegisterViewControllerTypeEmail) {
        self.phoneNumberTitleLabel.hidden = YES;
        self.verifyCodeTitleLabel.hidden = YES;
        self.verifyCodeTextField.hidden = YES;
        self.verifyCodeButton.hidden = YES;
    } else {
        self.emailTitleLabel.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event response
- (IBAction)didClickSendVerifyCodeButton:(id)sender {
    
    if (self.usernameTextField.text.length != 11) {
        [self alertViewWithTitle:@"提示" message:@"请正确输入手机号" cancelBlock:nil];
    } else {
        [QHUserManager requestPhoneNumberVerify:self.usernameTextField.text block:^(BOOL boolean, NSError *error) {
            if (boolean) {
                [self alertViewWithTitle:@"提示" message:@"验证码已发送" cancelBlock:nil];
            } else {
                [self alertViewWithTitle:@"警告" message:error.detail cancelBlock:nil];
            }
        }];
    }
}

- (void)timingVerifyCode
{
    if (self.restTimeOfVerifyCode == 0) {
        [self.verifyCodeTimer invalidate];
        self.verifyCodeButton.enabled = YES;
        [self.verifyCodeButton setTitle:@"重新发送" forState:(UIControlStateNormal)];
        self.restTimeOfVerifyCode = 60;
        return;
    }
    [self.verifyCodeButton setTitle:[NSString stringWithFormat:@"%lds后重新发送", self.restTimeOfVerifyCode] forState:(UIControlStateDisabled)];
    self.restTimeOfVerifyCode -= 1;
    
}


- (IBAction)didClickRegisterButton:(id)sender {
    
    if (self.type == QHRegisterViewControllerTypeEmail) {
        [QHUserManager registerWithEmail:self.usernameTextField.text password:self.passwordTextField.text block:^(BOOL boolean, NSError *error) {
            if (boolean) {
                [self alertViewWithTitle:@"提示" message:@"注册成功" cancelBlock:^{
                    QHHomeTabBarController *homeTBC = [[QHHomeTabBarController alloc] init];
                    [AppDelegate getAppDelegate].window.rootViewController = homeTBC;
                }];
            } else {
                [self alertViewWithTitle:@"警告" message:error.detail cancelBlock:nil];
            }
            
        }];
    } else {
        [QHUserManager registerWithPhoneNumber:self.usernameTextField.text password:self.passwordTextField.text block:^(BOOL boolean, NSError *error) {
            if (boolean) {
                [self alertViewWithTitle:@"提示" message:@"已发送验证码" cancelBlock:nil];
                self.verifyCodeButton.enabled = NO;
                self.verifyCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timingVerifyCode) userInfo:nil repeats:YES];
            } else {
                [self alertViewWithTitle:@"警告" message:error.detail cancelBlock:nil];
            }
        }];
    }
}


- (IBAction)didClickVerifyPhoneButton:(id)sender {
    [QHUserManager verifyPhoneNumberWithsmsCode:self.verifyCodeTextField.text block:^(BOOL boolean, NSError *error) {
        if (boolean) {
            [self alertViewWithTitle:@"提示" message:@"注册成功" cancelBlock:^{
                QHHomeTabBarController *homeTBC = [[QHHomeTabBarController alloc] init];
                [AppDelegate getAppDelegate].window.rootViewController = homeTBC;
            }];
        } else {
            [self alertViewWithTitle:@"警告" message:error.detail cancelBlock:nil];
        }
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
