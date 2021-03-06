//
//  GroupPurchaseCenterViewController.m
//  360du
//
//  Created by linghang on 15/12/19.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "GroupPurchaseCenterViewController.h"
#import "StoreageMessage.h"
#import "GroupPurchaseCenterTableViewCell.h"
#import "AFNetworkTwoPackaging.h"
#import "GroupPurchaseModel.h"
#import "UIView+Toast.h"
#import "GroupPurchaseModel.h"
#import "TranlateTime.h"
#import "GroupRobGoodsViewController.h"
#import "GroupRobGoodsDetialViewController.h"
#define GROUPPURCHASECENTERTABCELL  @"groupPurchaseCenterTabCell"
#import "GroupCollectionViewCell.h"
#import "MJRefreshHeaderView.h"
#import "MJRefreshBaseView.h"
#import "MJRefresh.h"
//#define GROUPFIRSTCOLLECTIONCELL @""

@interface GroupPurchaseCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    MJRefreshHeaderView *_header;
    MJRefreshBaseView *_baseView;
    
}
@property(nonatomic,assign)NSInteger page;
@property ( nonatomic,copy) NSString *allCount;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,weak)UIView *headView;
@property (nonatomic ,weak) UICollectionView *collection;
@property (nonatomic ,assign) BOOL isRefre;

@end

@implementation GroupPurchaseCenterViewController







- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"%@",self.Id);
    self.isRefre = YES;
    self.page = 1;
    //    [self loadData];
    //    [self makeHUd];
    //    [self newDataload];
    //    []
    [self setNavBarImage:@"0.png"];
    //[self setBackgroud:@"lantiao x.png"];
    //    [self setBackImageStateName:@"back11111.png" AndHighlightedName:@""];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 30);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    UILabel *lable = [[UILabel alloc] init];
    lable.text = @"村味汇";
    lable.font = [UIFont systemFontOfSize:18 * self.numSingleVesion];
    [lable sizeToFit];
    lable.textColor = [UIColor blackColor];
    lable.center = CGPointMake(lable.frame.size.width / 2, lable.bounds.size.height);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width , 44);
    self.navigationItem.titleView = view;
    
    UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 10 * self.numSingleVesion, 40 * self.numSingleVesion)];
    leftLab.backgroundColor = SMSColor(230, 26, 27);
    [self.view addSubview:leftLab];
    //goodsName
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 10* self.numSingleVesion, 40)];
    nameLab.textColor = SMSColor(151, 151, 151);
    nameLab.text = @"精美商品疯狂抢购中,再不抢就没了!";
    nameLab.backgroundColor = [UIColor whiteColor];
    nameLab.font = [UIFont systemFontOfSize:15];
    //    [nameLab sizeToFit];
    nameLab.center = CGPointMake(10 * self.numSingleVesion + nameLab.frame.size.width / 2, 64 + 20 * self.numSingleVesion);
    [self.view addSubview:nameLab];
    [self makeCollection];
    [self makeRefrish];
    self.dataArr = [NSMutableArray arrayWithCapacity:0];

    [self newDataloadWithPage:@"1"];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [self makeNav];
    //    [self makeTable];
    //    [self loadData];
    // Do any additional setup after loading the view.
}


-(void)makeNav{
    [self setNavBarImage:@"0.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"back11111.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:@"村味汇"];
}
//- (void)loadData{
//    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
//    NSLog(@"url:%@",[NSString stringWithFormat:GROUPPURCHASECENTER,[StoreageMessage getCommuntityId]]);
//    [twoPack getUrl:[NSString stringWithFormat:GROUPPURCHASECENTER,[StoreageMessage getCommuntityId]] andFinishBlock:^(id getResult) {
//        NSLog(@"%@",getResult);
////        [self hudWasHidden:self.hudProgress];
//        if ([getResult[@"code"] isEqual:@"000000"]) {
//            [self.dataArr removeAllObjects];
//            for (id temp in getResult[@"datas"]) {
//                GroupPurchaseModel *model = [[GroupPurchaseModel alloc] initWithDictionary:temp];
//                [self.dataArr addObject:model];
//            }
//
//            [self.tableView reloadData];
//        }else{
//            [self.view makeToast:getResult[@"message"]];
//        }
//    }];
//}

