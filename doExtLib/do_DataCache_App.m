//
//  do_DataCache_App.m
//  DoExt_SM
//
//  Created by 刘吟 on 15/4/9.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import "do_DataCache_App.h"
static do_DataCache_App* instance;

@implementation do_DataCache_App
@synthesize OpenURLScheme;
+(id) Instance
{
    if(instance==nil)
        instance = [[do_DataCache_App alloc]init];
    return instance;
}
@end
