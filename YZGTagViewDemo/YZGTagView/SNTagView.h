//
//  SNTagView.h
//  SNTagView
//
//  Created by 阎志刚 on 16/7/27.
//  Copyright © 2016年 卷瓜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNTagEntity.h"

typedef void(^SNTagTouchCallBack)(SNTagEntity *tagEntity, NSArray *selectedTagArray);

@interface SNTagView : UIView

/**
 *  多选or单选
 */
@property (nonatomic, assign) BOOL singleCheck;

/** 选中tag对应的entity，都放在这个数组 */
@property (nonatomic, strong, readonly) NSArray <SNTagEntity*> *selectedTagArray;

/** 背景颜色 */
@property (nonatomic, strong) UIColor *tagButtonBackgroundColor;

/** normal 状态下的颜色 */
@property (nonatomic, strong) UIColor *normalColor;

/** selected 状态下的颜色 */
@property (nonatomic, strong) UIColor *selectedColor;

/**
 *  用frame(确定最大的宽度)与
 *
 *  @param frame    frame
 *  @param tagArray 初始化的tag数组
 */
- (instancetype)initTagViewWithWidth:(CGFloat)width tagArray:(NSArray <SNTagEntity*> *)tagArray tagButtonTouchBlock:(SNTagTouchCallBack)callBackBlock;

/**
 *  back original UI
 */
- (void)resetTagViewUI;
@end
