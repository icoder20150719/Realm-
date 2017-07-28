//
//  Dog.h
//  RealmDemo
//
//  Created by xiongan on 2017/7/26.
//  Copyright © 2017年 xiongan. All rights reserved.
//

#import <Realm/Realm.h>

@interface Dog : RLMObject

@property NSString *name;
@property NSString *color;
@property NSString *identify;

@end

RLM_ARRAY_TYPE(Dog)
