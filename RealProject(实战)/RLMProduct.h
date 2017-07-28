//
//  RLMProduct.h
//  RealmDemo
//
//  Created by xiongan on 2017/7/28.
//  Copyright © 2017年 xiongan. All rights reserved.
//  本商品模型是一个简化的模型，拟在举例子，实际模型复杂的多
//

#import <Realm/Realm.h>

@interface RLMProduct : RLMObject
/**商品 名字*/
@property NSString *name;
/**商品 价格*/
@property NSString *price;
/**商品 图片*/
@property NSString *imgUrl;
@end
RLM_ARRAY_TYPE(RLMProduct)
