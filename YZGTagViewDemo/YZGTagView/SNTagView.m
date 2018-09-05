//
//  SNTagView.m
//  SNTagView
//
//  Created by 阎志刚 on 16/7/27.
//  Copyright © 2016年 卷瓜. All rights reserved.
//

#import "SNTagView.h"
#import "UIColor+MGJKit.h"
#import "NSString+MGJKit.h"
#import "UIFont+SNConfig.h"
#import "UIView+MGJKit.h"
#import <objc/runtime.h>

@interface SNTagView ()

/** 初始化的tag数组 */
@property (nonatomic, copy) NSArray <SNTagEntity*> *tagEntityArray;
@property (nonatomic, strong) NSMutableArray <SNTagEntity*> *tagEntityArrayForRestUI;
@property (nonatomic, copy) SNTagTouchCallBack callBackBlock;
@property (nonatomic, strong) NSMutableArray <SNTagEntity*> *selectedTagArray;
@property (nonatomic, strong) UIButton *currentSelectedTagButton;

/** 所有选中的tag对应的entity都放在这里面 */
@property (nonatomic, strong) NSMutableArray <SNTagEntity *> *selectedTagEntityArray;

@end

static CGFloat minWidth = 30.f;  // 最小宽度
static CGFloat tagButtonX = 5.f; // X值
static CGFloat tagButtonY = 5.f; // Y值
static CGFloat tagButtonHorizontalSpace = 20.f; // 两个tagButton之间的水平间隙
static CGFloat tagButtonVerticalSpace = 20.f; // 两个tagButton之间的垂直间隙
static CGFloat tagButtonBorderWidth = 0.5f; // tagButton初始边款宽度
static CGFloat tagButtonCornerRadius = 10.f; // tagButton初始圆角
static CGFloat tagButtonTitleFontSize = 14.f; // tagButton标题初始化font
static NSInteger tagButtonTagSpike = 100; // tagButton的tag增量

@implementation SNTagView

- (instancetype)initTagViewWithWidth:(CGFloat)width tagArray:(NSArray <SNTagEntity*> *)tagArray tagButtonTouchBlock:(SNTagTouchCallBack)callBackBlock
{
    // check
    if (width <= 0.f ) {
        NSAssert(@"SNTagView width not conform to the specifications ", @"SNTagView 宽度有问题");
    }
    
    if (!tagArray.count) {
        NSAssert(@"SNTagView tagArray can not empty", @"SNTagView tagArray 不能为空");
    }
    
    if (self == [super init]) {
        self.width = width;
        self.tagEntityArray = tagArray;
        self.tagEntityArrayForRestUI = [NSMutableArray array];
        [tagArray enumerateObjectsUsingBlock:^(SNTagEntity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SNTagEntity *entity = [SNTagEntity new];
            entity.tagName = obj.tagName;
            entity.tagId = obj.tagId;
            entity.checked = obj.checked;
            [self.tagEntityArrayForRestUI addObject:entity];
        }];
        self.selectedTagEntityArray = [NSMutableArray array];
        self.callBackBlock = callBackBlock;
        [self setupSubViews];
    }
    
    return self;
}

