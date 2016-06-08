//
//  QHBaseTableViewController.m
//  QHProject
//
//  Created by Chie Li on 16/5/14.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHBaseTableViewController.h"
#import "QHTableView.h"

@interface QHBaseTableViewController ()


@end

@implementation QHBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)initialViews {
    [super initialViews];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - property getter
- (QHTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[QHTableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