-(void) newDataloadWithPage:(NSString *) page{
    //    NSLog(@"：：：：948750928347598237450982734598273409582734095872340958724309857349572349857：：：：%@",page);
    //    if (page.integerValue >= 1) {
    //    self.collection.contentOffset = CGPointMake(0, 0);
    //    NSLog(@"%@",self.dicParams[@"cpid"]);
    NSString *cpid ;
    //    NSLog(@"12121212%@",self.dicParams);
    //    if (self.dicParams == nil) {
    cpid = [StoreageMessage getCommuntityId];
    //    }else{
    //        cpid = self.dicParams[@"cpid"];
    //    }
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
//    NSLog(@"url:%@",[NSString stringWithFormat:GROUPLISTNEW,[StoreageMessage getCommuntityId],page]);
    [twoPack getUrl:[NSString stringWithFormat:GROUPLISTNEW,cpid,self.Id,page] andFinishBlock:^(id getResult) {
        
        NSLog(@"%@",getResult);
        //        [self hudWasHidden:self.hudProgress];
        self.allCount = getResult[@"totalRows"];
        
        if ([getResult[@"code"] isEqual:@"000000"]) {
            //            [self.dataArr removeAllObjects];
            for (id temp in getResult[@"datas"]) {
                NSLog(@"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa%@",temp);
                GroupPurchaseModel *model = [[GroupPurchaseModel alloc] initWithDictionary:temp];
                [self.dataArr addObject:model];
            }
            
            self.isRefre = YES;
            [self.collection reloadData];
        }else{
            [self.view makeToast:getResult[@"message"]];
        }
    }];
    //    }
    
    
}


//- (void)makeTable{
//    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 0 * self.numSingleVesion, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64) style:UITableViewStyleGrouped];
//    tableView.dataSource = self;
//    tableView.delegate = self;
//    [self.view addSubview:tableView];
//    tableView.showsVerticalScrollIndicator = NO;
//    self.tableView = tableView;
//
//}


-(void)makeCollection{
    NSLog(@"%f",self.numSingleVesion);
    //创建布局文件
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置Item的大小
    layout.itemSize = CGSizeMake(180 *self.numSingleVesion , 291 *self.numSingleVesion);
    //设置边距大小
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    //设置滑动的方向  默认是竖向的滑动
    //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置最小行间距
    layout.minimumLineSpacing = 10;
    //设置最小列间距  不好用
    //这里的行和列的意义是和滚动方向相关的 滚动方向不同 行与列代表的意义不同
    layout.minimumInteritemSpacing = 0;
    
    
    //指定代理
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, WIDTH_CONTROLLER, HEIGHT_CONTROLLER ) collectionViewLayout:layout];
    collection.dataSource = self;
    collection.delegate = self;
    
    //注册UICollectionViewCell
    //    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell_id"];
    [collection registerClass:[GroupCollectionViewCell class] forCellWithReuseIdentifier:@"cell_id"];
    collection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collection];
    self.collection = collection;
    self.collection.backgroundColor = SMSColor(235, 235, 235);
    //    UICollectionView *view = [UICollectionView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>) collectionViewLayout:<#(nonnull UICollectionViewLayout *)#>
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

//制定有多少个section
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 2;
//}

