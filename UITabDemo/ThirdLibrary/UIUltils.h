//
//  UIUltils.h
//  UITabDemo
//
//  Created by hejiangshan on 16/9/6.
//  Copyright © 2016年 飞兽科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIUltils : NSObject

/**
 *  将十六进制的颜色值转化为颜色Color
 *
 *  @param HEX 十六进制颜色字符串
 *
 *  @return 转化后的颜色
 */
+ (UIColor *)transferHEXToRGB:(NSString *)HEX;

/**
 *  计算文本的size大小
 *
 *  @param des  待计算的文本字符串
 *  @param font 文本的字体大小
 *  @param size 限制的文本size
 *
 *  @return 计算得到的文本size
 */
+ (CGSize)getSizeWithLabel:(NSString *)des withFont:(UIFont *)font withSize:(CGSize)size;

@end
