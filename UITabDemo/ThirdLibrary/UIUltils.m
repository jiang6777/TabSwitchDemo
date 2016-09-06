//
//  UIUltils.m
//  UITabDemo
//
//  Created by hejiangshan on 16/9/6.
//  Copyright © 2016年 飞兽科技. All rights reserved.
//

#import "UIUltils.h"

@implementation UIUltils

+ (UIColor *)transferHEXToRGB:(NSString *)HEX
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[HEX substringWithRange:range]]scanHexInt:&red];
    range.location =2;
    [[NSScanner scannerWithString:[HEX substringWithRange:range]]scanHexInt:&green];
    range.location =4;
    [[NSScanner scannerWithString:[HEX substringWithRange:range]]scanHexInt:&blue];
    UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
    return color;
}


+ (CGSize)getSizeWithLabel:(NSString *)des withFont:(UIFont *)font withSize:(CGSize)size
{
    if (![des isMemberOfClass:[NSNull class]]) {
        // iOS6使用的方法
        UIDevice *device = [UIDevice currentDevice];
        if ([device.systemVersion floatValue] <= 6.0) {
            CGSize textSize = [des sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];//MAXFLOAT
            return textSize;
        } else {
            NSDictionary *attribute = @{NSFontAttributeName: font};
            CGSize finalSize = CGSizeMake(size.width, MAXFLOAT);
            //iOS7中提供的计算文本尺寸的方法
            CGSize textSize1 = [des boundingRectWithSize:finalSize options:NSStringDrawingUsesLineFragmentOrigin |
                                NSStringDrawingTruncatesLastVisibleLine  attributes:attribute context:nil].size;
            return textSize1;
        }
        return size;
    }
    return CGSizeZero;
}

@end
