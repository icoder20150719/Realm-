//
//  ViewController.m
//  RealmDemo
//
//  Created by xiongan on 2017/7/26.
//  Copyright © 2017年 xiongan. All rights reserved.
//

#import "ViewController.h"
#import "BaseUsageTest.h"
#import "DataBase.h"
#import "Person.h"
#import "Dog.h"
#import "RLMOrderService.h"

#define Code_execution_time(...)\
CFAbsoluteTime time = CFAbsoluteTimeGetCurrent(); \
__VA_ARGS__; \
NSLog(@"代码行：%d 执行时间为：%lf s",__LINE__,CFAbsoluteTimeGetCurrent()-time);


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //基本用法
//    [self testAdd];
//    [self testDel];
//    [self testQuery];
    
    
    //项目实战
//    {
//        Code_execution_time([self testSavaOrder1];)
//    }
    
    {
//        Code_execution_time([self testSavaOrder:1000000];)
    }
    
//    {
//        //用主键查询
//        Code_execution_time(RLMOrder *order = [RLMOrderService queryOrderWithOrderNumber:@"1501221933.706494_827227"];)
//        NSLog(@"%@",order);
//    }
    {
        //用where条件查询
        Code_execution_time(RLMOrder *order = [RLMOrderService queryOrderWhere:@"orderNumber = '1501221933.706399_827221'"];)
        NSLog(@"%@",order);
    }

}

-(void)testSavaOrder1 {
    //1、1000订单存储，每个订单一个事务
    for ( int i = 0 ; i<10000; i++) {
        RLMOrder *order = [[RLMOrder alloc]init];
        order.orderNumber =[NSString stringWithFormat:@"%lf_%d",[[NSDate date]timeIntervalSince1970],i];
        int count = (i % 3);
        order.orderStatus = count == 0 ? @"成功":@"失败";
        int amount = 0;
        for ( int j = 1; j <= count + 1; j++) {
            RLMProduct *p = [[RLMProduct alloc]init];
            p.name = [NSString stringWithFormat:@"煎饼果子-%d-%d",i,j];
            int price = i*j;
            amount+= price;
            p.price = [NSString stringWithFormat:@"%@",@(price)];
            [order.orderItems addObject:p];
        }
        order.orderAmount = [NSString stringWithFormat:@"%@",@(amount)];
        [RLMOrderService saveOrder:order];
    }
}

-(void) testSavaOrder:(NSInteger )orderCount {
    //1、1000订单存储，所有订单一个事务
    NSMutableArray *orders = [NSMutableArray array];
    for ( int i = 0 ; i<orderCount; i++) {
        RLMOrder *order = [[RLMOrder alloc]init];
        order.orderNumber =[NSString stringWithFormat:@"%lf_%d",[[NSDate date]timeIntervalSince1970],i];
        int count = (i % 3);
        order.orderStatus = count == 0 ? @"成功":@"失败";
        int amount = 0;
        for ( int j = 1; j <= count + 1; j++) {
            RLMProduct *p = [[RLMProduct alloc]init];
            p.name = [NSString stringWithFormat:@"煎饼果子-%d-%d",i,j];
            int price = i*j;
            amount+= price;
            p.price = [NSString stringWithFormat:@"%@",@(price)];
            [order.orderItems addObject:p];
        }
        order.orderAmount = [NSString stringWithFormat:@"%@",@(amount)];
        [orders addObject:order];
    }
     [RLMOrderService saveOrders:orders];
}


- (void)testDel {
    //获取RLMRealm DB对象
    RLMRealm *db = [DataBase db];
    //查找实体
    RLMResults *res = [Person allObjectsInRealm:db];
    //删除实体
    [db beginWriteTransaction];
    for (int i = 0; i<res.count; i++) {
        Person *p = res[i];
        [db deleteObjects:p.dogs];
    }
    [db deleteObjects:res];
    [db commitWriteTransaction];
}

- (void)testAdd {
    Dog *dog1= [[Dog alloc]init];
    dog1.name = @"阿黄";
    dog1.color = @"黄色";
    dog1.identify = @"001";
    
    
    Dog *dog2= [[Dog alloc]init];
    dog2.name = @"阿黑";
    dog2.color = @"黑色";
    dog2.identify = @"002";
    
    Person *p = [[Person alloc]init];
    p.name = @"小明";
    p.age = @(23);
    p.sex = @"男";
    [p.dogs addObject:dog1];
    [p.dogs addObject:dog2];
    
    //获取RLMRealm DB对象
    RLMRealm *db = [DataBase db];
    //存入数据库
    [db beginWriteTransaction];
    [Person createInRealm:db withValue:p];
    for (int i = 10;i<100;i++){
        
        Dog *dog2= [[Dog alloc]init];
        dog2.name = @"阿黑";
        dog2.color = @"黑色";
        dog2.identify = [NSString stringWithFormat:@"%d",i];
        [Dog createInRealm:db withValue:dog2];
    }
    [db commitWriteTransaction];
}

-(void)testQuery {
    //查出全表数据
    RLMRealm *db = [DataBase db];
    RLMResults *result = [Person allObjectsInRealm:db];
    for (int i = 0; i<result.count; i++) {
        Person *p = result[i];
        NSLog(@"%@",p);
    }
    RLMResults *DogResult = [Dog allObjectsInRealm:db];
    for (int i = 0; i<DogResult.count; i++) {
        Dog *d = DogResult[i];
        NSLog(@"%@",d);
    }
    //通过where查询条件
    RLMResults *resultWhere = [Dog objectsWhere:@"identify = '001'"];
    //通过主键查询
    Dog *dog = [Dog objectForPrimaryKey:@"002"];
    //通过预言查询
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"identify = '002'"];
    RLMResults *resultPredicate =  [[Dog allObjectsInRealm:db] objectsWithPredicate:pre];
    
}


@end
