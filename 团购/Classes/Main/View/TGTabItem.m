//
//  TGTabItem.m
//  团购
//
//  Created by dan on 14-10-12.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGTabItem.h"

@implementation TGTabItem

#pragma mark - 初始化方法
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置选中（disable）时的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"bg_tabbar_item.png"] forState:UIControlStateDisabled];
    }
    return self;
}

-(void)setEnabled:(BOOL)enabled{
    //控制顶部分隔线要不要显示(当tab不可点击时隐藏分割线)
    _divider.hidden = !enabled;
    [super setEnabled:enabled];
}

@end
