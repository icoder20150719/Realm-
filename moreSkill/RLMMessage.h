//
//  RLMMessage.h
//  RealmDemo
//
//  Created by xiongan on 2017/8/2.
//  Copyright © 2017年 xiongan. All rights reserved.
//
#import <Realm/Realm.h>

#import "RLMObject.h"

@interface RLMMessage : RLMObject
/*消息id 主键不能为空*/
@property NSString *mid;
/*消息创建时间 不能为空*/
@property NSString *createdDate;
/*消息内容 不能为空*/
@property NSString *body;
/*消息是否已读 默认为未读*/
@property NSNumber <RLMBool>*read;
/*属于我们自己操作用的属性，不需要存数据库*/
@property BOOL selected;

@end
RLM_ARRAY_TYPE(RLMMessage)
