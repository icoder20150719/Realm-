//
//  MessageTableViewController.m
//  RealmDemo
//
//  Created by xiongan on 2017/8/2.
//  Copyright © 2017年 xiongan. All rights reserved.
//

#import "MessageTableViewController.h"
#import "RLMMessage.h"
#import "RPDataBase.h"


@interface MessageTableViewController ()
@property (nonatomic,strong)NSMutableArray *msgs;
@property (nonatomic,strong)RLMNotificationToken *token;
@end

@implementation MessageTableViewController

- (NSMutableArray *)msgs {
    if (!_msgs) {
        _msgs = [NSMutableArray array];
    }
    return _msgs;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //去掉空的cell
    self.tableView.tableFooterView = [UIView new];
    
    //模拟消息来了，实际项目中，消息一般走socket长连接发过来，此处模拟1秒一个消息过来,消息过来就存数据库保存
    //
    
    [self postMessage];
    
}
/**模拟收到一条消息*/
- (void)postMessage {
    NSDictionary *bodys = @{@(0):@"小明在不",
                            @(1):@"小明今天天气不错呀",
                            @(2):@"是的妮",
                            @(3):@"出来逛街不",
                            @(4):@"好呀好呀",
                            @(5):@"逛完街吃饭去",
                            @(6):@"ok"};
    int mid = CFAbsoluteTimeGetCurrent();
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //构建一条消息
    RLMMessage *msg = [[RLMMessage alloc]init];
    msg.mid = [NSString stringWithFormat:@"%d",mid];
    msg.createdDate = [fmt stringFromDate:[NSDate date]];
    msg.body = bodys[@(mid%6)];
    
    RPDataBase *db = [RPDataBase db];
    [db beginWriteTransaction];
    [db addObject:msg];
    [db commitWriteTransaction];
    [self performSelector:@selector(postMessage) withObject:nil afterDelay:1];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    RPDataBase *db = [RPDataBase db];
    __weak typeof (self) wself = self;
    _token = [[RLMMessage allObjectsInRealm:db]addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
        if(!change ||error) {
            return ;
        }
        [wself.msgs addObject:[results lastObject]];
        NSIndexPath *inxp = [NSIndexPath indexPathForRow:wself.msgs.count-1 inSection:0];
        
        [wself.tableView reloadData];
    }];
}
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_token stop];//移除
    _token = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.msgs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    RLMMessage *msg = self.msgs[indexPath.row];
    cell.textLabel.text = msg.createdDate;
    cell.detailTextLabel.text = msg.body;
    
    return cell;
}


@end
