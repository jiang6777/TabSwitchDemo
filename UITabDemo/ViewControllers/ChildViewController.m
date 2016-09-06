//
//  ChildViewController.m
//  UITabDemo
//
//  Created by hejiangshan on 16/9/6.
//  Copyright © 2016年 飞兽科技. All rights reserved.
//

#import "ChildViewController.h"

@interface ChildViewController ()

@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 200)/2, (kScreenHeight - 40)/2, 200, 40)];
    text.text = [NSString stringWithFormat:@"这是我第%ld个子控制器",(long)self.index];
    text.font = [UIFont systemFontOfSize:20.0];
    text.textColor = [UIColor blackColor];
    [self.view addSubview:text];
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
