//
//  TGCityListController.h
//  团购
//
//  Created by dan on 14-10-13.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGCitySection.h"
#import "NSObject+Value.h"
#import "TGCity.h"
#import "TGMetaDataTool.h"
#import "TGSearchResultController.h"

@interface TGCityListController : UIViewController

-(void)addSearchBar;    //添加搜索栏

-(void)addTableView;    //添加TableView

-(void)loadCitiesData;  //加载城市数据
 
-(void)coverClick;      //监听点击遮盖（黑色背景）

@end
