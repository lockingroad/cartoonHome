//
//  NSString+CityName.m
//  FengYou
//
//  Created by Walkman on 2017/1/17.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "NSString+CityName.h"

@implementation NSString (CityName)

+ (NSString *)getCityName {
    return  [NSString stringWithFormat:@"%@", [KCURRENTCITYINFODEFAULTS objectForKey:@"currentCity"]];
}

@end
