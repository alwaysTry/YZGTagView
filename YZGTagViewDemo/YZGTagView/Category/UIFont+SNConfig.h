//
//  UIFont+SNConfig.h
//  SNOB
//
//  Created by 苏合 on 16/1/19.
//  Copyright © 2016年 juangua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (SNConfig)

+ (UIFont *)miniFont;
+ (UIFont *)smallFont;
+ (UIFont *)mediumFont;
+ (UIFont *)largeFont;
+ (UIFont *)normalFont;
+ (UIFont *)headlineFont;
+ (UIFont *)bodoniSmallcapsFontOfSize:(CGFloat)size;
+ (UIFont *)garamondFontOfSize:(CGFloat)size;
+ (UIFont *)revistaStencilFontOfSize:(CGFloat)size;

+ (UIFont *)semiboldSystemFontOfSize:(CGFloat)size;
+ (UIFont *)thinSystemFontOfSize:(CGFloat)size;
+ (UIFont *)lightSystemFontOfSize:(CGFloat)size;
+ (UIFont *)mediumSystemFontOfSize:(CGFloat)size;

@end

