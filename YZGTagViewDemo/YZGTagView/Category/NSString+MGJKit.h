//
//  NSString+MGJKit.h
//  MGJAnalytics
//
//  Created by limboy on 12/2/14.
//  Copyright (c) 2014 mogujie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (MGJKit)

- (NSString *)mgj_md5HashString;

- (NSString *)mgj_base64encode;

- (NSString *)mgj_urlencode;

- (NSString *)mgj_urldecode;

+ (NSString *)mgj_UUID;

/**
 *  Library/Caches
 */
+ (NSString *)mgj_cachesPath;

/**
 *  Library/Documents
 */
+ (NSString *)mgj_documentsPath;

/**
 *  获取临时目录，模拟器状态下会返回 /tmp
 */
+ (NSString *)mgj_temporaryPath;

/**
 *  根据 UUID 创建一个临时文件路径，每次调用都会返回不同的结果
 */
+ (NSString *)mgj_pathForTemporaryFile;

/**
 *  把 char 字符转换为 OC 的字符串，比如 int value = 'test', 调用此方法后可以得到 @"test"
 *
 *  @param charInt 一个 char, 比如 'foo'
 */
+ (NSString *)mgj_convertToStringWithChar:(NSInteger)charInt;

/**
 *  根据 BaseURL 和一些参数组合成一个完整的 URL
 *
 *  @param baseURL
 *  @param parameters
 *
 *  @return
 */
+ (NSString *)mgj_combineURLWithBaseURL:(NSString *)baseURL parameters:(NSDictionary *)parameters;

/**
 *  计算字符串绘制需要的大小，用来替代系统的 sizeWithFont:
 *
 *  @param font 字体大小
 *
 *  @return 字符串绘制需要的大小
 */
#if TARGET_OS_IOS
- (CGSize)mgj_sizeWithFont:(UIFont *)font;

/**
 *  计算字符串绘制需要的大小，用来替代系统的 sizeWithFont:constrainedToSize:
 *
 *  @param font 字体大小
 *  @param size 绘制字符串允许的最大 size
 *
 *  @return 字符串绘制需要的大小
 */
- (CGSize)mgj_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

- (CGSize)mgj_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
#endif

- (NSString *)mgj_trim;
@end
