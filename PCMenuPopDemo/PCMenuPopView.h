//
//  PCMenuPopView.h
//  PCMenuPopDemo
//
//  Created by peichuang on 16/6/30.
//  Copyright © 2016年 peichuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PCMenuPopView;

@protocol PCMenuPopViewDelegate <NSObject>

//返回需要多少个菜单项
- (NSInteger)numberOfitemsInMenuPopView:(PCMenuPopView *)menuPopView;
//配置对应菜单button
- (void)menuPopView:(PCMenuPopView *)menuPopView configureWithMenuItem:(UIButton *)menuButton index:(NSInteger)index;
//配置对应的button的位置
- (CGRect)menuPopView:(PCMenuPopView *)menuPopView rectForMenuItemWithIndex:(NSInteger)index;

@end

@interface PCMenuPopView : UIView

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, weak) id<PCMenuPopViewDelegate>delegate;

- (void)showInView:(UIView *)view withPopButton:(UIButton *)popButton;

- (void)hide;
//根据index可以设置默认位置，从右到左的顺序
- (CGRect)defaultItemRectWithSize:(CGSize)size index:(NSInteger)index;

@end
