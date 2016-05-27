//
//  QHTabBarItem.m
//  QHProject
//
//  Created by Chie Li on 16/5/24.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHTabBarItem.h"

static const CGFloat kQHTabBarItemBottomEdge = 3.f;
static const CGFloat kQHTabBarItemSpaceBetweenImageAndTitle = 5.f;
static const CGFloat kQHTabBarItemTitleSize = 8.f;

@implementation QHTabBarItem

+ (instancetype)tabBarItemWithFrame:(CGRect)frame title:(NSString *)title normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage type:(QHTabBarItemType)type
{
    QHTabBarItem *item = [[QHTabBarItem alloc] initWithFrame:frame];
    [item setTitle:title forState:(UIControlStateNormal)];
    [item setImage:normalImage forState:(UIControlStateNormal)];
    [item setImage:selectedImage forState:(UIControlStateSelected)];
    item.type = type;
    
    return item;
}

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

- (void)config {
    self.backgroundColor = [UIColor whiteColor];
    [self setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.titleLabel.font = [UIFont systemFontOfSize:kQHTabBarItemTitleSize];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize imageSize = [self imageForState:(UIControlStateNormal)].size;
    if (imageSize.width != 0 && imageSize.height != 0) {
        CGFloat imageViewCenterY = CGRectGetHeight(self.frame) - kQHTabBarItemBottomEdge - titleSize.height - kQHTabBarItemSpaceBetweenImageAndTitle - imageSize.height/2.f;
        self.imageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        self.imageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, imageViewCenterY);
    } else {
        CGPoint imageViewCenter = self.imageView.center;
        imageViewCenter.x = CGRectGetWidth(self.frame) / 2;
        imageViewCenter.y = (CGRectGetHeight(self.frame) - titleSize.height) / 2;
        self.imageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        self.imageView.center = imageViewCenter;
    }
    
    CGPoint titleCenter = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) - kQHTabBarItemBottomEdge - titleSize.height / 2);
    self.titleLabel.center = titleCenter;
}

- (void)setHighlighted:(BOOL)highlighted
{
    //取消高亮title
}

@end
