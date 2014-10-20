//
//  TGDockItem.h
//  团购
//
//  Created by dan on 14-10-10.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//Dock上所有Item的父类

#import <UIKit/UIKit.h>

@interface TGDockItem : UIButton
{
    UIImageView *_divider;
}
@property(nonatomic,copy)NSString *icon;        //普通图片
@property(nonatomic,copy)NSString *selectedIcon;//选中的图片
-(void)setIcon:(NSString *)Icon selectedIcon:(NSString *)SelectedIcon;//同时设置两个按钮

@end
