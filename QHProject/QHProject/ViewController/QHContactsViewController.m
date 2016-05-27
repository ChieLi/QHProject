//
//  QHContactsViewController.m
//  QHProject
//
//  Created by Chie Li on 16/5/25.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHContactsViewController.h"
#import "QHChatViewController.h"
#import "AppDelegate.h"
#import "QHHomeTabBarController.h"

@interface QHContactsViewController ()

@property (nonatomic, strong) NSMutableArray *firstLetterArray;
@property (nonatomic, strong) NSMutableArray *contactsArray;

@end

@implementation QHContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchData];
}

- (void)initialViews
{
    [super initialViews];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
- (void)fetchData
{
    [self fetchContacts];
}

- (void)fetchContacts
{
    WS(weakSelf)
    AVQuery *contactsQuery = [AVUser query];
    [contactsQuery addAscendingOrder:@"username"];
    [contactsQuery whereKey:@"objectId" notEqualTo:[QHUserManager currentUser].objectId];
    [contactsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSMutableDictionary *tempDic = [QHUserManager sortedContactsWithAVUserArray:objects];
            weakSelf.firstLetterArray = tempDic.allKeys.mutableCopy;
            for (NSString *firstLetter in weakSelf.firstLetterArray) {
                [weakSelf.contactsArray addObject:tempDic[firstLetter]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }
    }];
    
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.firstLetterArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contactsArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    QHUserModel *user = self.contactsArray[indexPath.section][indexPath.row];
    cell.textLabel.text = user.username;
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    QHUserModel *contact = self.contactsArray[indexPath.section][indexPath.row];
    NSArray *userIds = @[[QHUserManager currentUser].objectId, contact.objectId];
#warning -这里要测试检查是否造成循环引用
    [[QHConversationManager sharedInstance] findConversationWithUserIds:userIds type:(QHConversationTypeSingle) callBackBlock:^(AVIMConversation *conversation, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            
            [self alertViewWithTitle:@"警告" message:error.detail cancelBlock:nil];
            
            return ;
        }
        
        QHChatViewController *chatVC = [[QHChatViewController alloc] initWithConversation:conversation];
        [self presentViewController:chatVC animated:YES completion:^{
            QHHomeTabBarController *tabBarController =(QHHomeTabBarController *)[AppDelegate getAppDelegate].window.rootViewController;
            tabBarController.selectedIndex = 0;
        }];
        
    }];
}
#pragma mark - property getter
- (NSMutableArray *)firstLetterArray
{
    if (!_firstLetterArray) {
        _firstLetterArray = [NSMutableArray  array];
    }
    return _firstLetterArray;
}

- (NSMutableArray *)contactsArray
{
    if (!_contactsArray) {
        _contactsArray = [NSMutableArray array];
    }
    return _contactsArray;
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
