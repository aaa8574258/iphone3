//
//  PropertyNoticeViewController.m
//  360du
//
//  Created by linghang on 15/7/18.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "PropertyNoticeViewController.h"
#import "PropertyNoticeModel.h"
#import "StoreageMessage.h"
#import "ProertyNoticeDeatilViewController.h"
#import "MJRefresh.h"
#import "MJRefreshHeaderView.h"
#import "MJRefreshBaseView.h"
#define PROERTYNOTICECELL @"proertyNoticeCell"
@interface PropertyNoticeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    MJRefreshHeaderView *_header;
    MJRefreshBaseView *_baseView;
    
}
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,assign)NSInteger page;
@property (nonatomic ,assign) NSInteger LastPage;
@end

@implementation PropertyNoticeViewController
-(id)init{
    self = [super init];
    if (self) {
        [self makeNav];
        [self loadDataWithPage:1];
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{

    [self makeTab];

//    [self makeRefrish];

}

-(void)makeRefrish{
    _header = [MJRefreshHeaderView header];
    [self.tableView addFooterWithTarget:self action:@selector(addFooter1)];
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.tableView.footerRefreshingText = @"正在加载，请稍后";
    [self.tableView addHeaderWithTarget:self action:@selector(addHeader1)];
    self.tableView.headerRefreshingText = @"正在帮你刷新";
}

- (void)addHeader1{
    
    __unsafe_unretained typeof(self) vc = self;
    [vc.tableView addHeaderWithCallback:^{
        vc.page = 1;
        [self loadDataWithPage:1];

    }];
}
- (void)addFooter1
{
    if (self.page < self.LastPage) {
        self.page ++;
    }else{
        self.page = self.LastPage;
    }
//    self.page++;
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [vc.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [vc loadDataWithPage:self.page];
    }];
}



-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"物业公告";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor blackColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
}
-(void)loadDataWithPage:(NSInteger )page{
    [self makeHUd];
    AFNetworkTwoPackaging *twoPage = [[AFNetworkTwoPackaging alloc] init];
    [twoPage getUrl:[NSString stringWithFormat:PROERTYNOTICE,[StoreageMessage getCommuntityId],@"1000",[NSString stringWithFormat:@"%ld",(long)page]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",[NSString stringWithFormat:PROERTYNOTICE,[StoreageMessage getCommuntityId],@"1000",[NSString stringWithFormat:@"%ld",(long)page]]);
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        NSLog(@"%@",getResult);
        [self hudWasHidden:self.hudProgress];
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        if ([getResult[@"totalRows"] integerValue] % 10 != 0) {
            self.LastPage = [getResult[@"totalRows"] integerValue] / 10 + 1;
        }else{
            self.LastPage = [getResult[@"totalRows"] integerValue] / 10;
        }
        NSLog(@"%ld",(long)self.LastPage);
        for (id temp in getResult[@"datas"]) {
            PropertyNoticeModel *model = [[PropertyNoticeModel alloc] initWithDictionary:temp];
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
    }];
}
-(void)makeTab{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:PROERTYNOTICECELL];
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
#pragma mark tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70 * self.numSingleVesion;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PROERTYNOTICECELL forIndexPath:indexPath];
    [cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indexPath];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    PropertyNoticeModel *model = self.dataArr[indexPath.row];
    cell.textLabel.text = model.anTitle;
    [cell.textLabel sizeToFit];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"发布时间:%@",model.anTime];
//    cell.detailTextLabel.numberOfLines =2;
    cell.textLabel.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
    cell.textLabel.numberOfLines = 0;
    [cell sizeToFit];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12 * self.numSingleVesion];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PropertyNoticeModel *model = self.dataArr[indexPath.row];
    ProertyNoticeDeatilViewController *controller = [[ProertyNoticeDeatilViewController alloc] initWithTittle:model.anTitle andDetial:model.anContent andTime:model.anTime];
    [self.navigationController pushViewController:controller animated:YES];
    
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
