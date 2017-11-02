//
//  do_DataCache_SM.m
//  DoExt_SM
//
//  Created by @userName on @time.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import "do_DataCache_SM.h"

#import "doScriptEngineHelper.h"
#import "doIScriptEngine.h"
#import "doInvokeResult.h"
#import "doJsonHelper.h"
@interface do_DataCache_SM()
@property (nonatomic,strong) NSUserDefaults *userDefault;
@end

static NSString *userDefaultName = @"deviceone";
@implementation do_DataCache_SM
#pragma mark -
#pragma mark - 同步异步方法的实现
- (NSUserDefaults *)userDefault
{
    if (!_userDefault) {
        _userDefault = [[NSUserDefaults alloc]initWithSuiteName:userDefaultName];
    }
    return _userDefault;
}
//同步
- (void)hasData:(NSArray *)parms
{
    NSDictionary *_dictParas = [parms objectAtIndex:0];
    //参数字典_dictParas
    doInvokeResult *_invokeResult = [parms objectAtIndex:2];
    NSString *key = [doJsonHelper GetOneText:_dictParas :@"key" :@""];
    if (key.length <= 0) {
        [_invokeResult SetResultValue:[NSNull null]];
        return;
    }
    id value = [self.userDefault objectForKey:key];
    
    if (value == nil) {
        [_invokeResult SetResultBoolean:NO];
    }
    else
    {
        [_invokeResult SetResultBoolean:YES];
    }
}
- (void)removeAll:(NSArray *)parms
{
    doInvokeResult *_invokeResult = [parms objectAtIndex:2];
    [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:userDefaultName];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [_invokeResult SetResultBoolean:YES];
}
- (void)removeData:(NSArray *)parms
{
    NSDictionary *_dictParas = [parms objectAtIndex:0];
    //参数字典_dictParas
    doInvokeResult *_invokeResult = [parms objectAtIndex:2];
    //自己的代码实现
    NSString *key = [doJsonHelper GetOneText:_dictParas :@"key" :@""];
    if (key.length <= 0) {
        [_invokeResult SetResultValue:[NSNull null]];
        return;
    }
    [self.userDefault removeObjectForKey:key];
    BOOL isExt = [self.userDefault synchronize];
    [_invokeResult SetResultBoolean:isExt];
}
- (void)loadData:(NSArray *)parms
{
    NSDictionary *_dictParas = [parms objectAtIndex:0];
    doInvokeResult *_invokeResult = [parms objectAtIndex:2];
    //自己的代码实现
    NSString* key = [doJsonHelper GetOneText: _dictParas :@"key" :@"" ];
    if(key.length<=0){
        [_invokeResult SetResultValue:[NSNull null]];
        return;
    }
    id value = [self.userDefault objectForKey:key];
    [_invokeResult SetResultValue:value];
}
- (void)saveData:(NSArray *)parms
{
    NSDictionary *_dictParas = [parms objectAtIndex:0];
    doInvokeResult *_invokeResult = [parms objectAtIndex:2];
    NSString* key = [doJsonHelper GetOneText: _dictParas :@"key" :@"" ];
    NSString* value = [doJsonHelper GetOneText: _dictParas :@"value" :@"" ];
    if(key.length<=0){
        [_invokeResult SetResultBoolean:NO];
        return;
    }
    [self.userDefault setObject:value forKey:key];
    [self.userDefault synchronize];
    [_invokeResult SetResultBoolean:YES];
}
//异步

@end