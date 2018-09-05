//
//  ViewController.m
//  YZGTagViewDemo
//
//  Created by HLL on 2018/9/5.
//  Copyright © 2018年 阎志刚. All rights reserved.
//

#import "ViewController.h"
#import "SNTagEntity.h"
#import "SNTagView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTagView];
}


- (void)setupTagView {
    // init data source
    NSMutableArray *entityArray = [NSMutableArray array];
    for (NSInteger index = 0; index < 15; index ++) {
        SNTagEntity *entity = [SNTagEntity new];
        entity.tagName = [NSString stringWithFormat:@"Test - %ld", index];
        [entityArray addObject:entity];
    }
    
    // setup max width
    CGFloat width = self.view.bounds.size.width - 40.f;
    
    // init tag view
    SNTagView *tagView = [[SNTagView alloc] initTagViewWithWidth:width tagArray:entityArray tagButtonTouchBlock:^(SNTagEntity *tagEntity, NSArray *selectedTagArray) {
        NSLog(@"%@", tagEntity.tagName);
    }];
    
    // setup other property
    tagView.singleCheck = NO;
    tagView.tagButtonBackgroundColor = [UIColor whiteColor];
    tagView.selectedColor = [UIColor orangeColor];
    tagView.normalColor = [UIColor grayColor];
    
    // frame
    tagView.frame = CGRectMake(20.f, 50.f, width, tagView.bounds.size.height);
    
    [self.view addSubview:tagView];
}

@end
