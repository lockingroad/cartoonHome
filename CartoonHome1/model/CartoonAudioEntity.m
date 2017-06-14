//
//  CartoonAudioEntity.m
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/6/13.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "CartoonAudioEntity.h"


@implementation CartoonAudioEntity

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"data" : @"CartoonAudioInfo"
             };
}

-(NSMutableDictionary *)dicFromData
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:10];
    NSMutableArray *enArr=[NSMutableArray array];
    NSMutableArray *cnArr=[NSMutableArray array];
    NSMutableArray *enIndex=[NSMutableArray array];
    NSMutableArray *cnIndex=[NSMutableArray array];
    
    
    for(int i=0;i<_data.count-1;i++){
        CartoonAudioInfo *info=[_data objectAtIndex:i];
        
        AudioInfo *cnAudio=info.audio[0];
        [cnIndex addObject:[NSNumber numberWithInteger:cnArr.count]];
        for(int j=0;j<cnAudio.audioname.count;j++){
            [cnArr addObject:cnAudio.audioname[j]];
        }
        
        AudioInfo *enAudio=info.audio[1];
        [enIndex addObject:[NSNumber numberWithInteger:enArr.count]];
        for(int h=0;h<enAudio.audioname.count;h++){
            [enArr addObject:enAudio.audioname[h]];
        }
    }
    
    [dic setObject:enArr forKey:@"enArr"];
    [dic setObject:cnArr forKey:@"cnArr"];
    [dic setObject:enIndex forKey:@"enIndex"];
    [dic setObject:cnIndex forKey:@"cnIndex"];
    
    return dic;
}
@end