- (void)setupSubViews {
    
    for (int index = 0; index < self.tagEntityArray.count; index ++) {
        SNTagEntity *entity = [self.tagEntityArray objectAtIndex:index];
        UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tagButton setTitle:entity.tagName forState:UIControlStateNormal];
        [tagButton setTitleColor:[UIColor mgj_colorWithHexString:@"666666" alpha:1] forState:UIControlStateNormal];
        tagButton.layer.borderWidth = tagButtonBorderWidth;
        tagButton.layer.borderColor = [UIColor mgj_colorWithHexString:@"999999" alpha:1].CGColor;
        tagButton.layer.cornerRadius = tagButtonCornerRadius;
        tagButton.layer.masksToBounds = YES;
        tagButton.titleLabel.font = [UIFont lightSystemFontOfSize:tagButtonTitleFontSize];
        [tagButton addTarget:self action:@selector(tagButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
        tagButton.tag = index + tagButtonTagSpike;
        // title size
        CGSize titleSize = [entity.tagName mgj_sizeWithFont:tagButton.titleLabel.font];
        // 取出前一个button
        UIButton *compareButton = [self viewWithTag:index - 1 + tagButtonTagSpike];
        
        CGFloat X = tagButtonX + compareButton.right + (index > 0 ? tagButtonHorizontalSpace : 0.f);
        CGFloat width = titleSize.width + 10.f;
        if (width > self.width - 40.f) {
            width = self.width - 40.f;
        } else if (width < minWidth) {
            width = minWidth;
        }
        tagButton.frame = CGRectMake(X, (compareButton.top == 0 ? tagButtonY : compareButton.top), width, titleSize.height + 15.f);
        // 如果超出屏幕
        if (tagButton.right > self.width) {
            tagButton.left = tagButtonX;
            tagButton.top = compareButton.bottom + tagButtonVerticalSpace;
        }
        
        [self addSubview:tagButton];
        
        if (index == self.tagEntityArray.count - 1) {
            // 最后一个
            self.height = tagButton.bottom + tagButtonY;
        }
        if (entity.checked) {
            [self tagButtonTaped:tagButton];
        }
    }
}

#pragma mark - tag按钮的点击事件
/** tag按钮的点击事件 */
- (void)tagButtonTaped:(UIButton *)sender {
    sender.selected = !sender.selected;
    // 对应的entity
    SNTagEntity *tagEntity = self.tagEntityArray[sender.tag - tagButtonTagSpike];
    
    if (sender.selected) {
        // 选中状态
        UIColor *defaultSelectColor = [UIColor mgj_colorWithHexString:@"F86738" alpha:1.f];
        [sender setTitleColor:self.selectedColor ? self.selectedColor :defaultSelectColor forState:UIControlStateSelected];
        sender.layer.borderColor = self.selectedColor ? self.selectedColor.CGColor :defaultSelectColor.CGColor;
        if (self.singleCheck) {
            // 单选
            self.currentSelectedTagButton.selected = NO;
            UIColor *defaultNormalColor = [UIColor mgj_colorWithHexString:@"999999" alpha:1];
            self.currentSelectedTagButton.layer.borderColor = self.normalColor ? self.normalColor.CGColor : defaultNormalColor.CGColor;
            self.currentSelectedTagButton = nil;
            self.currentSelectedTagButton = sender;
            if (self.callBackBlock) {
                tagEntity.checked = YES;
                self.callBackBlock(tagEntity, nil);
            }
        } else {
            // 更新数据
            [self.selectedTagEntityArray addObject:tagEntity];
            self.selectedTagArray = self.selectedTagEntityArray;
            if (self.callBackBlock) {
                tagEntity.checked = YES;
                self.callBackBlock(tagEntity, self.selectedTagArray);
            }
        }
    } else {
        // normal状态
        UIColor *defaultNormalColor = [UIColor mgj_colorWithHexString:@"999999" alpha:1];
        sender.layer.borderColor = self.normalColor ? self.normalColor.CGColor : defaultNormalColor.CGColor;

        // 更新数据
        [self.selectedTagEntityArray removeObject:tagEntity];
        self.selectedTagArray = self.selectedTagEntityArray;
        if (self.singleCheck) {
            // 单选
            self.currentSelectedTagButton = nil;
        }
        if (self.callBackBlock) {
            tagEntity.checked = NO;
            self.callBackBlock(tagEntity, self.selectedTagArray);
        }
    }
}

#pragma mark - backgroundColor
- (void)setTagButtonBackgroundColor:(UIColor *)tagButtonBackgroundColor {
    if (tagButtonBackgroundColor) {
        _tagButtonBackgroundColor = tagButtonBackgroundColor;
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)view;
                [button setBackgroundColor:tagButtonBackgroundColor];
            }
        }
    }
}

#pragma mark - normal 状态下的颜色
/** normal 状态下的颜色 */
- (void)setNormalColor:(UIColor *)normalColor {
    if (normalColor) {
        _normalColor = normalColor;
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)view;
                [button setTitleColor:normalColor forState:UIControlStateNormal];
                button.layer.borderColor = normalColor.CGColor;
            }
        }
    }
}

#pragma mark - selected 状态下的颜色
/** selected 状态下的颜色 */
- (void)setSelectedColor:(UIColor *)selectedColor {
    if (selectedColor) {
        _selectedColor = selectedColor;
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                [(UIButton *)view setTitleColor:selectedColor forState:UIControlStateSelected];
            }
        }
    }
}

/**
 *  UI重置
 */
- (void)resetTagViewUI {
    for (NSUInteger index = 0; index < self.tagEntityArrayForRestUI.count; index ++) {
        SNTagEntity *entity = self.tagEntityArrayForRestUI[index];
        UIButton *button = [self viewWithTag:index + tagButtonTagSpike];
        button.selected = entity.checked;
        button.layer.borderColor = button.selected ? [UIColor mgj_colorWithHexString:@"F86738" alpha:1.f].CGColor :[UIColor mgj_colorWithHexString:@"999999" alpha:1].CGColor;
    }
}

- (void)setSingleCheck:(BOOL)singleCheck
{
    objc_setAssociatedObject(self, @selector(singleCheck), @(singleCheck), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)singleCheck
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
