//
//  DataBase.h
//  RealmDemo
//
//  Created by xiongan on 2017/7/26.
//  Copyright © 2017年 xiongan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RLMRealm;
@interface DataBase : NSObject
+ (RLMRealm *)db;
+ (void)dataBaseMigration;
+ (BOOL)dropRealmIfNeed;
@end
