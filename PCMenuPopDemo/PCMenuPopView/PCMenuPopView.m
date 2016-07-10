//
//  PCMenuPopView.m
//  PCMenuPopDemo
//
//  Created by peichuang on 16/6/30.
//  Copyright © 2016年 peichuang. All rights reserved.
//

#import "PCMenuPopView.h"
#import "UIView+MaterialDesign.h"

@interface PCMenuPopView ()

@property (nonatomic, strong) NSMutableArray *menuItemArray;

@end

@implementation PCMenuPopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    self.menuItemArray = [NSMutableArray array];
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.closeButton];
}

- (void)showInView:(UIView *)view withPopButton:(UIButton *)popButton
{
    [view addSubview:self];
    CGRect buttonFrame = [view convertRect:popButton.frame toView:view];
    self.closeButton.frame = buttonFrame;
    
    [self.closeButton setImage:[popButton imageForState:UIControlStateNormal] forState:UIControlStateNormal];
    
    NSInteger count = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfitemsInMenuPopView:)]) {
        count = [self.delegate numberOfitemsInMenuPopView:self];
    }
    [self clearCustomMenuItems];
    for (int i = 0; i<count; i++) {
        UIButton *button = [self createButton];
        if ([self.delegate respondsToSelector:@selector(menuPopView:rectForMenuItemWithIndex:)]) {
            button.frame = [self.delegate menuPopView:self rectForMenuItemWithIndex:i];
        }
        if ([self.delegate respondsToSelector:@selector(menuPopView:configureWithMenuItem:index:)]) {
            [self.delegate menuPopView:self configureWithMenuItem:button index:i];
        }
        [self addSubview:button];
        [self.menuItemArray addObject:button];
        
        button.transform = CGAffineTransformMakeScale(0, 0);
    }
    [self bringSubviewToFront:self.closeButton];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.closeButton.transform = CGAffineTransformMakeRotation(M_PI_4);
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateKeyframesWithDuration:0.6 delay:0.1 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        for (int i = 0; i < self.menuItemArray.count; i++) {
            UIButton *button = [self.menuItemArray objectAtIndex:i];
            [UIView addKeyframeWithRelativeStartTime:i*0.1 relativeDuration:0.3 animations:^{
                button.transform = CGAffineTransformIdentity;
            }];
        }
    } completion:^(BOOL finished) {
        
    }];
    self.backgroundColor = [UIColor clearColor];
    [self mdInflateAnimatedFromPoint:CGPointMake(CGRectGetMidX(self.closeButton.frame), CGRectGetMidY(self.closeButton.frame)) backgroundColor:[UIColor lightGrayColor] duration:0.6 completion:nil];
}

- (void)hide
{
    [UIView animateWithDuration:0.4 animations:^{
        self.closeButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    [UIView animateKeyframesWithDuration:0.6 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        for (int i = 0; i < self.menuItemArray.count; i++) {
            UIButton *button = [self.menuItemArray objectAtIndex:i];
            [UIView addKeyframeWithRelativeStartTime:i*0.1 relativeDuration:0.3 animations:^{
                button.transform = CGAffineTransformMakeScale(0, 0);
            }];
        }
    } completion:^(BOOL finished) {
        
    }];
    [self mdDeflateAnimatedToPoint:CGPointMake(CGRectGetMidX(self.closeButton.frame), CGRectGetMidY(self.closeButton.frame)) backgroundColor:[UIColor clearColor] duration:0.6 completion:nil];
}

- (void)closeAction:(UIButton *)button
{
    [self hide];
}

- (void)clearCustomMenuItems
{
    for (UIButton *button in self.menuItemArray) {
        [button removeFromSuperview];
    }
    [self.menuItemArray removeAllObjects];
}

- (UIButton *)createButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    return button;
}

- (CGRect)defaultItemRectWithSize:(CGSize)size index:(NSInteger)index
{
    CGRect rect = CGRectMake(CGRectGetMinX(self.closeButton.frame)-(index+1)*(25+size.width), CGRectGetMidY(self.closeButton.frame)-size.width/2, size.width, size.height);
    return rect;
}

#pragma mark - property

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.adjustsImageWhenHighlighted = NO;
        [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

@end
