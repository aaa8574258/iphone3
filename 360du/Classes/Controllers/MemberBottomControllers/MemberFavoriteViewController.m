//
//  MemberFavoriteViewController.m
//  360du
//
//  Created by linghang on 15/7/18.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "MemberFavoriteViewController.h"
#import "NSString+URLEncoding.h"
#import "DetialViewController.h"

#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "MJRefreshHeaderView.h"
#import "MJRefreshBaseView.h"
#import "CommomFoodModel.h"
#import "CommonFoodCell.h"
#import "StoreageMessage.h"
#import "FoodBussinessListCollectionViewController.h"
#define MEMBERFAVORITE @"memberFavoriteCell"
@interface MemberFavoriteViewController ()<UITableViewDataSource,UITableViewDelegate>{
    MJRefreshHeaderView *_header;
    MJRefreshBaseView *_baseView;
    
}
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)AFHTTPSessionManager *rom;
@property(nonatomic,assign)NSInteger pageNum;
@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,strong)NSMutableArray *itemArr;
@property(nonatomic,strong)NSMutableArray *stateArr;
@property ( nonatomic ,copy) NSString *Did;
@end

@implementation MemberFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self makeHUd];
    [self makeInit];
    [self loadData];
    [self makeTable];
    // Do any additional setup after loading the view.
}
-(void)makeInit{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.pageNum = 1;
    self.pageSize = 5;
    self.itemArr = [NSMutableArray arrayWithCapacity:0];
    self.stateArr = [NSMutableArray arrayWithCapacity:0];

    //[self requestHead:3];
}
- (void)viewWillAppear:(BOOL)animated{
    [self makeNav];
}
- (void)makeNav{
//    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian2222.png" AndHighlightedName:@""];
    //[self setNavTitleItemWithNameAndImage:@"登陆" imageName:@"360.png"];
    [self setNavTitleItemWithName:@"收藏"];
}
- (void)loadData{
    //COLLECTPERSONALLIST
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
    manger.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    manger.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    //NSString *url = [NSString stringWithFormat:STUDY_CATEGORY_ITEM,self.categoryId,22];
    NSString *urlStr = [NSString stringWithFormat:COLLECTPERSONALLIST,[StoreageMessage getMessage][2],self.pageNum,self.pageSize];
    // manger.operationQueue addOperation:<#(NSOperation *)#>
    //    @"http://211.152.8.99/360duang/serviceServlet?serviceName=dlshopmag&medthodName=dlshoplist&codename=2&xqid=86420010000004&sort=1&gotoPage=1&pageSize=5"
//    NSLog(@"qweqwefasdf%@",urlStr);
    [manger GET:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [StoreageMessage getErrorMessage:@"NULL" fromUrl:urlStr];

        [self hudWasHidden:self.hudProgress];
//        NSLog(@"111%@",responseObject);
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *backData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        
        NSDictionary *tempStr = [NSJSONSerialization JSONObjectWithData:backData options:NSJSONReadingMutableLeaves error:&error];
        if (error) {
//            NSLog(@"%@",error);
        }
#warning message responseObject
//        NSLog(@"%@",tempStr);
//        NSLog(@"%@",tempStr[@"buzdata"]);
//        NSLog(@"%@",self.dataArr);
        for (NSDictionary *temp in tempStr[@"buzdata"]) {
            CommomFoodModel *model = [[CommomFoodModel alloc] initWithDictionary:temp]
            
            ;
            NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *itemTemp in temp[@"yhdetail"]) {
                CommomDetailFoodModel *detailFood = [[CommomDetailFoodModel alloc] initWithDictionary:itemTemp];
                [itemArr addObject:detailFood];
            }
            [self.itemArr addObject:itemArr];
            [self.dataArr addObject:model];
//            NSLog(@"qweqwefasdf%@",self.dataArr);

        }
        for (NSInteger i = 0; i < self.dataArr.count; i++) {
            [self.stateArr addObject:@"0"];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [self hudWasHidden:self.hudProgress];
//        NSLog(@"%@",[error description]);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        return ;
    }];

}
- (void)makeTable{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerClass:[CommonFoodCell class] forCellReuseIdentifier:MEMBERFAVORITE];
    self.tableView = tableView;
    //上拉下拉刷新
    //实例化header和footer
    _header = [MJRefreshHeaderView header];
    [self.tableView addFooterWithTarget:self action:@selector(addFooter)];
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.tableView.footerRefreshingText = @"正在加载，请稍后";
    [self.tableView addHeaderWithTarget:self action:@selector(addHeader)];
    self.tableView.headerRefreshingText = @"正在帮你刷新";

}
#pragma mark tableview的协议代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}


