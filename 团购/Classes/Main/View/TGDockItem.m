//
//  TGDockItem.m
//  团购
//
//  Created by dan on 14-10-10.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGDockItem.h"

@implementation TGDockItem

@synthesize icon;
@synthesize selectedIcon;

#pragma mark - 初始化方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.添加Dock顶部的分割线
        UIImageView *divider = [[UIImageView alloc] init];
        divider.frame = CGRectMake(0, 0, kDockItemW, 2);
        divider.image = [UIImage imageNamed:@"separator_tabbar_item.png"];
        [self addSubview:divider];
        _divider = divider;
    }
    return self;
}

#pragma mark 重写setFrame方法:内定自己的宽度
-(void)setFrame:(CGRect)frame{
    frame.size = CGSizeMake(kDockItemW, kDockItemH);
    [super setFrame:frame];
}
//没有高亮状态
-(void)setHighlighted:(BOOL)highlighted{}

#pragma mark - 设置按钮内部图片
-(void)setIcon:(NSString *)Icon selectedIcon:(NSString *)SelectedIcon{
    self.icon = Icon;
    self.selectedIcon = SelectedIcon;
}

-(void)setIcon:(NSString *)Icon{
    [self setImage:[UIImage imageNamed:Icon] forState:UIControlStateNormal];
}

-(void)setSelectedIcon:(NSString *)SelectedIcon{    
    [self setImage:[UIImage imageNamed:SelectedIcon] forState:UIControlStateDisabled];
}




@end
