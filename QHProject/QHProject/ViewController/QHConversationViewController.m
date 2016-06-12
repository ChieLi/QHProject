//
//  QHConversationViewController.m
//  QHProject
//
//  Created by Chie Li on 16/6/3.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHConversationViewController.h"
#import "QHConversationManager.h"
#import "QHSendMessageBar.h"
#import "UIViewController+Keyboard.h"
@interface QHConversationViewController ()<QHSendMessageBarDelegate, QHConversationDelegate>


//@property (nonatomic, strong) QHConversationModel *conversation;
@property (nonatomic, strong) QHSendMessageBar *sendMessageBar;

@property (nonatomic, strong) AVIMConversation *avConversation;
@property (nonatomic, strong) NSMutableArray *messagesArray;

@end

@implementation QHConversationViewController

- (instancetype)initWithAVConvesation:(AVIMConversation *)conversation
{
    if (self = [super init]) {
        self.avConversation = conversation;
    }
    return self;
}

- (void)dealloc
{
    [self removeKeyboardNotification];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerKeyboard];
    
}

- (void)initialViews
{
    [super initialViews];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, -44, 0);
    [self.view addSubview:self.sendMessageBar];
    [self.sendMessageBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    QHMessageModel *message = self.messagesArray[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@_%@",message.text, message.time];
    
    return cell;
}

#pragma mark - SendMessageBarDelegate
- (void)qhSendMessageBarDidClickSendButtonWithText:(NSString *)text
{
    [[QHConversationManager sharedInstance] sendTextMessage:text toConversation:self.avConversation block:^(BOOL boolean, NSError *error) {
        QHMessageModel *message = [QHMessageModel textMessageWithTime:[NSDate date] conversationId:self.avConversation.conversationId fromId:[QHUserManager currentUser].objectId text:text];
        [self.messagesArray addObject:message];
        [self.tableView reloadData];
    }];
}

#pragma mark - QHConversationDelegate
- (void)qhNewMessageReceived:(QHMessageModel *)message
{
    if ([message.conversationId isEqualToString:self.avConversation.conversationId]) {
        [self.messagesArray addObject:message];
        [self.tableView reloadData];
    }
}
#pragma mark - private method
- (void)registerKeyboard
{
    WS(weakSelf)
    [self registerKeyboardNotificationWithShowBlock:^(NSTimeInterval animationDuration, CGFloat keyboardHeight) {
        
        [weakSelf.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.width.centerX.equalTo(self.view);
            make.centerY.mas_equalTo(self.view).offset(-keyboardHeight);
        }];
        [weakSelf.sendMessageBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view).offset(-keyboardHeight);
        }];
        
        [UIView animateWithDuration:animationDuration animations:^{
            [weakSelf.view layoutIfNeeded];
        }];
        
    } hideBlock:^(NSTimeInterval animationDuration, CGFloat keyboardHeight) {
        
        [weakSelf.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view);
        }];
        [weakSelf.sendMessageBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view);
        }];
        
        [UIView animateWithDuration:animationDuration animations:^{
            [weakSelf.view layoutIfNeeded];
        }];
    }];
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

- (NSMutableArray *)messagesArray
{
    if (!_messagesArray) {
        _messagesArray = [NSMutableArray array];
    }
    return _messagesArray;
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