//初始化cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GroupCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_id" forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor redColor];
    cell.backgroundColor = [UIColor whiteColor];
    if (self.dataArr.count != 0) {
        [self.collection headerEndRefreshing];
        [self.collection footerEndRefreshing];
        
        NSLog(@"%@",self.dataArr);
        GroupPurchaseModel *model = self.dataArr[indexPath.row];
        //
        //名字
        cell.label.text = model.cpname;
        //图片
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.cppicture]];
        //现在价格
        cell.money1Lab.text = [NSString stringWithFormat:@"￥%0.2f",[model.unitPirce floatValue]];
        [cell.money1Lab sizeToFit];
        //    self.nowMoneyLable.frame = CGRectMake(WIDTH_CONTENTVIEW - 10 * self.numSingleVersion - self.nowMoneyLable.frame.size.width, 40 * self.numSingleVersion, self.nowMoneyLable.frame.size.width, 20 * self.numSingleVersion);
        //原先价格
        cell.money2Lab.text = [NSString stringWithFormat:@"%0.2f",[model.marketPrice floatValue]];
        
        [cell.money2Lab sizeToFit];
        cell.money1Lab.textColor = SMSColor(51,51,51);
        cell.money2Lab.textColor = [UIColor lightGrayColor];
        //    self.beforeMoneyLable.frame = CGRectMake(WIDTH_CONTENTVIEW - 10 * self.numSingleVersion - self.beforeMoneyLable.frame.size.width, 40 * self.numSingleVersion + 30 * self.numSingleVersion, self.beforeMoneyLable.frame.size.width, 20 * self.numSingleVersion);
        
        //    //横线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, cell.money2Lab.frame.size.height/2, cell.money2Lab.frame.size.width , 1)];
        //    lineView.center = CGPointMake(cell.money2Lab.frame.origin.x/2, cell.money2Lab.frame.origin.y/2);
        lineView.backgroundColor = SMSColor(150,150,150);
        [cell.money2Lab addSubview:lineView];
        //    self.lineMoney.frame = CGRectMake(WIDTH_CONTENTVIEW - 10 * self.numSingleVersion - self.beforeMoneyLable.frame.size.width, 40 * self.numSingleVersion + 30 * self.numSingleVersion + 8 * self.numSingleVersion, self.beforeMoneyLable.frame.size.width, 1 * self.numSingleVersion);
        //    self.lineMoney.backgroundColor = SMSColor(150,150,150);
        //    self.lineMoney.center = CGPointMake(WIDTH_CONTENTVIEW - 10 * self.numSingleVersion - self.beforeMoneyLable.frame.size.width / 2, 40 * self.numSingleVersion + 30 * self.numSingleVersion + 10 * self.numSingleVersion);
        //    //剩下
        //    self.surplusCountLab.text = [NSString stringWithFormat:@"仅剩:%ld件",(model.topLimit.integerValue - model.nowCount.integerValue)];
        //    [self.surplusCountLab sizeToFit];
        //    self.surplusCountLab.frame = CGRectMake(WIDTH_CONTENTVIEW - 10 * self.numSingleVersion - self.surplusCountLab.frame.size.width, 40 * self.numSingleVersion + 30 * self.numSingleVersion + 25 * self.numSingleVersion + 40 * self.numSingleVersion + 10 * self.numSingleVersion, self.surplusCountLab.frame.size.width, 20 * self.numSingleVersion);
    }else{
        return cell;
    }
    return cell;
}

//指定每一个Item的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //    if (indexPath.row%2) {
    return CGSizeMake(180 * self.numSingleVesion, 291 *self.numSingleVesion);
    //    }else
    //        return CGSizeMake(120, 120);
    
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GroupPurchaseModel *model = self.dataArr[indexPath.row];
    
    UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    GroupRobGoodsDetialViewController *robGoods = [cleanerSB instantiateViewControllerWithIdentifier:@"RobDetial"];
    //    cleanerViewController.target = self;
    //    [self.navigationController pushViewController:cleanerViewController animated:YES];    GroupRobGoodsDetialViewController *robGoods = [[GroupRobGoodsDetialViewController alloc] initWithModel:model];;
    robGoods.model = model;
    [self.navigationController pushViewController:robGoods animated:YES];
}





