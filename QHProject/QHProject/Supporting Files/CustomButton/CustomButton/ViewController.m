//
//  ViewController.m
//  CustomButton
//
//  Created by Chie Li on 16/6/6.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "ViewController.h"
#import "WPButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *image1 = [UIImage imageNamed:@"white"];
    UIImage *image2 = [UIImage imageNamed:@"red"];
    
    
    WPButton *button = [[WPButton alloc] init];
    button.frame = CGRectMake(50, 50, 100, 50);
    [button setTitle:@"按钮" forState:(UIControlStateNormal)];
    [button setBackgroundColor:[UIColor yellowColor]];
    [button setImage:image1 forState:(UIControlStateNormal)];
    [button setImage:image2 forState:(UIControlStateSelected)];
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] init];
    button2.frame = CGRectMake(50, 200, 100, 50);
    [button2 setTitle:@"按钮" forState:(UIControlStateNormal)];
    [button2 setBackgroundColor:[UIColor yellowColor]];
    [button2 setImage:image1 forState:(UIControlStateNormal)];
    [button2 setImage:image2 forState:(UIControlStateSelected)];
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonClick:(UIButton *)sender
{
    NSLog(@"123");
}
@end
