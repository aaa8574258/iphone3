//
//  FixMasterTwoViewController.m
//  360du
//
//  Created by 利美 on 16/12/7.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "FixMasterTwoViewController.h"
#import "ProertyMendAndServiecListCell.h"
#import "PropertyMendAndServiceListModel.h"
#import "ProertyMendDeatilViewController.h"
#import "StoreageMessage.h"
@interface FixMasterTwoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic ,strong) NSArray *imageArr;
@end

@implementation FixMasterTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self makeTable];
    [self loadData:[NSString stringWithFormat:FIXMASTERMAIN,[StoreageMessage getMessage][2],@"2",@"1",@"1000"]];
}


-(void)makeTable{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER, HEIGHT_CONTROLLER)];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView registerClass:[ProertyMendAndServiecListCell class] forCellReuseIdentifier:@"fixMasterCell"];
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
    
    
}

-(void)loadData:(NSString *)url{
    NSLog(@"%@",url);
    [self makeHUd];
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:url andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        [self hudWasHidden:self.hudProgress];
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        //        self.imageArr = getResult[@"datas"][]
        for (NSInteger i = 0; i < [getResult[@"datas"] count]; i++) {
            PropertyMendAndServiceListModel *model = [[PropertyMendAndServiceListModel alloc] initWithDictionary:getResult[@"datas"][i]];
            
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
    }];
}
#pragma mark tableView的协议代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PropertyMendAndServiceListModel *model = self.dataArr[indexPath.row];
    if (model.images.count == 0) {
        return 63 * self.numSingleVesion;
    }
    return 160 * self.numSingleVesion;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProertyMendAndServiecListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fixMasterCell" forIndexPath:indexPath];
    for (id temp in cell.subviews) {
        [temp removeFromSuperview];
    }
    [cell init];
    PropertyMendAndServiceListModel *model = self.dataArr[indexPath.row];
    NSLog(@"%ld",(long)model.images.count);
    [cell makeUI2:model andImageAndVoiceAndVideo:model.images];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PropertyMendAndServiceListModel *model = self.dataArr[indexPath.row];
    //    NSLog(@"%@",model.pbID);
    ProertyMendDeatilViewController *mendDetail = [[ProertyMendDeatilViewController alloc] initWithProertyMendId:model.pbid];
    mendDetail.target = self;
    [self.navigationController pushViewController:mendDetail animated:YES];
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
