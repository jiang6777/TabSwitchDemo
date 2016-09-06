//
//  CustomTabViewController.m
//  UITabDemo
//
//  Created by hejiangshan on 16/9/6.
//  Copyright © 2016年 飞兽科技. All rights reserved.
//

#import "CustomTabViewController.h"
#import "ChildViewController.h"

@interface CustomTabViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;

@end

@implementation CustomTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initMainScrollView];
    [self _initChildVCS];
}

- (void)_initMainScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topColumnView.bottom, kScreenWidth, kScreenHeight-self.topColumnView.height)];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    self.scrollView.pagingEnabled =YES;
    self.scrollView.contentSize = CGSizeMake(self.topTabArray.count * kScreenWidth, 0);
}

- (void)_initChildVCS
{
    for (int i = 0; i < self.topTabArray.count; i++) {
        ChildViewController *child = [[ChildViewController alloc] init];
        child.index = i + 1;
        [self addChildViewController:child];
    }
    
    //设置一个默认的子控制器
    ChildViewController *child = [self.childViewControllers firstObject];
    [self.scrollView addSubview:child.view];
    child.view.frame = self.scrollView.bounds;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //处理临界条件
    if (scrollView.contentOffset.x > 0 && scrollView.contentOffset.x < (scrollView.contentSize.width - kScreenWidth)) {
        [self.topColumnView updatetitlePosition:scrollView.contentOffset.x];
    }

}

#pragma mark UIScrollView delegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/kScreenWidth;
    [self.topColumnView updatePageByIndex:scrollView.contentOffset.x/kScreenWidth];
    
    ChildViewController *childVC = self.childViewControllers[index];
    if (childVC.view.superview) {
        return;
    }
    childVC.view.frame = scrollView.bounds;
    [self.scrollView addSubview:childVC.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
