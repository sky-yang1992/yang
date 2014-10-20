//
//  TGDock.m
//  团购
//
//  Created by dan on 14-10-10.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGDock.h"

@interface TGDock()
{
    TGTabItem *_SelectedItem;//被选中的标签
}
@end

@implementation TGDock
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.自动伸缩(高度 + 右边间距)
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        
        // 2.设置背景(图片平铺)
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tabbar.png"]];
        
        // 3.添加LOGO
        [self addLogo];
        
        // 4.添加选项标签
        [self addTabs];
        
        // 5.添加定位
        [self addLocation];
        
        // 6.添加更多
        [self addMore];
     
    }
    return self;
}

#pragma mark 添加选项标签
-(void)addTabs{
    // 1.团购
    [self addOneTab:@"ic_deal.png" selectedIcon:@"ic_deal_hl.png" index:1];
    
    // 2.地图
    [self addOneTab:@"ic_map.png" selectedIcon:@"ic_map_hl.png" index:2];
    
    // 3.收藏
    [self addOneTab:@"ic_collect.png" selectedIcon:@"ic_collect_hl.png" index:3];
    
    // 4.我的
    [self addOneTab:@"ic_mine.png" selectedIcon:@"ic_mine_hl.png" index:4];
    
    // 5.添加底部分割线
    UIImageView *divider = [[UIImageView alloc] init];
    divider.frame = CGRectMake(0, kDockItemH *5, kDockItemW, 2);
    divider.image = [UIImage imageNamed:@"separator_tabbar_item.png"];
    [self addSubview:divider];
}

//添加一个Tab
-(void)addOneTab:(NSString *)Icon selectedIcon:(NSString *)SelectedIcon index:(int)index{
    
    TGTabItem *tab = [[TGTabItem alloc] init];
    [tab setIcon:Icon selectedIcon:SelectedIcon];
    tab.frame = CGRectMake(0, kDockItemH * index, 0, 0);
    [tab addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchDown];
    tab.tag = index - 1;
    [self addSubview:tab];
    
    if (index == 1) {
        [self tabClick:tab];
    }
}

#pragma mark 监听tab点击
-(void)tabClick:(TGTabItem *)tab{
    // 0.通知代理
    if ([_delegate respondsToSelector:@selector(dock:tabChangeFrom:to:)]) {
        [_delegate dock:self tabChangeFrom:_SelectedItem.tag to:tab.tag];
    }
    
    // 1.控制状态
    _SelectedItem.enabled = YES;
    tab.enabled = NO;
    _SelectedItem = tab;
    
    
}

#pragma mark 添加定位
-(void)addLocation{
    TGLocationItem *loc = [[TGLocationItem alloc] init];
    CGFloat y = self.frame.size.height - kDockItemH * 2;
    loc.frame = CGRectMake(0, y, 0, 0);
    [self addSubview:loc];
}

#pragma mark 添加更多
-(void)addMore{
    
    TGMoreItem *more = [[TGMoreItem alloc] init];
    CGFloat y = self.frame.size.height - kDockItemH;//btn的y坐标是frame的高度－自身item的高度
    more.frame = CGRectMake(0, y, 0, 0);
    [self addSubview:more];

}

#pragma mark 添加LOGO
-(void)addLogo{
    
    UIImageView *logo = [[UIImageView alloc] init];
    logo.image = [UIImage imageNamed:@"ic_logo.png"];
    //设置尺寸
    CGFloat scale = 0.65;
    CGFloat logoW = logo.image.size.width * scale;
    CGFloat logoH = logo.image.size.height * scale;
    logo.bounds = CGRectMake(0, 0, logoW, logoH);
    //设置位置
    logo.center = CGPointMake(kDockItemW * 0.5, kDockItemH * 0.5);
    
    [self addSubview:logo];
}

#pragma mark 重写setFrame方法:内定自己的宽度
-(void)setFrame:(CGRect)frame{
    frame.size.width = kDockItemW;
    [super setFrame:frame];
}

@end
