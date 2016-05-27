//
//  QHChatViewController.m
//  QHProject
//
//  Created by Chie Li on 16/5/25.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHChatViewController.h"
#import "QHSendMessageBar.h"

@interface QHChatViewController ()<QHSendMessageBarDelegate>

@property (nonatomic, strong) QHSendMessageBar *sendMessageBar;

@property (nonatomic, strong) AVIMConversation *conversation;

@end

@implementation QHChatViewController

- (instancetype)initWithConversation:(AVIMConversation *)conversation
{
    if (self = [super init]) {
        self.conversation = conversation;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initialViews
{
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    [self.tableView addSubview:self.sendMessageBar];
    [self.sendMessageBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.tableView);
        make.height.mas_equalTo(44);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - property getter
- (QHSendMessageBar *)sendMessageBar
{
    if (!_sendMessageBar) {
        _sendMessageBar = [QHSendMessageBar loadNib];
        _sendMessageBar.delegate = self;
    }
    return _sendMessageBar;
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
