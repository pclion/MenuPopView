//
//  ViewController.m
//  PCMenuPopDemo
//
//  Created by peichuang on 16/6/29.
//  Copyright © 2016年 peichuang. All rights reserved.
//

#import "ViewController.h"
#import "PCMenuPopView.h"

@interface ViewController ()<PCMenuPopViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) PCMenuPopView *menuPopView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addAction:(id)sender {
    [self.menuPopView showInView:self.view withPopButton:sender];
}

- (PCMenuPopView *)menuPopView
{
    if (!_menuPopView) {
        _menuPopView = [[PCMenuPopView alloc] initWithFrame:self.view.bounds];
        _menuPopView.delegate = self;
    }
    return _menuPopView;
}

- (void)menuAction:(UIButton *)button
{
    
}

#pragma mark - PCMenuPopViewDelegate

- (NSInteger)numberOfitemsInMenuPopView:(PCMenuPopView *)menuPopView
{
    return 3;
}

- (void)menuPopView:(PCMenuPopView *)menuPopView configureWithMenuItem:(UIButton *)menuButton index:(NSInteger)index
{
    menuButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [menuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    menuButton.layer.masksToBounds = YES;
    menuButton.layer.cornerRadius = CGRectGetWidth(menuButton.frame)/2;
    menuButton.tag = 100+index;
    if (index == 0) {
        [menuButton setTitle:@"囧图" forState:UIControlStateNormal];
//        [menuButton setBackgroundImage:[UIImage image] forState:UIControlStateNormal];//可以设置带颜色的图片
        [menuButton setBackgroundColor:[UIColor redColor]];
    } else if (index == 1) {
        [menuButton setTitle:@"投稿" forState:UIControlStateNormal];
        [menuButton setBackgroundColor:[UIColor grayColor]];
    } else if (index == 2) {
        [menuButton setTitle:@"测试" forState:UIControlStateNormal];
        [menuButton setBackgroundColor:[UIColor brownColor]];
    }
    [menuButton addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (CGRect)menuPopView:(PCMenuPopView *)menuPopView rectForMenuItemWithIndex:(NSInteger)index
{
    return [menuPopView defaultItemRectWithSize:CGSizeMake(60, 60) index:index];
}

@end
