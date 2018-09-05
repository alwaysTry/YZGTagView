//
//  NSString+MGJKit.m
//  MGJAnalytics
//
//  Created by limboy on 12/2/14.
//  Copyright (c) 2014 mogujie. All rights reserved.
//

#import "NSString+MGJKit.h"
#import <sys/xattr.h>
#import <CommonCrypto/CommonDigest.h>

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSString (MGJKit)

- (NSString *)mgj_urldecode
{
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)mgj_urlencode
{
    static NSString * const kMGJCharactersToLeaveUnescapedInQueryStringPairKey = @"[].";
    static NSString * const kMGJCharactersToBeEscapedInQueryString = @":/?&=;+!@#$()',*";
    
    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, (__bridge CFStringRef)kMGJCharactersToLeaveUnescapedInQueryStringPairKey, (__bridge CFStringRef)kMGJCharactersToBeEscapedInQueryString, kCFStringEncodingUTF8);
}

- (NSString *)mgj_md5HashString
{
    // Create pointer to the string as UTF8
    const char* ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, (int)strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",md5Buffer[i]];
    }
    
    return output;
}

- (NSString *)mgj_base64encode
{
    if ([self length] == 0)
        return @"";
    
    const char *source = [self UTF8String];
    long strlength  = strlen(source);
    
    char *characters = malloc(((strlength + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    
    NSUInteger length = 0;
    NSUInteger i = 0;
    
    while (i < strlength) {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < strlength)
            buffer[bufferLength++] = source[i++];
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

+ (NSString *)mgj_UUID
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}

+ (NSString *)mgj_cachesPath
{
    static dispatch_once_t onceToken;
    static NSString *cachedPath;
    
    dispatch_once(&onceToken, ^{
        cachedPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    });
    
    return cachedPath;
}

+ (NSString *)mgj_documentsPath
{
    static dispatch_once_t onceToken;
    static NSString *cachedPath;
    
    dispatch_once(&onceToken, ^{
        cachedPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    });
    
    return cachedPath;
}

+ (NSString *)mgj_temporaryPath
{
    static dispatch_once_t onceToken;
    static NSString *cachedPath;
    
    dispatch_once(&onceToken, ^{
        cachedPath = NSTemporaryDirectory();
    });
    
    return cachedPath;
}

+ (NSString *)mgj_pathForTemporaryFile
{
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIdString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    NSString *tmpPath = [[NSString mgj_temporaryPath] stringByAppendingPathComponent:(__bridge NSString *)newUniqueIdString];
    CFRelease(newUniqueId);
    CFRelease(newUniqueIdString);
    
    return tmpPath;
}

+ (NSString *)mgj_convertToStringWithChar:(NSInteger)charInt
{
    return [NSString stringWithFormat:@"%c", (char)charInt];
}

+ (NSString *)mgj_combineURLWithBaseURL:(NSString *)baseURL parameters:(NSDictionary *)parameters
{
    NSMutableString *combinedURL = [[NSMutableString alloc] initWithString:@""];
    if (baseURL) {
        combinedURL = [baseURL mutableCopy];
        
        if (parameters.count > 0) {
            
            NSMutableString *queryString = [[NSMutableString alloc] init];
            
            NSArray *sortedKeys =[parameters.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
                return [obj1 compare:obj2];
            }];
            
            
            NSUInteger questionMarkLocation = [combinedURL rangeOfString:@"?"].location;
            if (questionMarkLocation != NSNotFound) {
                [queryString appendString:@"&"];
            }
            else
            {
                [queryString appendString:@"?"];
            }
            
            for (id key in sortedKeys) {
                [queryString appendFormat:@"%@=%@&", [key description], [[parameters[key] description] mgj_urlencode]];
            }
            
            if ([queryString hasSuffix:@"&"]) {
                [queryString deleteCharactersInRange:NSMakeRange(queryString.length - 1, 1)];
            }
            
            //处理前端 URL 中的 hash
            NSInteger insertPosition = [combinedURL rangeOfString:@"#"].location;
            if (insertPosition == NSNotFound) {
                insertPosition = combinedURL.length;
            }
            else {
                // 存在问号，并且问号在 hash 之后时，直接把 URL 拼到最后
                if (questionMarkLocation != NSNotFound && questionMarkLocation > insertPosition) {
                    insertPosition = combinedURL.length;
                }
            }
            
            [combinedURL insertString:queryString atIndex:insertPosition];
        }
    }
    return combinedURL;
}

- (NSString *)mgj_trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#if TARGET_OS_IOS

- (CGSize)mgj_sizeWithFont:(UIFont *)font
{
    if (!font) {
        return CGSizeZero;
    }
    return [self sizeWithAttributes:@{NSFontAttributeName:font}];
}
- (CGSize)mgj_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    if (!font) {
        return CGSizeZero;
    }
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size;
}

- (CGSize)mgj_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    if (!font) {
        return CGSizeZero;
    }
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    return [self boundingRectWithSize:size
                              options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine)
                           attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle}
                              context:nil].size;
}
#endif
@end
