//
//  QHBaseTableViewController.h
//  QHProject
//
//  Created by Chie Li on 16/5/14.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHBaseViewController.h"
#import "QHTableView.h"

@interface QHBaseTableViewController : QHBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) QHTableView *tableView;

@end
