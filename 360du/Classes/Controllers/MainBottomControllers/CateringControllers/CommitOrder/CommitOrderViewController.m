//
//  CommitOrderViewController.m
//  360du
//
//  Created by linghang on 15/7/11.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "CommitOrderViewController.h"
#import "AddAdressViewController.h"
#import "AddresssListCell.h"
#import "FileOperation.h"
#import "AddressModel.h"
#import "StoreageMessage.h"
#import "MJRefresh.h"
#import "BuyFoodCarViewController.h"
#import "ProertyAddMendAndServerViewController.h"
#define ADDRESSLISTCELL @"addressListCell"
@interface CommitOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *addressArr;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)NSInteger page;
@end

@implementation CommitOrderViewController
-(id)initWithAddressArr:(NSArray *)addressArr{
    self = [super init];
    if (self) {
       // self.addressArr = addressArr;
        self.page = 1;
        self.addressArr = [NSMutableArray arrayWithCapacity:0];
        self.addressArr = [addressArr mutableCopy];
        [self makeNav];
        [self makeTable];
    }
    return self;
}
-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"地址列表";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
    
    
    //新增
    UIButton *favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    favoriteBtn.frame = CGRectMake(WIDTH_CONTROLLER - 0 * self.numSingleVesion - 0 * self.numSingleVesion, 5, 30 * self.numSingleVesion, 34);
    [favoriteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [favoriteBtn setTitle:@"新增" forState:UIControlStateNormal];
    favoriteBtn.titleLabel.font = [UIFont systemFontOfSize:15 * self.numSingleVesion];
    [favoriteBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    favoriteBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:favoriteBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)addAddress{
    AddAdressViewController *addAdress = [[AddAdressViewController alloc] initWithAddressArr:@[] andRow:-1 andModel:nil];
    addAdress.target = self;
    [self.navigationController pushViewController:addAdress animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
-(void)makeTable{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70 * self.numSingleVesion, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 70 * self.numSingleVesion) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[AddresssListCell class] forCellReuseIdentifier:ADDRESSLISTCELL];
    self.tableView.showsVerticalScrollIndicator = NO;
    //self.tableView = tableView;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView addFooterWithTarget:self action:@selector(addFooter)];
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.tableView.footerRefreshingText = @"正在加载，请稍后";
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddresssListCell *cell = [tableView dequeueReusableCellWithIdentifier:ADDRESSLISTCELL forIndexPath:indexPath];
//    for (id temp in cell.subviews) {
//        if ([temp isKindOfClass:[UIButton class]]) {
//            [temp removeFromSuperview];
//        }
//    }
    cell.target = self;
    AddressModel *model = self.addressArr[indexPath.row];
    [cell refreshModel:model andRow:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50 * self.numSingleVesion;
}
#pragma mark 删除列表
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [self deleteAddrss:self.addressArr[indexPath.row]];
    [self.addressArr removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressModel *mdoel = self.addressArr[indexPath.row];
    if ([self.target isKindOfClass:[BuyFoodCarViewController class]]) {
        [self.target gainDefaultAddress:mdoel];
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([self.target isKindOfClass:[ProertyAddMendAndServerViewController class]]){
        [self.target retunAddress:mdoel];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)returnRow:(NSInteger)row{
    AddressModel *mdoel = self.addressArr[row];
    AddAdressViewController *addAdress = [[AddAdressViewController alloc] initWithAddressArr:self.addressArr andRow:row andModel:mdoel];
    addAdress.target = self;
    [self.navigationController pushViewController:addAdress animated:YES];
}
-(void)refreshData{
    self.page = 1;
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:ADDRESSLIST,[StoreageMessage getMessage][2],(long)1,(long)5] andFinishBlock:^(id getResult) {
        if ([getResult[@"code"] isEqualToString:@"000001"]) {
            return ;
        }else{
            [self.addressArr removeAllObjects];
            for (NSInteger i = 0;i < [getResult[@"datas"] count];i++) {
                AddressModel *model = [[AddressModel alloc] initWithDictionary:getResult[@"datas"][i]];
                [self.addressArr addObject:model];
            }
            [self.tableView reloadData];
        }
    }];

//    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//    //[FileOperation clearCacheFile:@"address.txt" andPath:@"address" andDocument:cache];
//    BOOL cacheBool = [FileOperation jugeFileExist:@"address.txt" andPath:@"address" andDocument:cache];
//    if (cacheBool) {
//        [self.addressArr removeAllObjects];
//        NSString *tempStr = [FileOperation getCachePathFile:@"address.txt"  andPath:@"address" andDocument:cache];
//        NSArray *tepArr = [NSKeyedUnarchiver unarchiveObjectWithFile:tempStr];
//        for (NSDictionary *temp in tepArr) {
//             *mdoel = [[CommitOrderModel alloc] initWithDictionary:temp];
//            [self.addressArr addObject:mdoel];
//        }
//        [self.tableView reloadData];
//    }
}
- (void)addFooter
{
    self.page++;
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
        [twoPacking getUrl:[NSString stringWithFormat:ADDRESSLIST,[StoreageMessage getMessage][2],vc.page,(long)5] andFinishBlock:^(id getResult) {
            [vc.tableView footerEndRefreshing];
            if ([getResult[@"code"] isEqualToString:@"000001"]) {
                return ;
            }else{
                for (NSInteger i = 0;i < [getResult[@"datas"] count];i++) {
                    AddressModel *model = [[AddressModel alloc] initWithDictionary:getResult[@"datas"][i]];
                    [vc.addressArr addObject:model];
                }
                [vc.tableView reloadData];
            }
        }];

        
    }];
}
//删除地址
- (void)deleteAddrss:(AddressModel *)model{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:DELEGATEADDRESS,[StoreageMessage getMessage][2],model.ID] andFinishBlock:^(id getResult) {
        
    }];
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
