//
//  TGMoreItem.m
//  团购
//
//  Created by dan on 14-10-12.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGMoreItem.h"

@implementation TGMoreItem

#pragma mark - 初始化方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.距离顶部自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        // 2.设置图片
        [self setIcon:@"ic_more.png" selectedIcon:@"ic_more_hl.png"];
        // 3.监听点击
        [self addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

-(void)moreClick{
    
    self.enabled = NO;
    
    //弹出更多控制器
    TGMoreController *more = [[TGMoreController alloc] init];
    more.moreItem = self;
    TGNavigationController *nav = [[TGNavigationController alloc] initWithRootViewController:more];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

@end
