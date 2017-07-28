//
//  BaseUsageTest.m
//  RealmDemo
//
//  Created by xiongan on 2017/7/26.
//  Copyright © 2017年 xiongan. All rights reserved.
//

#import "BaseUsageTest.h"
#import <Realm/Realm.h>

@implementation BaseUsageTest

#pragma mark - 创建数据库
+(void)createDataBase {
    //1、使用默认的realm，会在Documents/下生成一个default.realm文件
    RLMRealm *defaultRealm = [RLMRealm defaultRealm];
    
    //2、自定义路径
    NSString *rlmPath =[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingString:@"/custom.realm"];
    RLMRealm *customRealm = [RLMRealm realmWithURL:[NSURL URLWithString:rlmPath]];
    
    //3、通过配置生成realm
   
    RLMRealm *configRealm = [RLMRealm realmWithConfiguration:self.config error:nil];

}
+ (RLMRealmConfiguration *)config {
    static RLMRealmConfiguration *_config  = nil;
    if (!_config) {
        RLMRealmConfiguration *config =  [[RLMRealmConfiguration alloc] init];
        //配置数据迁移的时候，如果有错误导致崩溃问题，会删除数据库重建，不会崩溃，但是数据会丢失。配置NO数据不会丢失，但是应用会崩溃
        config.deleteRealmIfMigrationNeeded = YES;
        NSString *configPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingString:@"/config.realm"];
        config.fileURL = [NSURL URLWithString:configPath];
        //设置realm管理的RLMObjects，管理了那么些表,多个数据库表可以分开管理
        config.objectClasses = @[NSClassFromString(@"Person"),NSClassFromString(@"Dog")];
        _config = config;
    }
    return _config;
}

#pragma mark - 数据库迁移
//在APP didFinishLaunching调用
+(void)dataBaseMigration {
    //如果使用的defualt realm获取默认的config进行迁移
    RLMRealmConfiguration *defaultConfig = [RLMRealmConfiguration defaultConfiguration];
    //配置数据版本，每次项目发布加1
    defaultConfig.schemaVersion = 2;
    defaultConfig.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        if (oldSchemaVersion < 2) {
            //历史版本进行迁移
//            [migration enumerateObjects:@"xxx" block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
//                
//            }];
        }
    };
    //使用自定义配置的config realm进行迁移
    RLMRealmConfiguration *config = self.config;
    //配置数据版本，每次项目发布加1
    config.schemaVersion = 2;
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        if (oldSchemaVersion < 2) {
            //历史版本进行迁移
            //            [migration enumerateObjects:@"xxx" block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
            //
            //            }];
        }
    };
                            
}
@end
