//
//  QHRegisterViewController.m
//  QHProject
//
//  Created by Chie Li on 16/5/12.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHRegisterViewController.h"
#import "AppDelegate.h"
#import "QHRootTabBarController.h"
@interface QHRegisterViewController ()

@property (weak, nonatomic) IBOutlet UILabel *emailTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *verifyCodeTitleLabel;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *verifyCodeButton;

@property (nonatomic, assign) QHRegisterViewControllerType type;

@end

@implementation QHRegisterViewController

#pragma mark - init

- (instancetype)initWithType:(QHRegisterViewControllerType)type
{
    if (self = [super init]) {
        self.type = type;
    }
    
    return self;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
        [QHAlertViewManager alertViewWithTitle:@"提示" message:@"请输入正确手机号" onViewController:self];
    } else {
        [QHUserManager requestPhoneNumberVerify:self.usernameTextField.text block:^(BOOL boolean, NSError *error) {
            if (boolean) {
                [QHAlertViewManager alertViewWithTitle:@"提示" message:@"验证码已发送" onViewController:self];
            } else {
#warning 显示错误信息
                [QHAlertViewManager alertViewWithTitle:@"警告" message:@"123" onViewController:self];
            }
        }];
    }
}


- (IBAction)didClickRegisterButton:(id)sender {
    
    if (self.type == QHRegisterViewControllerTypeEmail) {
        [QHUserManager registerWithEmail:self.usernameTextField.text password:self.passwordTextField.text block:^(BOOL boolean, NSError *error) {
            
            AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
            appDelegate.window.rootViewController = [[QHRootTabBarController alloc] init];
        }];
    } else {
//        [QHUserManager requestPhoneNumberVerify:self.usernameTextField.text block:<#^(BOOL boolean, NSError *error)block#>]
        
    }
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
