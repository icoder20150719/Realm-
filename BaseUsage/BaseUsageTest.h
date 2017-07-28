//
//  BaseUsageTest.h
//  RealmDemo
//
//  Created by xiongan on 2017/7/26.
//  Copyright © 2017年 xiongan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseUsageTest : NSObject
#pragma mark - 创建数据库
+(void)createDataBase;

#pragma mark - 数据库迁移
//在APP didFinishLaunching调用
+(void)dataBaseMigration;



@end
