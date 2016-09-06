//
//  BaseTabViewController.m
//  UITabDemo
//
//  Created by hejiangshan on 16/9/6.
//  Copyright © 2016年 飞兽科技. All rights reserved.
//

#import "BaseTabViewController.h"

@interface BaseTabViewController () <FSTopColumnViewDelegate>


@end

@implementation BaseTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topTabArray = [NSMutableArray arrayWithObjects:@"热门",@"推荐",@"科技",@"财经",@"文化",@"视频",@"娱乐",@"体育", nil];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self _initTopColumnView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self _initNav];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)_initTopColumnView {
    
    _topColumnView = [[FSTopColumnView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64) withData:self.topTabArray];
    self.topColumnView.delegate = self;
    [self.view addSubview:self.topColumnView];
}

- (void)_initNav
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(20, kScreenHeight - 40, 50, 25);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark FSTopColumnView delegate
- (void)topColumnViewDidSelectItem:(FSTopColumnView *)columnView index:(NSInteger)index
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
