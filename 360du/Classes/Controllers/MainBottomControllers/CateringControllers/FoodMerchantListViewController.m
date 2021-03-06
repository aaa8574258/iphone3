//
//  FoodMerchantListViewController.m
//  360du
//
//  Created by linghang on 15/5/16.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "FoodMerchantListViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "FoodMerchatListModel.h"
#import "CommonFoodMerchatListCell.h"
#define FOODMERCHATLISTCELL @"foodMerchatListCell"
@interface FoodMerchantListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSString *memchantId;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *sectionArr;
@end

@implementation FoodMerchantListViewController
-(id)initWithId:(NSString *)merchantId{
    self = [super init];
    if (self) {
        self.memchantId = merchantId;
        [self makeInit];
        [self loadData];
        
        [self makeNav];
        [self makeUI];
    }
    return self;
}
-(void)makeInit{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.sectionArr = [NSMutableArray arrayWithCapacity:0];
}
-(void)loadData{
    NSString *url = @"http://211.152.8.99/360duang/serviceServlet?serviceName=dlshopmag&medthodName=dlsprolist&did=38";
    url = [NSString stringWithFormat:MERCHANTGOODSLIST,self.memchantId];
    AFNetworkTwoPackaging *twoPageing = [[AFNetworkTwoPackaging alloc] init];
    [twoPageing getUrl:url andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        for (NSDictionary *temp in getResult) {
            FoodMerchatListModel *model = [[FoodMerchatListModel alloc] initWithDictionary:temp];
            [self.sectionArr addObject:model];
            NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *tempItem in model.item) {
                FoodMerchatListItemModel *itemModel = [[FoodMerchatListItemModel alloc] initWithDictionary:tempItem];
                [itemArr addObject:itemModel];
                
            }
            [self.dataArr addObject:itemArr];
            
        }
//        for (NSDictionary *temp in getResult) {
//            FoodMerchatListModel *model = [[FoodMerchatListModel alloc] initWithDictionary:temp];
//            [self.sectionArr addObject:model];
//            NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:0];
//            for (NSDictionary *tempItem in model.item) {
//                FoodMerchatListItemModel *itemModel = [[FoodMerchatListItemModel alloc] initWithDictionary:tempItem];
//                [itemArr addObject:itemModel];
//                
//            }
//            [self.dataArr addObject:itemArr];
//            
//        }
        [self.tableView reloadData];
        [self makeScoreView];
    }];
}
-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    //商品、商家、评价
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER / 2 - 90 * self.numSingleVesion, 0, 180 * self.numSingleVesion, 44)];
    NSArray *navArr = @[@"商品",@"商家",@"评价"];
    for (NSInteger i = 0; i < navArr.count; i++) {
        UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        navBtn.frame = CGRectMake(60 * self.numSingleVesion * i, 5, 60 * self.numSingleVesion, 34);
        [navBtn setTitle:navArr[i] forState:UIControlStateNormal];
        navBtn.titleLabel.font = [UIFont systemFontOfSize:15 * self.numSingleVesion];
        [navBtn addTarget:self action:@selector(navBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:navBtn];
        [navBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        navBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        navBtn.tag = 1200 + i;
    }
    navView.center = CGPointMake(WIDTH_CONTROLLER / 2, 22);
    self.navigationItem.titleView = navView;
    //收藏按钮
    UIButton *favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    favoriteBtn.frame = CGRectMake(WIDTH_CONTROLLER - 0 * self.numSingleVesion - 0 * self.numSingleVesion, 5, 44 * self.numSingleVesion, 44);
    [favoriteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[favoriteBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [favoriteBtn setImage:[UIImage imageNamed:@"main_shoucang_n"] forState:UIControlStateNormal];
    //main_shoucang_n
    //[favoriteBtn setImageEdgeInsets:UIEdgeInsetsMake(5 , 7 , 14, 7)];
    //[favoriteBtn setTitleEdgeInsets:UIEdgeInsetsMake(30, 5, 2, 0)];
    favoriteBtn.titleLabel.font = [UIFont systemFontOfSize:15 * self.numSingleVesion];
    [favoriteBtn addTarget:self action:@selector(navBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    favoriteBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    favoriteBtn.tag = 1250;
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:favoriteBtn];
    self.navigationItem.rightBarButtonItem = rightBar;

}
-(void)navBtnDown:(UIButton *)navBtn{
    switch (navBtn.tag) {
        case 1200:{
            
            break;
        }
        case 1201:{
            
            break;
        }
        case 1202:{
            
            break;
        }
        case 1250:{
            
            break;
        }
        default:
            break;
    }
}
-(void)makeUI{
    //[self makeScoreView];
    [self makeTableView];
}
//左边滑动
-(void)makeScoreView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 100 * self.numSingleVesion, HEIGHT_CONTROLLER - 64 * self.numSingleVesion)];
    scrollView.contentSize = CGSizeMake(100 * self.numSingleVesion, 39 * self.numSingleVesion * self.sectionArr.count);
    //scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.showsVerticalScrollIndicator = NO;
    for (NSInteger i = 0; i < self.sectionArr.count; i++) {
        UIButton *scrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        scrBtn.frame = CGRectMake(0, 39 * self.numSingleVesion * i, 100 * self.numSingleVesion, 39 * self.numSingleVesion);
        FoodMerchatListModel *model = self.sectionArr[i];
        [scrBtn setTitle:model.catalog forState:UIControlStateNormal];
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
    [tableView registerClass:[CommonFoodMerchatListCell class] forCellReuseIdentifier:FOODMERCHATLISTCELL];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
#pragma mark tableViewd的协议代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80 * self.numSingleVesion;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 39 * self.numSingleVesion;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    FoodMerchatListModel *model = self.sectionArr[section];
    return model.catalog;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommonFoodMerchatListCell *cell = [tableView dequeueReusableCellWithIdentifier:FOODMERCHATLISTCELL forIndexPath:indexPath];
    FoodMerchatListItemModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
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
        height += 80 * self.numSingleVesion * [self.dataArr[i] count];
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
