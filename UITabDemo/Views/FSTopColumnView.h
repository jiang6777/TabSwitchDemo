//
//  FSTopColumnView.h
//  FlyShow3.0
//
//  Created by hejiangshan on 15/10/10.
//  Copyright (c) 2015年 飞兽科技. All rights reserved.
//
/*
 顶部分栏视图
 */
#import <UIKit/UIKit.h>
@class FSTopColumnView;

@protocol FSTopColumnViewDelegate <NSObject>

- (void)topColumnViewDidSelectItem:(FSTopColumnView *)columnView index:(NSInteger)index;

@optional
- (void)topColumnViewreload:(FSTopColumnView *)columnView;

@end

@interface FSTopColumnView : UIView

- (id)initWithFrame:(CGRect)frame withData:(NSMutableArray *)columnData;

@property(nonatomic,assign)id<FSTopColumnViewDelegate> delegate;

//栏目数组
@property(nonatomic,strong)NSMutableArray *columnData;

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UIView *sliderView;

@property(nonatomic,strong)UIButton *lastButton;

@property(nonatomic,strong)UIView *bottomseparoterView;

//保存分栏的视图
@property(nonatomic,strong)NSMutableArray *columnViews;

@property(nonatomic,assign)float sliderOriginalValue;

@property(nonatomic,assign)BOOL isReload;

- (void)updatePageByIndex:(NSInteger)index;

- (void)updatetitlePosition:(CGFloat)positionX;

- (void)layoutSubviews;

@end
