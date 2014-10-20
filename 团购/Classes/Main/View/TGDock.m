//
//  TGDock.m
//  团购
//
//  Created by dan on 14-10-10.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGDock.h"

#define kDockItemW 100  //Dock中Item的宽度
#define kDockItemH 100  //Dock中Item的高度


@implementation TGDock

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
    
}

#pragma mark 添加定位
-(void)addLocation{
    
}

#pragma mark 添加更多
-(void)addMore{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"ic_more.png"] forState:UIControlStateNormal];
    CGFloat y = self.frame.size.height - kDockItemH;//btn的y坐标是frame的高度－自身item的高度
    btn.frame = CGRectMake(0, y, kDockItemW, kDockItemH);
    [self addSubview:btn];
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
