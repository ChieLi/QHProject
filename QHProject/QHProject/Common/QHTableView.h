//
//  QHTableView.h
//  QHProject
//
//  Created by Chie Li on 16/5/25.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QHTableViewDelegate <NSObject>

- (void)qhTableViewHeaderViewRefreshBegin:(UITableView *)tableView;
- (void)qhTableViewFooterViewRefreshBegin:(UITableView *)tableView;

@end

@interface QHTableView : UITableView

@property (nonatomic, weak) id<QHTableViewDelegate> qhDelegate;

@end