/**
 *  删除收藏cell

 */
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%@",self.dataArr);
//
//    NSLog(@"%@",self.dataArr);
    
    CommomFoodModel *model = self.dataArr[indexPath.row];

    NSString *url = [NSString stringWithFormat:COLLECTMERCHANT,model.did,[StoreageMessage getMessage][2]];
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",nil];
    manger.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    manger.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manger GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [StoreageMessage getErrorMessage:@"NULL" fromUrl:url];

//        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //            NSString *tempStr =  [str substringFromIndex:1];
        //            NSString *fianlStr = [tempStr substringToIndex:tempStr.length - 1];
//        if ([str isEqual:@"&取消收藏！"]) {
//            NSLog(@"1");
//            [self cancelFavBtnName];
//        }else{
//            NSLog(@"2");
//            [self mendFavBtnName];
//        }
//        [self.view makeToast:str];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //  [[NSURLCache sharedURLCache] removeAllCachedResponses];
        //            NSLog(@"%@",[error description]);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        return ;
    }];
    [self.dataArr removeObjectAtIndex:indexPath.row];

    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommomFoodModel *model = self.dataArr[indexPath.row];
//    if (model.yhdetail.count != 0) {
//        if ([self.stateArr[indexPath.row] isEqualToString:@"0"]) {
//            return 100 * self.numSingleVesion;
//        }else{
//            return model.yhdetail.count * 30 * self.numSingleVesion + 80 * self.numSingleVesion + 5 * self.numSingleVesion;
//        }
//        
//    }
    return 80 * self.numSingleVesion;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%@",self.dataArr);

    CommonFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:MEMBERFAVORITE forIndexPath:indexPath];
