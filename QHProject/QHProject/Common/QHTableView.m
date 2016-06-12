//
//  QHTableView.m
//  QHProject
//
//  Created by Chie Li on 16/5/25.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHTableView.h"
#import "MJRefresh.h"

@implementation QHTableView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self config];
}

- (instancetype)init
{
    if (self = [super init]) {
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self config];
    }
    return self;
}

- (void)config
{
    self.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewHeaderRefreshBegin:)];
    self.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(tableViewFooterRefreshBegin:)];
}

#pragma mark - event response
- (void)tableViewHeaderRefreshBegin:(MJRefreshHeader *)headerView
{
    if ([self.delegate respondsToSelector:@selector(qhTableViewHeaderViewRefreshBegin:)]) {
        [self.qhDelegate qhTableViewHeaderViewRefreshBegin:self];
    }
}

- (void)tableViewFooterRefreshBegin:(MJRefreshFooter *)footerView
{
    if ([self.delegate respondsToSelector:@selector(qhTableViewFooterViewRefreshBegin:)]) {
        [self.qhDelegate qhTableViewFooterViewRefreshBegin:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
