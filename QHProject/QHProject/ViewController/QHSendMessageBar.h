//
//  QHSendMessageBar.h
//  QHProject
//
//  Created by Chie Li on 16/5/26.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QHSendMessageBarDelegate <NSObject>

- (void)qhSendMessageBarDidClickSendButtonWithText:(NSString *)text;
- (void)qhSendMessageBarDidBeginEditingTextFiled:(UITextField *)textField;

@end

@interface QHSendMessageBar : UIView

@property (nonatomic, weak) id<QHSendMessageBarDelegate> delegate;

+ (instancetype)loadNib;

@end
