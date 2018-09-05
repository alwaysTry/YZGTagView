//
//  UIFont+SNConfig.m
//  SNOB
//
//  Created by 苏合 on 16/1/19.
//  Copyright © 2016年 juangua. All rights reserved.
//

#import "UIFont+SNConfig.h"

#define IOS9Later ([[[UIDevice currentDevice] systemVersion]floatValue] >= 9.f)

@implementation UIFont (SNConfig)

//+ (void)load
//{
//    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
//    NSArray *fontNames;
//    NSInteger indFamily, indFont;
//    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
//    {
//        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
//        fontNames = [[NSArray alloc] initWithArray:
//                     [UIFont fontNamesForFamilyName:
//                      [familyNames objectAtIndex:indFamily]]];
//        for (indFont=0; indFont<[fontNames count]; ++indFont)
//        {
//            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
//        }
//    }
//}



+ (UIFont *)miniFont
{
    return [UIFont lightSystemFontOfSize:10.f];
}

+ (UIFont *)smallFont
{
    return [UIFont lightSystemFontOfSize:12.f];
}

+ (UIFont *)mediumFont
{
    return [UIFont lightSystemFontOfSize:14.f];
}

+ (UIFont *)largeFont
{
    return [UIFont lightSystemFontOfSize:16.f];
}

+ (UIFont *)normalFont
{
    return [UIFont lightSystemFontOfSize:15.f];
}

- (UIFont *)bold
{
    return [UIFont boldSystemFontOfSize:self.pointSize];
}

+ (UIFont *)headlineFont
{
    return [UIFont systemFontOfSize:22.f];
}

+ (UIFont *)bodoniSmallcapsFontOfSize:(CGFloat)size
{
     return [UIFont fontWithName:@"BodoniSvtyTwoSCITCTT-Book" size:size];
}

+ (UIFont *)garamondFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Garamond-Normal" size:size];
}

+ (UIFont *)revistaStencilFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Revista Stencil" size:size];
}

+ (UIFont *)thinSystemFontOfSize:(CGFloat)size
{
    if (IOS9Later)
    {
        return [UIFont fontWithName:@"PingFangSC-Thin" size:size];
    }
    else
    {
        return [UIFont systemFontOfSize:size];
    }
}

+ (UIFont *)semiboldSystemFontOfSize:(CGFloat)size
{
    if (IOS9Later)
    {
        return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
    }
    else
    {
        return [UIFont systemFontOfSize:size];
    }
}

+ (UIFont *)mediumSystemFontOfSize:(CGFloat)size
{
    if (IOS9Later)
    {
        return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
    }
    else
    {
        return [UIFont fontWithName:@"STHeitiTC-Medium" size:size];
    }
}

+ (UIFont *)lightSystemFontOfSize:(CGFloat)size
{
    if (IOS9Later)
    {
        return [UIFont fontWithName:@"PingFangSC-Light" size:size];
    }
    else
    {
        return [UIFont fontWithName:@"STHeitiTC-Light" size:size];
    }
}


@end
