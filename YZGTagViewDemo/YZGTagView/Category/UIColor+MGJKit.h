//
//  UIColor+MGJKit.h
//  MGJFoundation
//
//  Created by limboy on 12/3/14.
//  Copyright (c) 2014 juangua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MGJKit)

/**
 *  根据十六进制字符串生成 UIColor
 *
 *  @param hexString  十六进制颜色值
 *  @param alpha  透明度
 *  @return UIColor
 */
+ (UIColor *)mgj_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)mgj_colorWithHex:(int)hex alpha:(CGFloat)alpha;

+ (UIColor *)mgj_colorWithHexString:(NSString *)hexString;

+ (UIColor *)mgj_colorWithHex:(int)hex;

/**
 *  返回一种随机色
 */
+ (UIColor *)mgj_random;

@end
