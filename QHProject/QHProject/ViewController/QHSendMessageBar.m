//
//  QHSendMessageBar.m
//  QHProject
//
//  Created by Chie Li on 16/5/26.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHSendMessageBar.h"

@interface QHSendMessageBar () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation QHSendMessageBar


+ (instancetype)loadNib
{
    QHSendMessageBar *sendMessageBar = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
    return sendMessageBar;
}

- (void)awakeFromNib
{
    
}


#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(qhSendMessageBarDidBeginEditingTextFiled:)]) {
        [self.delegate qhSendMessageBarDidBeginEditingTextFiled:textField];
    }
}
#pragma mark - event response
- (IBAction)didClickSendButton:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(qhSendMessageBarDidClickSendButtonWithText:)]) {
        [self.delegate qhSendMessageBarDidClickSendButtonWithText:self.inputTextField.text];
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
