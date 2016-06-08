//
//  WPButton.m
//  CustomButton
//
//  Created by Chie Li on 16/6/6.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "WPButton.h"

@implementation WPButton

- (instancetype)init
{
    if (self = [super init]) {
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self config];
    }
    return self;
}
- (void)config
{
    [self addTarget:self action:@selector(touchDown:) forControlEvents:(UIControlEventTouchDown)];
    [self addTarget:self action:@selector(touchUp:) forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchUpOutside)];
}

- (void)touchDown:(UIButton *)sender
{
    UIImage *image = [self imageForState:(UIControlStateSelected)];
    
    [UIView transitionWithView:self duration:0.5 options:(UIViewAnimationOptionTransitionCrossDissolve) animations:^{
        self.imageView.image = image;
    } completion:^(BOOL finished) {
        
    }];
    
    
//    [UIView animateWithDuration:0.5 animations:^{
//        sender.alpha = 0.5;
////        [sender setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, -20)];
//        sender.titleLabel.transform = CGAffineTransformTranslate(sender.titleLabel.transform, -20, 0);
//    }];
}

- (void)touchUp:(UIButton *)sender
{
    UIImage *image = [self imageForState:(UIControlStateNormal)];
    
    [UIView transitionWithView:self duration:0.5 options:(UIViewAnimationOptionTransitionCrossDissolve) animations:^{
        self.imageView.image = image;
    } completion:^(BOOL finished) {
        
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
