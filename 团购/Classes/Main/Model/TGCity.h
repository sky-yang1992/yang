//
//  TGCity.h
//  团购
//
//  Created by dan on 14-10-14.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGBaseModel.h"
#import "TGDistrict.h"
#import "NSObject+Value.h"

@interface TGCity : TGBaseModel

@property(nonatomic,strong)NSArray *districts;//城市分区
@property(nonatomic,assign)BOOL hot;          //是否为热门城市

@end
