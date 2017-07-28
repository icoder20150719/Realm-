//
//  RLMOrder.h
//  RealmDemo
//
//  Created by xiongan on 2017/7/28.
//  Copyright © 2017年 xiongan. All rights reserved.
//  这是一个简化的订单模型设计，拟在举列子
//

#import <Realm/Realm.h>
#import "RLMProduct.h"

@interface RLMOrder : RLMObject

/**订单号 主键*/
@property NSString *orderNumber;
/**订单价格*/
@property NSString *orderAmount;
/**订单状态*/
@property NSString *orderStatus;
/**订单商品*/
@property RLMArray <RLMProduct>*orderItems;

@end
RLM_ARRAY_TYPE(RLMOrder)
