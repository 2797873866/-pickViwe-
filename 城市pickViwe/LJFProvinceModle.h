//
//  LJFProvinceModle.h
//  GroupBuy
//
//  Created by ljf on 2017/2/8.
//  Copyright © 2017年 招. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface LJFProvinceModle : NSObject<MJKeyValue>

@property (nonatomic ,strong)NSArray * cities;
@property (nonatomic , copy) NSString * id;
@property (nonatomic , copy) NSString * name;

- (NSArray*)loadInfoWithPlist;



@end
