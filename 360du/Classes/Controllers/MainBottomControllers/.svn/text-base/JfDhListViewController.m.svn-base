//
//  JfDhListViewController.m
//  360du
//
//  Created by 利美 on 17/3/14.
//  Copyright © 2017年 wangjian. All rights reserved.
//

#import "JfDhListViewController.h"
#import "StoreageMessage.h"
#import "JfDhListTableViewCell.h"
#import "JfDhListModel.h"
#import "JfDhXqViewController.h"
@interface JfDhListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@end

@implementation JfDhListViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self listRequest];

        [self makeTable];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];


    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.title = @"兑换记录";
    MAININTERFACE;
}


-(void) makeTable{
    UITableView *tabeleView = [[UITableView alloc] initWithFrame:self.view.frame];
    tabeleView.delegate = self;
    tabeleView.dataSource = self;
    [self.view addSubview:tabeleView];
    self.tableView = tabeleView;
}

-(void) listRequest{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    NSLog(@"%@",[NSString stringWithFormat:DHJLREQUE,[StoreageMessage getMessage][2],@"1"]);
    [twoPacking getUrl:[NSString stringWithFormat:DHJLREQUE,[StoreageMessage getMessage][2],@"1"] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in getResult[@"datas"]) {
            JfDhListModel *model= [[JfDhListModel alloc] initWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        NSLog(@"%@",self.dataArr);
        [self.tableView reloadData];
    }];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 184 * self.numSingleVesion;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)self.dataArr.count);
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 5, 0)];
    JfDhListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"List_id"];
    if (!cell) {
        cell = [[JfDhListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"List_id"];
    }
    JfDhListModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JfDhListModel *model = self.dataArr[indexPath.row];

    JfDhXqViewController *jfdhxq = [[JfDhXqViewController alloc] init];
    jfdhxq.exchange_id = model.exchange_id;
    [self.navigationController pushViewController:jfdhxq animated:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
