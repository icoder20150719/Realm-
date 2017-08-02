//
//  RLMMessage.m
//  RealmDemo
//
//  Created by xiongan on 2017/8/2.
//  Copyright © 2017年 xiongan. All rights reserved.
//

#import "RLMMessage.h"

@implementation RLMMessage
/*设置主键*/
+(NSString *)primaryKey {
    return @"mid";
}
/*设置不能为空属性*/
+ (NSArray<NSString *> *)requiredProperties {
    return @[@"body",@"createdDate"];
}
/*设置为默认值*/
+ (nullable NSDictionary *)defaultPropertyValues {
    return @{@"read":@(NO)};
}
/*设置忽略属性，不存数据库*/
+(NSArray<NSString *> *)ignoredProperties {
    return @[@"selected"];
}
@end
