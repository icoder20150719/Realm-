//
//  RPDataBase.m
//  RealmDemo
//
//  Created by xiongan on 2017/7/28.
//  Copyright © 2017年 xiongan. All rights reserved.
//

#import "RPDataBase.h"
#import <Realm/Realm.h>

@implementation RPDataBase
+ (RLMRealmConfiguration *)config {
    static RLMRealmConfiguration *_config  = nil;
    if (!_config) {
        RLMRealmConfiguration *config =  [[RLMRealmConfiguration alloc] init];
        //配置数据迁移的时候，如果有错误导致崩溃问题，会删除数据库重建，不会崩溃，但是数据会丢失。配置NO数据不会丢失，但是应用会崩溃
        config.deleteRealmIfMigrationNeeded = YES;
        NSString *configPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingString:@"/db.realm"];
        config.fileURL = [NSURL URLWithString:configPath];
        //设置realm管理的RLMObjects，管理了那么些表,多个数据库表可以分开管理
        config.objectClasses = @[NSClassFromString(@"RLMOrder"),
                                 NSClassFromString(@"RLMProduct"),
                                 NSClassFromString(@"RLMMessage")];
        _config = config;
    }
    return _config;
}


+ (RPDataBase *)db {
    RPDataBase *configRealm = [RPDataBase realmWithConfiguration:self.config error:nil];
    return configRealm;
}
+ (void)dataBaseMigration {
    //使用自定义配置的config realm进行迁移
    RLMRealmConfiguration *config = self.config;
    //配置数据版本，每次项目发布加1
    config.schemaVersion = 2;
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        if (oldSchemaVersion < 2) {
            
        }
    };
    
}
+ (BOOL)dropRealmIfNeed {
    return [[NSFileManager defaultManager] removeItemAtPath:self.config.fileURL.path error:nil];
}
@end
