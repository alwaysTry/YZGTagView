//
//  SNQuestionTagEntity.h
//  SnobMass
//
//  Created by 阎志刚 on 16/5/4.
//  Copyright © 2016年 卷瓜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNTagEntity : NSObject

/** name */
@property (nonatomic, copy) NSString *tagName;

/** isChedked */
@property (nonatomic, assign) NSInteger checked;

/** id */
@property (nonatomic, assign) NSInteger tagId;

@end