//    NSLog(@"qweqwefasdf%@",self.dataArr);
    if (self.dataArr.count != 0) {
        CommomFoodModel *model = self.dataArr[indexPath.row];
//        NSLog(@"%@",model.codename);
        if ([model.codename isEqualToString:@"2"]) {
            
            
        cell.target = self;
        cell.row = indexPath.row;
//        if (model.yhdetail.count != 0) {
//            //self.itemArr
//            cell.privilegeArr = model.yhdetail;
//#warning message
////            NSLog(@"%@",model.yhdetail);
//        }
            
        if([self.stateArr[indexPath.row] isEqualToString:@"1"]){
            cell.privilegeBtnState = YES;
        }else{
            cell.privilegeBtnState = NO;
        }
            
        [cell makeUI];
        [cell refreshUI:model];
            
        }else if ([model.codename isEqualToString:@"5"]){
            [cell makeTheCleanerCellUI];

            cell.leftImg.image = [UIImage imageNamed:@"002"];
            cell.titleLable.text = model.name;
////            cell.priceUsualLable = model.;
//            [cell makeTheCleanerCellUI];
//        cell.titleLable.text = @"2";
        
        }
    }
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CommomFoodModel *model = self.dataArr[indexPath.row];
#warning message
//    NSLog(@"%@",model.did);
    //    FoodMerchantListViewController *merchant = [[FoodMerchantListViewController alloc] initWithId:model.did];
    //    [self.navigationController pushViewController:merchant animated:YES];
    if ([model.codename isEqualToString:@"2"]) {

    FoodBussinessListCollectionViewController *merchant = [[FoodBussinessListCollectionViewController alloc] initWithId:model.did andSendPrice:model.startSendPrice andDistributionPrice:model.sendPrice];
    [self.navigationController pushViewController:merchant animated:YES];
    }else if ([model.codename isEqualToString:@"5"]){
        UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
        
        DetialViewController *detial = [cleanerSB instantiateViewControllerWithIdentifier:@"detial"];
        detial.companyId = model.did;
        [self.navigationController pushViewController:detial animated:YES];

    
    }
}
//加载更多
- (void)addHeader{
    __unsafe_unretained typeof(self) vc = self;
    [vc.tableView addHeaderWithCallback:^{
        vc.pageNum = 1;
        vc.pageSize = 5;
        AFNetworkTwoPackaging *twoPackaging = [[AFNetworkTwoPackaging alloc] init];
        //    "serviceServlet?serviceName=dlshopmag&medthodName=dlshoplist&codename=%@&xqid=%d&sort=%d&gotoPage=%d&pageSize=%d"
        NSString *url = [NSString stringWithFormat:COLLECTPERSONALLIST,[StoreageMessage getMessage][2],self.pageNum,self.pageSize];

        //url = @"http://211.152.8.99/360duang/serviceServlet?serviceName=dlshopmag&medthodName=dlshoplist&codename=2&xqid=86420010000004&sort=1&gotoPage=1&pageSize=5";
        [twoPackaging getUrl:url andFinishBlock:^(id getResult) {
            [vc.tableView headerEndRefreshing];
            [vc hudWasHidden:vc.hudProgress];
            [vc.dataArr removeAllObjects];
            [vc.itemArr removeAllObjects];
            [vc.stateArr removeAllObjects];
            //先清空，后者刷新
            for (NSDictionary *temp in getResult[@"buzdata"]) {
                CommomFoodModel *model = [[CommomFoodModel alloc] initWithDictionary:temp]
                ;
                NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *itemTemp in temp[@"yhdetail"]) {
                    CommomDetailFoodModel *detailFood = [[CommomDetailFoodModel alloc] initWithDictionary:itemTemp];
                    [itemArr addObject:detailFood];
                }
                [vc.itemArr addObject:itemArr];
                [vc.dataArr addObject:model];
            }
            for (NSInteger i = 0; i < self.dataArr.count; i++) {
                [vc.stateArr addObject:@"0"];
            }
            [vc.tableView reloadData];
            
        }];
    }];
}
- (void)addFooter
{
    [self makeHUd];
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [vc.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        self.pageNum++;
        AFNetworkTwoPackaging *twoPackaging = [[AFNetworkTwoPackaging alloc] init];
        //    "serviceServlet?serviceName=dlshopmag&medthodName=dlshoplist&codename=%@&xqid=%d&sort=%d&gotoPage=%d&pageSize=%d"
        NSString *url = [NSString stringWithFormat:COLLECTPERSONALLIST,[StoreageMessage getMessage][2],self.pageNum,self.pageSize];
        [twoPackaging getUrl:url andFinishBlock:^(id getResult) {
            [vc.tableView footerEndRefreshing];
            [vc hudWasHidden:vc.hudProgress];
            if ([getResult[@"buzdata"] count] == 0) {
                return ;
            }
            //先清空，后者刷新
            for (NSDictionary *temp in getResult[@"buzdata"]) {
                CommomFoodModel *model = [[CommomFoodModel alloc] initWithDictionary:temp]
                ;
                NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *itemTemp in temp[@"yhdetail"]) {
                    CommomDetailFoodModel *detailFood = [[CommomDetailFoodModel alloc] initWithDictionary:itemTemp];
                    [itemArr addObject:detailFood];
                }
                [vc.itemArr addObject:itemArr];
                [vc.dataArr addObject:model];
            }
            
            for (NSInteger i = 0; i < [getResult[@"buzdata"] count]; i++) {
                [vc.stateArr addObject:@"0"];
            }
            [vc.tableView reloadData];
            
        }];
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
