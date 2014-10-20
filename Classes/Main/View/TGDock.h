//
//  TGDock.h
//  团购
//
//  Created by dan on 14-10-10.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGMoreItem.h"
#import "TGLocationItem.h"
#import "TGTabItem.h"

@class TGDock;

@protocol TGDockDelegate <NSObject>
@optional
-(void)dock:(TGDock *)dock tabChangeFrom:(int)from to:(int)to;

@end

@interface TGDock : UIView

@property(nonatomic,weak)id<TGDockDelegate>delegate;

-(void)addLogo;      //添加LOGO

-(void)addTabs;      //添加选项标签

-(void)addLocation;  //添加定位

-(void)addMore;      //添加更多

-(void)addOneTab:(NSString *)Icon selectedIcon:(NSString *)SelectedIcon index:(int)index;//添加一个Tab

-(void)tabClick:(TGTabItem *)tab;//监听tab点击

@end
