//
//  TGMetaDataTool.h
//  团购
//
//  Created by dan on 14-10-15.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//  元数据管理类
//  1.城市数据
//  2.下属分区数据
//  3.分类数据

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "TGCitySection.h"
#import "TGCity.h"
#define kFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:@"visitedCityNames.data"]

@interface TGMetaDataTool : NSObject

singleton_interface(TGMetaDataTool)

@property (nonatomic, strong, readonly) NSDictionary *totalCities; // 所有的城市
@property(nonatomic,strong,readonly)NSArray *totalCitySections;//所有的城市组数据
@property (nonatomic, strong) TGCity *currentCity; // 当前选中的城市

@end
