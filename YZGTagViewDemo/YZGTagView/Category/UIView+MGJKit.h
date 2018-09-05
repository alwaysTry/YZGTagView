//
//  UIView+MGJKit.h
//  Example
//
//  Created by limboy on 12/19/14.
//  Copy from https://github.com/matt-holden/UIViewHelpers
//

#import <UIKit/UIKit.h>

@interface UIView (MGJKit)

//- (UIView*)mgj_firstSubviewPassingTest:(BOOL(^)(UIView *subview))test;
//- (NSArray*)mgj_subviewsPassingTest:(BOOL(^)(UIView *subview, BOOL *stop))test;
//- (NSArray*)mgj_subviewsPassingTest:(BOOL(^)(UIView *subview, BOOL *stop))test maxDepth:(NSInteger)depth;
//- (NSArray*)mgj_subviewsMatchingClass:(Class)aClass;
//- (NSArray*)mgj_subviewsMatchingClass:(Class)aClass maxDepth:(NSInteger)depth;
//- (NSArray*)mgj_subviewsMatchingClassOrSubclass:(Class)aClass;
//- (NSArray*)mgj_subviewsMatchingClassOrSubclass:(Class)aClass maxDepth:(NSInteger)depth;
//
///**
// * Removes all subviews.
// */
//- (void)removeAllSubviews;
//
//- (UIImage *)mgj_snapshot;
//
//- (UIImage *)mgj_snapshotAfterScreenUpdates:(BOOL)afterUpdates;
//
////UIView转UIImage
//-(UIImage *)mgj_toImage;

#pragma mark - frame

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;
/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

@end
