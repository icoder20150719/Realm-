//
//  RLMOrderService.h
//  RealmDemo
//
//  Created by xiongan on 2017/7/28.
//  Copyright © 2017年 xiongan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RLMOrder.h"

@interface RLMOrderService : NSObject

+ (BOOL)saveOrder:(RLMOrder *)order;
+ (BOOL)saveOrders:(NSArray *)orders;
+ (RLMOrder *)queryOrderWithOrderNumber:(NSString *)orderNumber;
+ (RLMOrder *)queryOrderWhere:(NSString *)where;

@end
