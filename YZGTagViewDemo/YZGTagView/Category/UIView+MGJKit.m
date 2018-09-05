//
//  UIView+MGJKit.m
//  Example
//
//  Created by limboy on 12/19/14.
//  Copy from https://github.com/matt-holden/UIViewHelpers
//

#define INFINITE_DEPTH -1 // Only used internally for private API

#define SuppressPerformSelectorLeakWarning(LeakyCode) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
LeakyCode; \
_Pragma("clang diagnostic pop") \
} while (0)

#import "UIView+MGJKit.h"
//#import "UIImage+MGJKit.h"

@implementation UIView (MGJKit)

//- (NSArray *)mgj_subviewsPassingTest:(BOOL(^)(UIView *subview, BOOL *stop))test {
//    __block BOOL stop = NO;
//    
//    NSArray*(^__block __unsafe_unretained capturedEvaluateAndRecurse)(UIView*);
//    NSArray*(^evaluateAndRecurse)(UIView*);
//    evaluateAndRecurse = ^NSArray*(UIView *view) {
//        NSMutableArray *myPassedChildren = [[NSMutableArray alloc] init];
//        for (UIView *subview in [view subviews]) {
//            BOOL passes = test(subview, &stop);
//            if (passes) [myPassedChildren addObject:subview];
//            if (stop) return myPassedChildren;
//            
//            [myPassedChildren addObjectsFromArray:capturedEvaluateAndRecurse(subview)];
//        }
//        return myPassedChildren;
//    };
//    capturedEvaluateAndRecurse = evaluateAndRecurse;
//    
//    return evaluateAndRecurse(self);
//}
//
//- (NSArray *)mgj_subviewsPassingTest:(BOOL(^)(UIView *subview, BOOL *stop))test maxDepth:(NSInteger)maxDepth {
//    
//    if (maxDepth < 0) {
//        [NSException raise:NSInvalidArgumentException format:@"maxDepth must be >= 0"];
//    }
//    
//    // Wrap "test" block argument in a new block that checks
//    // subview depth prior to executing "test."
//    BOOL(^newTest)(UIView *subview, BOOL*stop) = ^BOOL(UIView* subview, BOOL *stop) {
//        int currentDepth = 0;
//        
//        UIView *node = subview;
//        while (!([node isEqual:self])) {
//            node = [node superview];
//            // If "subview" is deeper than maxDepth, we can safely exclude
//            // this subview without executing "test"
//            if (++currentDepth > maxDepth) return NO;
//        }
//        return test(subview, stop);
//    };
//    return [self mgj_subviewsPassingTest:newTest];
//}
//
//- (UIView *)mgj_firstSubviewPassingTest:(BOOL(^)(UIView *subview))test {
//    BOOL(^innerTestBlock)(UIView *subview, BOOL *stop) = ^BOOL(UIView *subview, BOOL *stop) {
//        // Stop the moment we have a passing test
//        BOOL passed = *stop = test(subview);
//        return passed;
//    };
//    
//    NSArray *returnArray = [self mgj_subviewsPassingTest:innerTestBlock];
//    return [returnArray count] ? returnArray[0] : nil;
//}
//
//- (NSArray *)mgj_subviewsMatchingClass:(Class)aClass {
//    return [self mgj_subviewsMatchingClass:[aClass class]
//                     includeSubclasses:NO
//                              maxDepth:INFINITE_DEPTH];
//}
//
//- (NSArray *)mgj_subviewsMatchingClass:(Class)aClass maxDepth:(NSInteger)depth {
//    return [self mgj_subviewsMatchingClass:[aClass class]
//                     includeSubclasses:NO
//                              maxDepth:depth];
//}
//
//- (NSArray *)mgj_subviewsMatchingClassOrSubclass:(Class)aClass {
//    return [self mgj_subviewsMatchingClass:[aClass class]
//                     includeSubclasses:YES
//                              maxDepth:INFINITE_DEPTH];
//}
//- (NSArray *)mgj_subviewsMatchingClassOrSubclass:(Class)aClass maxDepth:(NSInteger)depth {
//    return [self mgj_subviewsMatchingClass:[aClass class]
//                     includeSubclasses:YES
//                              maxDepth:depth];
//    
//}
//
//- (void)removeAllSubviews {
//    while (self.subviews.count) {
//        UIView* child = self.subviews.lastObject;
//        [child removeFromSuperview];
//    }
//}
//
//- (UIImage *)mgj_snapshot
//{
//    return [self mgj_snapshotAfterScreenUpdates:NO];
//}
//
//- (UIImage *)mgj_snapshotAfterScreenUpdates:(BOOL)afterUpdates
//{
//    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
//    
//    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
//        
//        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
//    } else {
//        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//    }
//    
//    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return snapshotImage;
//}
//
//- (UIImage *)mgj_toImage {
//    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
//    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//
//    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
//
//    UIGraphicsEndImageContext();
//
//    return img;
//}


#pragma mark - frame
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

#pragma mark Private methods

//-(NSArray*)mgj_subviewsMatchingClass:(Class)aClass includeSubclasses:(BOOL)includeSubclasses maxDepth:(NSInteger)maxDepth {
//    
//    SEL comparisonSelector = includeSubclasses ? @selector(isKindOfClass:) : @selector(isMemberOfClass:);
//    if (maxDepth == INFINITE_DEPTH)
//        return [self mgj_subviewsPassingTest:^BOOL(UIView *subview, BOOL *stop) {
//            SuppressPerformSelectorLeakWarning(return (BOOL)[subview performSelector:comparisonSelector withObject:aClass]);
//        }];
//    else
//        return [self mgj_subviewsPassingTest:^BOOL(UIView *subview, BOOL *stop) {
//            SuppressPerformSelectorLeakWarning(return (BOOL)[subview performSelector:comparisonSelector withObject:aClass]);
//        } maxDepth:maxDepth];
//}

@end