//- (NSInteger)tableView:(UITableView *)tableView
// numberOfRowsInSection:(NSInteger)section{
//    return self.dataArr.count;
//    //return 20;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    GroupPurchaseCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GROUPPURCHASECENTERTABCELL];
//    if (!cell) {
//        cell = [[GroupPurchaseCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GROUPPURCHASECENTERTABCELL];
//
//    }
//    GroupPurchaseModel *model = self.dataArr[indexPath.row];
//    cell.model = model;
//    cell.time = model.stopTime;
//
//    return cell;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 220 * self.numSingleVesion;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 40 * self.numSingleVesion;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0,0, WIDTH_CONTROLLER, 40 * self.numSingleVesion)];
//      headView.backgroundColor = SMSColor(241, 241, 241);
////    headView.backgroundColor = [UIColor redColor];
////    [self.view addSubview:headView];
////    self.headView = headView;
//    //底线
////    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 39 * self.numSingleVesion, WIDTH_CONTROLLER, 1 * self.numSingleVesion)];
////    lineLab.backgroundColor = SMSColor(151, 151, 151);
////    [headView addSubview:lineLab];
//    //左边红色
//    UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10 * self.numSingleVesion, 40 * self.numSingleVesion)];
//    leftLab.backgroundColor = SMSColor(230, 26, 27);
//    [headView addSubview:leftLab];
//    //goodsName
//    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectZero];
//    nameLab.textColor = SMSColor(151, 151, 151);
//    nameLab.text = @"精美商品疯狂抢购中,再不抢就没了";
//    nameLab.font = [UIFont systemFontOfSize:15];
//    [nameLab sizeToFit];
//    nameLab.center = CGPointMake(15 * self.numSingleVesion + nameLab.frame.size.width / 2, 20 * self.numSingleVesion);
//    [headView addSubview:nameLab];
//    return headView;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    GroupPurchaseModel *model = self.dataArr[indexPath.row];
//
//    UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    GroupRobGoodsDetialViewController *robGoods = [cleanerSB instantiateViewControllerWithIdentifier:@"RobDetial"];
//    robGoods.model = model;
//    [self.navigationController pushViewController:robGoods animated:YES];
//}

-(void)makeRefrish{
    _header = [MJRefreshHeaderView header];
    NSLog(@"%ld--%ld",self.page * 8,self.allCount.integerValue);
    
    
    [self.collection addFooterWithTarget:self action:@selector(addFooter1)];
    self.collection.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.collection.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.collection.footerRefreshingText = @"正在加载，请稍后";
    
    [self.collection addHeaderWithTarget:self action:@selector(addHeader1)];
    self.collection.headerRefreshingText = @"正在帮你刷新";
}

- (void)addHeader1{
    //    CGPoint *point1 = CGPointMake(0, 0);
    //    if (self.collection.contentOffset != CGPointMake(0, 0)) {
    //
    //    }
    //    __unsafe_unretained typeof(self) vc = self;
    //    [vc.collection addHeaderWithCallback:^{
    //    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    //        vc.page = 1;
    if (self.isRefre) {
        self.isRefre = NO;
        //        [self makeHUd];
        self.page = 1;
        [self.dataArr removeAllObjects];
        [self newDataloadWithPage:@"1"];
        
    }
    
    //    }];
}
- (void)addFooter1
{
    NSLog(@"%ld--%@",(long)self.page,self.allCount);
    if ((self.page - 1) * 8 < self.allCount.integerValue) {
        //        self.page ++;
        
        //    NSLog(@"%ld---%@",(long)self.page,self.allCount);
        //    if ([self.allCount integerValue] < (self.page ) * 8) {
        //        [self.collection footerEndRefreshing];
        //        return;
        //    }else{
        //        if (self.page * 8 < self.allCount.integerValue) {
        self.page++;
        __unsafe_unretained typeof(self) vc = self;
        // 添加上拉刷新尾部控件
        //        [self.collection addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        NSLog(@"%ld",(long)self.page);
        
        [vc newDataloadWithPage:[NSString stringWithFormat:@"%ld",(long)vc.page]];
        //        }];
    }else{
        NSLog(@"%ld",(long)self.page);
        [self.view makeToast:@"暂无更多数据..."];
        [self.collection footerEndRefreshing];
    }
    //        }else{
    //            [self.collection footerEndRefreshing];
    //        }
    //    }
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
