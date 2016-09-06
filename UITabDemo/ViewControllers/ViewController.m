//
//  ViewController.m
//  UITabDemo
//
//  Created by hejiangshan on 16/9/5.
//  Copyright © 2016年 飞兽科技. All rights reserved.
//

#import "ViewController.h"
#import "PageTitleViewController.h"
#import "CustomTabViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)pageMethodAction:(UIButton *)sender {
    PageTitleViewController *pageTitle = [[PageTitleViewController alloc] init];
    [self.navigationController pushViewController:pageTitle animated:YES];
}

- (IBAction)customLazyMethodAction:(UIButton *)sender {
    CustomTabViewController *customTab = [[CustomTabViewController alloc] init];
    [self.navigationController pushViewController:customTab animated:YES];
    
}
@end
