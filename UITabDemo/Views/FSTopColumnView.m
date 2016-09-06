//
//  FSTopColumnView.m
//  FlyShow3.0
//
//  Created by hejiangshan on 15/10/10.
//  Copyright (c) 2015年 飞兽科技. All rights reserved.
//
#define ITEMWIDTH 70
#define SPACE 30
#import "UIView+Additions.h"
#import "FSTopColumnView.h"


@implementation FSTopColumnView

- (id)initWithFrame:(CGRect)frame withData:(NSMutableArray *)columnData 
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.columnViews = [NSMutableArray arrayWithCapacity:columnData.count];
        [self _initScrollView];
        [self _initBottomSeperatorView];
        self.columnData = columnData;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.columnViews = [NSMutableArray array];
    [self _initScrollView];
    [self _initBottomSeperatorView];
}

- (void)setColumnData:(NSMutableArray *)columnData
{
    _columnData = columnData;
    if (_columnData.count > 0 && _columnViews.count == 0) {
        [self _initSubLabelButton];
        [self _initSliderView];
    }
    [self setNeedsLayout];
}

- (void)_initScrollView
{
    if (self.scrollView == nil) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        self.scrollView.showsHorizontalScrollIndicator = false;
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.showsVerticalScrollIndicator = false;
        [self addSubview:self.scrollView];        
    }
}

- (void)_initBottomSeperatorView
{
    self.bottomseparoterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.bottomseparoterView.backgroundColor = [UIColor blueColor];
    [self addSubview:self.bottomseparoterView];
}

- (void)_initSliderView
{
    if (self.sliderView == nil) {
        self.sliderView = [[UIView alloc] initWithFrame:CGRectZero];
        self.sliderView.backgroundColor = [UIUltils transferHEXToRGB:@"12aaeb"];
        [self.scrollView addSubview:self.sliderView];
    }
}

//创建子分栏按钮
- (void)_initSubLabelButton
{
    for (int i = 0; i < self.columnData.count; i++) {
        NSString *lblTitle = self.columnData[i];
        UIButton *lbl1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [lbl1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [lbl1 setTitle:lblTitle forState:UIControlStateNormal];
        [lbl1 setTitleColor:[UIUltils transferHEXToRGB:@"282828"] forState:UIControlStateNormal];
        lbl1.titleLabel.font = [UIFont fontWithName:@"HYQiHei" size:15];
        [self.scrollView addSubview:lbl1];
        lbl1.backgroundColor = [UIColor clearColor];
        lbl1.tag = i;
        [self.columnViews addObject:lbl1];
        if (i == 0) {
            [lbl1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.lastButton = lbl1;
        }
    }
}

- (void)buttonAction:(UIButton *)button
{
    NSInteger index = [self.columnViews indexOfObject:button];
    [self updatePageByIndex:index];
    [self updatetitlePosition:index*kScreenWidth];
    if ([self.delegate respondsToSelector:@selector(topColumnViewDidSelectItem:index:)]) {
        [self.delegate topColumnViewDidSelectItem:self index:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = CGRectMake(0, 0, self.width, self.height);
    self.bottomseparoterView.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5);
    UIButton *lastBtn = nil;
    for (UIButton *lbn in self.columnViews) {
        NSInteger i = [self.columnViews indexOfObject:lbn];
        NSString *lblTitle = self.columnData[i];
        CGFloat lblW = [UIUltils getSizeWithLabel:lblTitle withFont:[UIFont systemFontOfSize:15] withSize:CGSizeMake(MAXFLOAT, 100)].width+12;
        CGFloat lblH = 45;
        
        lbn.frame = CGRectMake(lastBtn.right + SPACE, self.height - lblH, lblW, lblH);
        lastBtn = lbn;
    }
    if (!self.isReload && self.columnViews.count > 0) {
        if ([self.delegate respondsToSelector:@selector(topColumnViewreload:)]) {
            [self.delegate topColumnViewreload:self];
        }
        self.isReload = !self.isReload;
    }
    UIButton *lbl = [self.columnViews firstObject];
    self.sliderView.frame = CGRectMake(lbl.left, self.height - 2.5, lbl.width, 2);
    UIButton *lastObjectButton = [self.columnViews lastObject];
    
    self.scrollView.contentSize = CGSizeMake(lastObjectButton.right + 30, 0);
    self.sliderOriginalValue = self.sliderView.left;
}

- (void)updatePageByIndex:(NSInteger)index
{
    // 滚动标题栏
    UIButton *btn = self.columnViews[index];
    
    CGFloat offsetx = btn.center.x - self.scrollView.frame.size.width * 0.5;
    
    CGFloat offsetMax = self.scrollView.contentSize.width - self.scrollView.width;
    
    if (offsetx < 0) {
        offsetx = 0;
    } else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, self.scrollView.contentOffset.y);
    
    if (self.scrollView.contentSize.width > self.width) {
        [self.scrollView setContentOffset:offset animated:YES];
    }
  
    [UIView animateWithDuration:0.3 animations:^{
        self.sliderView.left = btn.left;
    } completion:NULL];
}

- (void)updatetitlePosition:(CGFloat)positionX
{
    // 获得索引
    NSUInteger index = positionX / kScreenWidth;
    UIButton *topColumnLeftButton = [self.columnViews objectAtIndex:index];
    float topContentOffset = (topColumnLeftButton.width + 30)*positionX/kScreenWidth;
    
    self.sliderView.left = self.sliderOriginalValue + topContentOffset;
}



@end
