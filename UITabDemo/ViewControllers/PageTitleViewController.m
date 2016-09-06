//
//  PageTtileViewController.m
//  UITabDemo
//
//  Created by hejiangshan on 16/9/6.
//  Copyright © 2016年 飞兽科技. All rights reserved.
//

#import "PageTitleViewController.h"
#import "ChildViewController.h"

@interface PageTitleViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)UIPageViewController *pageVC;
@property(nonatomic,strong)NSMutableArray *contentVCS;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,assign)NSInteger currentIndex;

@end

@implementation PageTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addContentVCS];
    [self _initPageViewVC];
}

- (void)addContentVCS
{
    self.contentVCS = [NSMutableArray arrayWithCapacity:self.topTabArray.count];
    for (int i = 0; i < self.topTabArray.count; i++) {
        ChildViewController *childVC = [[ChildViewController alloc] init];
        childVC.index = i + 1;
        [self.contentVCS addObject:childVC];
    }
}

- (void)_initPageViewVC
{
    self.pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageVC.delegate = self;
    self.pageVC.dataSource = self;
    for (UIView *subView in self.pageVC.view.subviews) {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)subView setDelegate:self];
            break;
        }
    }
    [self addChildViewController:self.pageVC];
    
    if (!_contentView) {
        _contentView = self.pageVC.view;
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _contentView.bounds = self.view.bounds;
        [self.view insertSubview:_contentView atIndex:0];
    }
    
    ChildViewController *childVC = [self.contentVCS objectAtIndex:0];
    
    if (childVC == nil) {
        childVC = [[ChildViewController alloc] init];
        childVC.view = [[UIView alloc] init];
    }
    
    [self.pageVC setViewControllers:@[childVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
        
    }];
}

- (ChildViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (index >= [self.topTabArray count]) {
        return nil;
    }
    ChildViewController *dataViewController =[self.contentVCS objectAtIndex:index];
    return dataViewController;
}

- (NSUInteger)indexForViewController:(UIViewController *)viewController {
    
    return [self.contentVCS indexOfObject:viewController];
}


#pragma mark UIPageViewController delegate
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return self.contentVCS.count;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexForViewController:(ChildViewController *)viewController];
    if ((index == self.topTabArray.count-1) || (index == NSNotFound)) {
        return nil;
    }
    self.currentIndex = index;
    index++;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexForViewController:(ChildViewController *)viewController];
    if (index == NSNotFound || index == 0) {
        return nil;
    }
    self.currentIndex = index;
    index--;
    if (index == [self.topTabArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}


- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    if (completed) {
        self.currentIndex = [self.contentVCS indexOfObject:[pageViewController.viewControllers lastObject]];
    }
}

#pragma mark FSTopColumn delegate
- (void)topColumnViewDidSelectItem:(FSTopColumnView *)columnView index:(NSInteger)index
{
    UIPageViewControllerNavigationDirection direction;
    
    if (self.currentIndex == index) {
        return;
    }
    
    if (index > self.currentIndex) {
        direction = UIPageViewControllerNavigationDirectionForward;
    } else {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    
    UIViewController *viewController = [self viewControllerAtIndex:index];
    
    if (viewController) {
        __weak typeof(self) weakself = self;
        [self.pageVC setViewControllers:@[viewController] direction:direction animated:YES completion:^(BOOL finished) {
            weakself.currentIndex = index;
        }];
    }
}

#pragma mark UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetX = kScreenWidth * self.currentIndex - kScreenWidth + scrollView.contentOffset.x;
    [self.topColumnView updatetitlePosition:contentOffsetX];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.topColumnView updatePageByIndex:self.currentIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
