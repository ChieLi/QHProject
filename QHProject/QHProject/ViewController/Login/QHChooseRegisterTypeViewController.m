//
//  QHChooseRegisterTypeViewController.m
//  QHProject
//
//  Created by Chie Li on 16/5/13.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHChooseRegisterTypeViewController.h"
#import "QHRegisterViewController.h"

@interface QHChooseRegisterTypeViewController ()


@end

@implementation QHChooseRegisterTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didClickEmailRegisterButton:(id)sender {
    
    QHRegisterViewController *registerVC = [[QHRegisterViewController alloc] initWithType:(QHRegisterViewControllerTypeEmail)];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)didClickPhoneNumberRegisterButton:(id)sender {
    
    QHRegisterViewController *registerVC = [[QHRegisterViewController alloc] initWithType:(QHRegisterViewControllerTypePhoneNumber)];
    [self.navigationController pushViewController:registerVC animated:YES];
    
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
