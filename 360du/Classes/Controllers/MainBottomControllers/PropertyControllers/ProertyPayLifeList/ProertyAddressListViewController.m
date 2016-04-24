//
//  ProertyAddressListViewController.m
//  360du
//
//  Created by linghang on 15/11/25.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "ProertyAddressListViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "NSString+URLEncoding.h"
#import "UIView+Toast.h"
#import "ProertyCommunityListModel.h"
#import "ProertyAddAddressViewController.h"
#define PROERTYADDRESSLISTCELL @"proertyAddressListCell"
@interface ProertyAddressListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *sectionArr;
@end

@implementation ProertyAddressListViewController
- (id)initWithCityName:(NSString *)city{
    self = [super init];
    if (self) {
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        self.sectionArr = [NSMutableArray arrayWithCapacity:0];
        [self loadData:city];
        [self makeNav];
    }
    return self;
}
- (void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"小区列表";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)loadData:(NSString *)cityName{
    [self makeHUd];
    if (cityName.length == 0) {
        cityName = @"北京市";
    }
    
    //NSString *url1 = [NSString stringWithFormat:PROERTYCOMMITLIST,cityName];

    NSString *url = [NSString stringWithFormat:PROERTYCOMMITLIST,[[cityName urlEncodeString] urlEncodeString]];
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl: url andFinishBlock:^(id getResult) {
        NSLog(@"getResult:%@",getResult);
        [self hudWasHidden:self.hudProgress];
        if ([getResult[@"code"] isEqual:@"000000"]) {
            for (NSInteger i = 0; i < [getResult[@"datas"] count]; i++) {
                ProertyCommunityListModel *listModel = [[ProertyCommunityListModel alloc] initWithDictionary:getResult[@"datas"][i]];
                [self.sectionArr addObject:listModel];
                NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
                for (NSInteger j = 0; j < [listModel.xqitem count]; j++) {
                    ProertyCommunityListDetailModel *detailModel = [[ProertyCommunityListDetailModel alloc] initWithDictionary:listModel.xqitem[j]];
                    [tempArr addObject:detailModel];
                }
                [self.dataArr addObject:tempArr];
            }
            [self makeCommonMerch];
        }else{
            [self.view makeToast:@"由于网络原因,请重新加载数据"];
 
        }
    }];
}
//商品
-(void)makeCommonMerch{
    [self makeScoreView];
    [self makeTableView];
}
//左边滑动
-(void)makeScoreView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 100 * self.numSingleVesion, HEIGHT_CONTROLLER - 64)];
    scrollView.contentSize = CGSizeMake(100 * self.numSingleVesion, 39 * self.numSingleVesion * self.sectionArr.count);
    //scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    //self.scrollView = scrollView;
    scrollView.showsVerticalScrollIndicator = NO;
    for (NSInteger i = 0; i < self.sectionArr.count; i++) {
        UIButton *scrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        scrBtn.frame = CGRectMake(0, 39 * self.numSingleVesion * i, 100 * self.numSingleVesion, 39 * self.numSingleVesion);
        ProertyCommunityListModel *model = self.sectionArr[i];
        [scrBtn setTitle:model.wyName forState:UIControlStateNormal];
        [scrBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [scrBtn addTarget:self action:@selector(scrBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:scrBtn];
        scrBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        scrBtn.titleLabel.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
        scrBtn.tag = 1400 + i;
        if (i == 0) {
            [scrBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }
}
-(void)scrBtnDown:(UIButton *)scrBtn{
    for (NSInteger i = 0; i < self.sectionArr.count; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:1400 + i];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    //[self.tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:scrBtn.tag - 1400] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    //    NSIndexPath *first = [NSIndexPath indexPathForRow:0 inSection:scrBtn.tag - 1400];
    //    [self.tableView selectRowAtIndexPath:first animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    //self.tableView.contentOffset = CGPointMake(0, (scrBtn.tag - 1400) * 119 * self.numSingleVesion);
#warning message
    NSLog(@"%f",self.tableView.contentOffset.y);
    [scrBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}
//右边Table
-(void)makeTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(100 * self.numSingleVesion, 64 , WIDTH_CONTROLLER - 100 * self.numSingleVesion, HEIGHT_CONTROLLER - 64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:PROERTYADDRESSLISTCELL];
    [self.view addSubview:tableView];
    self.tableView = tableView;

}
#pragma mark tableViewd的协议代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40 * self.numSingleVesion;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 39 * self.numSingleVesion;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    ProertyCommunityListModel *model = self.sectionArr[section];
    return model.wyName;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PROERTYADDRESSLISTCELL forIndexPath:indexPath];
    ProertyCommunityListDetailModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.textLabel.text = model.xqname;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = SMSColor(151, 151, 151);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProertyCommunityListDetailModel *model = self.dataArr[indexPath.section][indexPath.row];
    ProertyCommunityListModel *listModel = self.sectionArr[indexPath.section];
    if ([self.target isKindOfClass:[ProertyAddAddressViewController class]]) {
        [self.target returnCommitutyId:listModel andRegionId:model];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark 滑动时，改变左边的按钮颜色
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    UITableView *tableView = (UITableView *)scrollView;
    //NSIndexPath path =
    if ([self.tableView isEqual:tableView]) {
        NSInteger num = [self displayLeftScrollViewColor:self.tableView.contentOffset.y];
        for (NSInteger i = 0; i < self.sectionArr.count; i++) {
            UIButton *btn = (UIButton *)[self.view viewWithTag:1400 + i];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        UIButton *scrBtn = (UIButton *)[self.view viewWithTag:1400 + num];
        [scrBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //    UITableView *tableView = (UITableView *)scrollView;
    //    //NSIndexPath path =
    //    if ([self.tableView isEqual:tableView]) {
    //        NSInteger num = [self displayLeftScrollViewColor:self.tableView.contentOffset.y];
    //        for (NSInteger i = 0; i < self.sectionArr.count; i++) {
    //            UIButton *btn = (UIButton *)[self.view viewWithTag:1400 + i];
    //            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //        }
    //        UIButton *scrBtn = (UIButton *)[self.view viewWithTag:1400 + num];
    //        [scrBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //
    //    }
    
#warning message
    // NSLog(@"%ld",[self displayLeftScrollViewColor:<#(CGFloat)#>]);
    
#warning message
    //NSLog(@"%@",self.tableView.indexPathForSelectedRow);
    
    //    self.tableView
    //self.tableView sec
}
#pragma mark 根据右边tableView滚动显示左边的ScrollView
-(NSInteger )displayLeftScrollViewColor:(CGFloat)contentSizeY{
    NSMutableArray *numArr = [NSMutableArray arrayWithCapacity:0];
    NSInteger returnRow = 0;
    CGFloat height = 0;
    for (NSInteger i = 0; i < self.sectionArr.count; i++) {
        
        if (contentSizeY <= height) {
            returnRow = i;
            return returnRow;
        }
        height += 39 * self.numSingleVesion;
        height += 40 * self.numSingleVesion * [self.dataArr[i] count];
        [numArr addObject:[NSString stringWithFormat:@"%f",height]];
        
    }
    return returnRow;
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
