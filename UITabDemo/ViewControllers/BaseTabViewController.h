//
//  BaseTabViewController.h
//  UITabDemo
//
//  Created by hejiangshan on 16/9/6.
//  Copyright © 2016年 飞兽科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTopColumnView.h"
#import "UIView+Additions.h"

@interface BaseTabViewController : UIViewController

@property(nonatomic,strong)FSTopColumnView *topColumnView;

@property(nonatomic,strong)NSMutableArray *topTabArray;

@end
