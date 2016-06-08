//
//  QHContactsViewController.m
//  QHProject
//
//  Created by Chie Li on 16/5/25.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHContactsViewController.h"
#import "AppDelegate.h"
#import "QHHomeTabBarController.h"
#import "QHBaseNavigationController.h"
#import "QHLoginViewController.h"
#import "QHConversationViewController.h"


@interface QHContactsViewController ()

@property (nonatomic, strong) NSMutableArray *firstLetterArray;
@property (nonatomic, strong) NSMutableArray *contactsArray;

@end

@implementation QHContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchData];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登出" style:(UIBarButtonItemStyleDone) target:self action:@selector(didClickLogout:)];
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
//    [contactsQuery whereKey:@"objectId" notEqualTo:[QHUserManager currentUser].objectId];
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
    NSArray *membersIds = @[[QHUserManager currentUser].objectId, contact.objectId];
#warning -这里要测试检查是否造成循环引用
    
//    [[QHConversationManager sharedInstance] findConversationWithMembersIds:membersIds type:(QHConversationTypeSingle) block:^(QHConversationModel *conversation, NSError *error) {
//        if (conversation.objectId) {
//            QHConversationViewController *conversationVC = [[QHConversationViewController alloc] initWithConversation:conversation];
//            [self presentViewController:conversationVC animated:YES completion:^{
//                QHHomeTabBarController *tabBarController =(QHHomeTabBarController *)[AppDelegate getAppDelegate].window.rootViewController;
//                tabBarController.selectedIndex = 0;
//            }];
//        }
//    }];
//    
    [[QHConversationManager sharedInstance] findConversationWithUserIds:membersIds type:(QHConversationTypeSingle) callBackBlock:^(AVIMConversation *conversation, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            
            [self alertViewWithTitle:@"警告" message:error.detail cancelBlock:nil];
            
            return ;
        }
        QHConversationViewController *conversationVC = [[QHConversationViewController alloc] initWithAVConvesation:conversation];
        
        [self presentViewController:conversationVC animated:YES completion:^{
            QHHomeTabBarController *tabBarController =(QHHomeTabBarController *)[AppDelegate getAppDelegate].window.rootViewController;
            tabBarController.selectedIndex = 0;
        }];
        
    }];
}

#pragma mark - response event
- (void)didClickLogout:(id)sender
{
    [QHUserManager logout];
    QHLoginViewController *loginVC = [[QHLoginViewController alloc] init];
    QHBaseNavigationController *loginNC = [[QHBaseNavigationController alloc] initWithRootViewController:loginVC];
    [UIView transitionFromView:self.view toView:loginNC.view duration:0.5 options:(UIViewAnimationOptionTransitionCrossDissolve) completion:^(BOOL finished) {
        [AppDelegate getAppDelegate].window.rootViewController = loginNC;
        [[AppDelegate getAppDelegate].window addSubview:loginNC.view];
        [self.view removeAllSubViews];
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
