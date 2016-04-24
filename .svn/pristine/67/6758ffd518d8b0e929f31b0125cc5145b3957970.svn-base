//
//  ProertyMiddlePayAddressListViewController.m
//  360du
//
//  Created by linghang on 15/11/27.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "ProertyMiddlePayAddressListViewController.h"
#import "ProertyMiddlePayAddressListModel.h"
#import "ProertyMiddlePayLifeTableViewCell.h"
#import "ProertyMiddleWaterViewController.h"
#import "ProertyAddAddressViewController.h"
#import "StoreageMessage.h"
#define PROERTYMIDDLEPAYADDRESSLISTCELL @"proertyMiddelePayAddressListCell"
@interface ProertyMiddlePayAddressListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *addressListArr;
@property(nonatomic,weak)UITableView *tableView;
@end

@implementation ProertyMiddlePayAddressListViewController
- (id)initWithAddressListArr:(NSArray *)addressListArr{
    self = [super init];
    if (self) {
        self.addressListArr = [addressListArr mutableCopy];
        [self makeNav];
        [self makeTable];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
- (void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"我的缴费地址";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(WIDTH_CONTROLLER - 60 * self.numSingleVesion, 5, 50 * self.numSingleVesion, 34 * self.numSingleVesion);
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"新增" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnDown) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}
- (void)rightBtnDown{
    ProertyAddAddressViewController *addAddress = [[ProertyAddAddressViewController alloc] initWithPayAddressListModel:nil];
    addAddress.target = self;
    [self.navigationController pushViewController:addAddress animated:YES];
}
-(void)makeTable{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70 * self.numSingleVesion, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 70 * self.numSingleVesion) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView registerClass:[ProertyMiddlePayLifeTableViewCell class] forCellReuseIdentifier:PROERTYMIDDLEPAYADDRESSLISTCELL];
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
    tableView.tableFooterView = [[UIView alloc] init];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressListArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProertyMiddlePayLifeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PROERTYMIDDLEPAYADDRESSLISTCELL forIndexPath:indexPath];
    //    for (id temp in cell.subviews) {
    //        if ([temp isKindOfClass:[UIButton class]]) {
    //            [temp removeFromSuperview];
    //        }
    //    }
    cell.target = self;
    ProertyMiddlePayAddressListModel *model = self.addressListArr[indexPath.row];
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
    [self deleteAddrss:self.addressListArr[indexPath.row]];
    [self.addressListArr removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProertyMiddlePayAddressListModel *mdoel = self.addressListArr[indexPath.row];
    if ([self.target isKindOfClass:[ProertyMiddleWaterViewController class]]) {
        [self.target gainDefaultAddress:mdoel];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//修改值
-(void)returnRow:(NSInteger)row{
    ProertyMiddlePayAddressListModel *mdoel = self.addressListArr[row];
    ProertyAddAddressViewController *addAddress = [[ProertyAddAddressViewController alloc] initWithPayAddressListModel:mdoel];
    addAddress.target = self;
    [self.navigationController pushViewController:addAddress animated:YES];
//    AddAdressViewController *addAdress = [[AddAdressViewController alloc] initWithAddressArr:self.addressArr andRow:row andModel:mdoel];
//    [self.navigationController pushViewController:addAdress animated:YES];
}
//删除地址
- (void)deleteAddrss:(ProertyMiddlePayAddressListModel *)model{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:PROERTYDELGATEPERSONALINFORMATION,model.hmid] andFinishBlock:^(id getResult) {
        
    }];
}
//添加地址
- (void)addAddress{
    [self.addressListArr removeAllObjects];
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:PROERTYMIDLLEPAYADDRESSLIST,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        if (![getResult[@"code"] isEqual:@"000000"]) {
            return ;
        }
        for (NSInteger i = 0; i < [getResult[@"datas"] count]; i++) {
            ProertyMiddlePayAddressListModel *model = [[ProertyMiddlePayAddressListModel alloc] initWithDictionary:getResult[@"datas"][i]];
            [self.addressListArr addObject:model];
        }
        [self.tableView reloadData];
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
