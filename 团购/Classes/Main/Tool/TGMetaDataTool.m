//
//  TGMetaDataTool.m
//  团购
//
//  Created by dan on 14-10-15.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGMetaDataTool.h"


@interface TGMetaDataTool()
{
    NSMutableArray *_visitedCityNames; // 存储曾经访问过城市的名称
    
    NSMutableDictionary *_totalCities; // 存放所有的城市 key 是城市名  value 是城市对象
    
    TGCitySection *_visitedSection; // 最近访问的城市组数组
}
@end

@implementation TGMetaDataTool

@synthesize totalCities = _totalCities;
@synthesize totalCitySections = _totalCitySections;
@synthesize currentCity = _currentCity;

singleton_implementation(TGMetaDataTool)

-(id)init{
    if (self = [super init]) {

        //初始化项目中的所有元数据
        
        //存放所有的城市
        _totalCities = [NSMutableDictionary dictionary];
        //存放所有的城市组
        NSMutableArray *tempSections = [NSMutableArray array];
   
        // 1.添加热门城市组
        TGCitySection *hotSections = [[TGCitySection alloc] init];
        hotSections.name = @"热门城市";
        hotSections.cities = [NSMutableArray array];
        [tempSections addObject:hotSections];
        

        // 2.添加A－Z组数组
        // 加载plist数据
        NSArray *azArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Cities.plist" ofType:Nil]];
        
        for (NSDictionary *azDic in azArray) {
            TGCitySection *section = [[TGCitySection alloc] init];        
            [section setValues:azDic];
            [tempSections addObject:section];
                        
            for (TGCity *city in section.cities) {
                
                if (city.hot) {//添加热门城市
                    [hotSections.cities addObject:city];
                }
                [_totalCities setObject:city forKey:city.name];
            }
            
        }
        // 3.从沙盒中读取之前访问过的城市名称
        _visitedCityNames = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        if (_visitedCityNames == nil) {
            _visitedCityNames = [NSMutableArray array];
        }
        
        // 4.添加最近访问城市组
        TGCitySection *visitedSection = [[TGCitySection alloc] init];
        visitedSection.name = @"最近访问";
        visitedSection.cities = [NSMutableArray array];
        _visitedSection = visitedSection;
        
        for (NSString *name in _visitedCityNames) {
            TGCity *city = [_totalCities objectForKey:name];
            [visitedSection.cities addObject:city];
        }
        // 如果最近访问为空，则不显示最近访问项
        if (_visitedCityNames.count) {
            [tempSections insertObject:visitedSection atIndex:0];
        }
        _totalCitySections = tempSections;
    }
    return self;
}

- (void)setCurrentCity:(TGCity *)currentCity
{
    _currentCity = currentCity;
    
    // 1.移除之前的城市名
    [_visitedCityNames removeObject:currentCity.name];
    
    // 2.将新的城市名放到最前面
    [_visitedCityNames insertObject:currentCity.name atIndex:0];
    
    // 3.将新的城市放到_visitedSection的最前面
    [_visitedSection.cities removeObject:currentCity];
    [_visitedSection.cities insertObject:currentCity atIndex:0];
    
    // 4.将刚刚点击的城市名存入沙盒
    [NSKeyedArchiver archiveRootObject:_visitedCityNames toFile:kFilePath];
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCityChangeNote object:nil];
    
    // 一旦设置当前城市，必须添加最近访问城市
    if (![_totalCitySections containsObject:_visitedSection]) {
        NSMutableArray *allSection = [NSMutableArray arrayWithArray:_totalCitySections];//将NSArray强转为NSMutableArray
        [allSection insertObject:_visitedSection atIndex:0];
        NSLog(@"allSection:%@",allSection);
    }

}

@end
