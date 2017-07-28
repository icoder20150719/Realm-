//
//  Person.h
//  RealmDemo
//
//  Created by xiongan on 2017/7/26.
//  Copyright © 2017年 xiongan. All rights reserved.
//

#import <Realm/Realm.h>
#import "Dog.h"

@interface Person : RLMObject
/**姓名*/
@property NSString *name ;
/**年龄*/
@property NSNumber <RLMInt>*age ;
/**性别*/
@property NSString *sex ;

@property RLMArray <Dog>*dogs;

@end

RLM_ARRAY_TYPE(Person)
