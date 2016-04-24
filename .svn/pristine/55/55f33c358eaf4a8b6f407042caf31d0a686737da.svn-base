//
//  LocationCommunityViewController.m
//  360du
//
//  Created by linghang on 15-4-11.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "LocationCommunityViewController.h"
#import "LocationModel.h"
#import "AlphabetSort.h"
#import "SelectCityViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "ViewController.h"
#import "MJRefresh.h"
#import "NSString+URLEncoding.h"
#import "SelectCityModel.h"
#import "StoreageMessage.h"
#import "UIView+Toast.h"
#define COMMUNITYLOCATIONCELL @"communityLocationCell"
#define COMMUNITYSEARCHCELL @"communitySearchCell"
@interface LocationCommunityViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UILabel *lineLable;
@property(nonatomic,assign)CGFloat allHieght;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,weak)UITableView *searchTableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *communtityArr;
@property(nonatomic,strong)NSMutableArray *nearArr;
@property(nonatomic,strong)NSMutableArray *alapterArr;
@property(nonatomic,strong)NSMutableArray *tempAlapter;
@property(nonatomic,strong)NSArray *searchArr;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)BOOL nearCommintity;
@property(nonatomic,assign)BOOL cityCommitity;
@property(nonatomic,assign)NSInteger size;
@property(nonatomic,weak)UILabel *cityLab;
@property(nonatomic,copy)NSString *tempCityName;
@property(nonatomic,assign)NSInteger localPage;
@property(nonatomic,weak)UIButton *selectBtn;
@property(nonatomic,assign)NSInteger selectType;
@end

@implementation LocationCommunityViewController
-(id)init{
    self = [super init];
    if (self) {
        self.selectType = 0;
        self.page = 1;
        self.localPage = 1;
        self.size = 5;
        self.nearCommintity = NO;
        self.cityCommitity = NO;
        self.tempCityName = [StoreageMessage getCity];
        [self makeInit];
        [self loadData];
        [self makeUI];
        [self makeHUd];

    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self makeNav];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //[self makeNav];
    // Do any additional setup after loading the view.
}
-(void)makeInit{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.communtityArr = [NSMutableArray arrayWithCapacity:0];
    self.nearArr = [NSMutableArray arrayWithCapacity:0];
    self.alapterArr = [NSMutableArray arrayWithCapacity:0];
    self.tempAlapter = [NSMutableArray arrayWithCapacity:0];
    for (int i = 'A'; i <= 'Z' ; i++) {
        [self.alapterArr addObject:[NSString stringWithFormat:@"%c",i]];
    }
    self.tempAlapter = [self.alapterArr mutableCopy];
}
-(void)loadData{
    [self.tempAlapter removeAllObjects];
    self.tempAlapter = [self.alapterArr mutableCopy];
    self.page = 1;
      NSMutableArray *tempCom = [NSMutableArray arrayWithCapacity:0];
    AFNetworkTwoPackaging *twoPageing = [[AFNetworkTwoPackaging alloc] init];
    //http://211.152.8.99/360duang/serviceServlet?serviceName=findmap&medthodName=xqlist&cityName=北京市&location=116.459776,39.869331&gotoPage=1& pageSize=4
    NSString *cityName = [StoreageMessage getCity];
    [twoPageing getUrl:[NSString stringWithFormat:COMMUNITYDATA,[cityName urlEncodeString],[StoreageMessage getLatAndLong],self.page,self.size] andFinishBlock:^(id getResult) {
        [self.tableView headerEndRefreshing];
        [self hudWasHidden:self.hudProgress];
        for (NSDictionary *temp in getResult[@"buzdata"]) {
            LocationModel *model = [[LocationModel alloc] initWithDictionary:temp];
            [tempCom addObject:model];
        }
        [self.dataArr removeAllObjects];
        [self.communtityArr removeAllObjects];
        self.communtityArr =  [[AlphabetSort returnSortArr:tempCom] mutableCopy];
        self.dataArr = [self.communtityArr mutableCopy];
        
        
        for (NSInteger i = 0; i < self.dataArr.count; i++) {
            if ([self.dataArr[i] count] == 0) {
                [self.dataArr removeObjectAtIndex:i];
                [self.tempAlapter removeObjectAtIndex:i];
                i--;
            }
        }
        [self.tableView reloadData];

    }];

    }
//加载本市小区
-(void)loadNearCommuntity{
    self.localPage = 1;
    [self.tempAlapter removeAllObjects];
    self.tempAlapter = [self.alapterArr mutableCopy];
    AFNetworkTwoPackaging *twoPageing = [[AFNetworkTwoPackaging alloc] init];
    NSString *cityName = [StoreageMessage getCity];
    [twoPageing getUrl:[NSString stringWithFormat:COMMUNITYDATA,[cityName urlEncodeString],@"",self.localPage,self.size] andFinishBlock:^(id getResult) {
        [self.tableView headerEndRefreshing];
        [self hudWasHidden:self.hudProgress];
        NSMutableArray *temNear = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *temp in getResult[@"buzdata"]) {
            LocationModel *model = [[LocationModel alloc] initWithDictionary:temp];
            [temNear addObject:model];
        }
    
        [self.nearArr removeAllObjects];
        [self.dataArr removeAllObjects];
        self.nearArr = [[AlphabetSort returnSortArr:temNear] mutableCopy];
        self.dataArr = [self.nearArr mutableCopy];
        for (NSInteger i = 0; i < self.dataArr.count; i++) {
            if ([self.dataArr[i] count] == 0) {
                [self.dataArr removeObjectAtIndex:i];
                [self.tempAlapter removeObjectAtIndex:i];
                i--;
            }
        }

        [self.tableView reloadData];
        //#warning message
        
    }];

}

-(void)viewDidAppear:(BOOL)animated{
    
}
-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];


    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = [StoreageMessage getCity];
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    self.cityLab = lable;
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
    
    
    UIButton *pullDown = [UIButton buttonWithType:UIButtonTypeCustom];
    pullDown.frame = CGRectMake(WIDTH_CONTROLLER - 50 * self.numSingleVesion, (44 - 15) / 2, 40 * self.numSingleVesion, 15);
    [pullDown setTitle:@"更换城市" forState:UIControlStateNormal];
    [pullDown addTarget:self action:@selector(navBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [pullDown.titleLabel setTextColor:[UIColor whiteColor]];
    [pullDown.titleLabel sizeToFit];
    pullDown.titleLabel.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    pullDown.tag = 1000;
    pullDown.frame = CGRectMake(WIDTH_CONTROLLER - 5 * self.numSingleVesion - pullDown.titleLabel.frame.size.width, (44 - 15) / 2, pullDown.titleLabel.frame.size.width, 15);
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:pullDown];
    self.navigationItem.rightBarButtonItem = rightBar;
}
-(void)navBtnDown{
    //更换城市
    SelectCityViewController *selectView = [[SelectCityViewController alloc] init];
    selectView.target = self;
    [self.navigationController pushViewController:selectView animated:YES];
    
}
-(void)makeUI{
    [self makeCityName];
    [self makeTable];
}
-(void)makeCityName{
    NSArray *cityArr = @[@"附近小区",@"本市小区"];
    for (NSInteger i = 0; i < cityArr.count; i++) {
        UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cityBtn.frame = CGRectMake(WIDTH_CONTROLLER / 2 * i, 64, WIDTH_CONTROLLER / 2, 40 * self.numSingleVesion);
        [cityBtn setTitle:cityArr[i] forState:UIControlStateNormal];
        [cityBtn addTarget:self action:@selector(cityDown:) forControlEvents:UIControlEventTouchUpInside];
        cityBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
//        if(i == 0){
//            [cityBtn setTitleColor:COMMUNITYNAMECOLOR forState:UIControlStateNormal];
//        }else{
            [cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        }
        cityBtn.tag = 1400 + i;
        [self.view addSubview:cityBtn];
    }
    self.selectBtn = (UIButton *)[self.view viewWithTag:1400];
    UIImageView *tempImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64 + 40 * self.numSingleVesion, WIDTH_CONTROLLER, 2)];
    tempImg.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:tempImg];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + 40 * self.numSingleVesion, WIDTH_CONTROLLER / 2, 2)];
    //lable.backgroundColor = [UIColor colorWithRed:(CGFloat)67 / 255.0 green:(CGFloat)142 / 255.0 blue:(CGFloat)185 / 255.0 alpha:1];
    lable.backgroundColor = [UIColor redColor];
    [self.view addSubview:lable];
    self.lineLable = lable;
    
    [self createSearchOrRemove];
    
    
}
//create搜索框
- (void)createSearchOrRemove{
    CGFloat height = [VersionTranlate returnImageHeightImgname:@"searchkuang.png" andWidth:WIDTH_CONTROLLER - 30 * self.numSingleVesion];
    UIView *tempView = (UIView *)[self.view viewWithTag:10000];
    [tempView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [tempView removeFromSuperview];
    tempView = nil;
    if (self.selectType == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 40 * self.numSingleVesion + 10, WIDTH_CONTROLLER, height)];
        [self.view addSubview:view];
        view.tag = 10000;
        UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(15 * self.numSingleVesion, 0, WIDTH_CONTROLLER - 30 * self.numSingleVesion, height)];
        textView.layer.cornerRadius = height / 2;
        [view addSubview:textView];
        textView.layer.borderColor = [SMSColor(191, 191, 191) CGColor];
        textView.layer.borderWidth = 1 * self.numSingleVesion;
        UIImageView *textImg = [[UIImageView alloc] initWithFrame:CGRectMake(textView.frame.size.width - 15 * self.numSingleVesion - 25 * self.numSingleVesion,(height - 25 * self.numSingleVesion ) / 2 , 25 * self.numSingleVesion, 25 * self.numSingleVesion)];
        textImg.image = [UIImage imageNamed:@"xiaoqu_search.png"];
        textImg.userInteractionEnabled = YES;
        [textView addSubview:textImg];
        
        //    //输入框
        UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(25 * self.numSingleVesion, 0, textView.frame.size.width - 25 * self.numSingleVesion, textView.frame.size.height)];
        text.placeholder = @"请输入小区名或拼音首字母";
        text.clearButtonMode = UITextFieldViewModeAlways;
        text.borderStyle = UITextBorderStyleNone;
        text.delegate = self;
        text.returnKeyType = UIReturnKeyGoogle;
        [textView addSubview:text];
        //目前高度
        self.allHieght = 64 + 40 * self.numSingleVesion + 10 + height + 5 * self.numSingleVesion;
        
    }else{
        self.allHieght = 64 + 40 * self.numSingleVesion + 5 * self.numSingleVesion + 10;
    }
    self.tableView.frame = CGRectMake(0, self.allHieght, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - self.allHieght);
    //[self.tableView reloadData];
}
-(void)cityDown:(UIButton *)cityBtn{
    self.selectType = cityBtn.tag - 1400;
    self.selectBtn = cityBtn;
//    for (NSInteger i = 0; i < 2; i++) {
//        UIButton *btn = (UIButton *)[self.view viewWithTag:1400 + i];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    }
    [self.dataArr removeAllObjects];
    if (cityBtn.tag == 1400) {
        if (self.communtityArr.count == 0) {
            [self makeHUd];
            [self loadData];
        }else{
            self.dataArr = [self.communtityArr mutableCopy];
        }
        
    }else{
        if (self.nearArr.count == 0) {
            [self makeHUd];
            [self loadNearCommuntity];
        }else{
            self.dataArr = [self.nearArr mutableCopy];
        }

    }
    [self.tempAlapter removeAllObjects];
    self.tempAlapter = [self.alapterArr mutableCopy];
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        if ([self.dataArr[i] count] == 0) {
            [self.dataArr removeObjectAtIndex:i];
            [self.tempAlapter removeObjectAtIndex:i];
            i--;
        }
    }

    self.lineLable.frame = CGRectMake(WIDTH_CONTROLLER / 2 * (cityBtn.tag - 1400), 64 + 40 * self.numSingleVesion, WIDTH_CONTROLLER / 2, 2);
    //[cityBtn setTitleColor:COMMUNITYNAMECOLOR forState:UIControlStateNormal];
    [self createSearchOrRemove];
    [self.tableView reloadData];
}
-(void)makeTable{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.allHieght, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - self.allHieght) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:COMMUNITYLOCATIONCELL];
    self.tableView = tableView;
    [self.tableView addFooterWithTarget:self action:@selector(addFooter)];
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.tableView.footerRefreshingText = @"正在加载，请稍后";
    
    
    UITableView *searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.allHieght, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - self.allHieght) style:UITableViewStylePlain];
    searchTableView.showsVerticalScrollIndicator = NO;
    searchTableView.dataSource = self;
    searchTableView.delegate = self;
    [self.view addSubview:searchTableView];
    [searchTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:COMMUNITYSEARCHCELL];
    searchTableView.hidden = YES;
    self.searchTableView = searchTableView;
    
//    [self.searchTableView addFooterWithTarget:self action:@selector(addFooter)];
//    self.searchTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
//    self.searchTableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
//    self.searchTableView.footerRefreshingText = @"正在加载，请稍后";
}
- (void)addFooter
{
    [self.tempAlapter removeAllObjects];
    self.tempAlapter = [self.alapterArr mutableCopy];
    if (self.selectBtn.tag == 1400) {
        self.page++;
    }else{
        self.localPage++;
    }
    
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
        [twoPack getUrl:[NSString stringWithFormat:ORDER,[StoreageMessage getMessage][2],self.page,self.size] andFinishBlock:^(id getResult) {
            [vc.tableView footerEndRefreshing];
            if ([getResult[@"buzdata"] count] == 0) {
                return ;
            }
            if (vc.selectBtn.tag == 1400) {
                NSMutableArray *tempCom = [NSMutableArray arrayWithCapacity:0];
                
                for (NSDictionary *temp in getResult[@"buzdata"]) {
                    LocationModel *model = [[LocationModel alloc] initWithDictionary:temp];
                    [tempCom addObject:model];
                }
                [vc.communtityArr addObjectsFromArray:tempCom];
                NSMutableArray *tempArr =  [[AlphabetSort returnSortArr:vc.communtityArr] mutableCopy];
                vc.dataArr =[tempArr mutableCopy] ;
                
                
                for (NSInteger i = 0; i < self.dataArr.count; i++) {
                    if ([vc.dataArr[i] count] == 0) {
                        [vc.dataArr removeObjectAtIndex:i];
                        [vc.tempAlapter removeObjectAtIndex:i];
                        i--;
                    }
                }

            }else{
                NSMutableArray *temNear = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *temp in getResult[@"buzdata"]) {
                    LocationModel *model = [[LocationModel alloc] initWithDictionary:temp];
                    [temNear addObject:model];
                }
                [vc.nearArr addObjectsFromArray:temNear];
                NSMutableArray *tempArr = [[AlphabetSort returnSortArr:vc.nearArr] mutableCopy];
                vc.dataArr = [tempArr mutableCopy];
                for (NSInteger i = 0; i < self.dataArr.count; i++) {
                    if ([vc.dataArr[i] count] == 0) {
                        [vc.dataArr removeObjectAtIndex:i];
                        [vc.tempAlapter removeObjectAtIndex:i];
                        i--;
                    }
                }

            }
//            for (NSDictionary *temp in getResult[@"datas"]) {
//                LocationModel *model = [[LocationModel alloc] initWithDictionary:temp];
//                [vc.dataArr addObject:model];
//            }
            [vc.tableView reloadData];
        }];
    }];
}
#pragma mark tableview的协议代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
         return [self.dataArr[section] count];
    }else{
        return self.searchArr.count;
    }
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tableView) {
        return self.dataArr.count;
    }
    else{
        return 1;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return self.tempAlapter[section];
    }
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LocationModel *model = nil;
    UITableViewCell *cell = nil;
    if (tableView == self.tableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:COMMUNITYLOCATIONCELL forIndexPath:indexPath];
        model = self.dataArr[indexPath.section][indexPath.row];

    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:COMMUNITYSEARCHCELL forIndexPath:indexPath];
        
        model = self.searchArr[indexPath.row];
    }
    for(UIView *view in [tableView subviews]) {
        if([view respondsToSelector:@selector(setIndexColor:)]) {
            [view performSelector:@selector(setIndexColor:) withObject:[UIColor blackColor]];
        }
    }
    cell.textLabel.text = model.xqname;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    return cell;
}
#pragma mark 数组索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (self.selectType == 0) {
        return nil;
    }
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
    if (self.tableView == tableView) {
        for (int i = 'A'; i <= 'Z' ; i++) {
            [temp addObject:[NSString stringWithFormat:@"%c",i]];
        }
        return temp;
    }
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    if (self.tableView == tableView) {
         return index;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableView == tableView) {
        LocationModel *model = self.dataArr[indexPath.section][indexPath.row];
        if ([self.target isKindOfClass:[ViewController class]]) {
            [self.target returnCommuityId:model];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y < -50) {
        [self.tableView headerBeginRefreshing];
        self.tableView.headerRefreshingText = @"正在刷新";
        //loadData
        if([self.selectBtn.currentTitle isEqual:@"附近小区"]){
            //[self makeHUd];
            [self.tableView addHeaderWithTarget:self action:@selector(loadData)];
        }else{
            //[self makeHUd];
            [self.tableView addHeaderWithTarget:self action:@selector(loadNearCommuntity)];
        }
    }
    if (scrollView.contentOffset.y > scrollView.contentSize.height + 50) {
        //[self.tableView ]
    }
}

#pragma mark textfield的协议代理

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if(textField.text.length == 0){
        self.tableView.hidden = NO;
        self.searchTableView.hidden = YES;
         [self.tableView reloadData];
        return YES;
    }
    NSMutableArray *searchArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        for (NSInteger j = 0; j < [self.dataArr[i] count]; j++) {
            LocationModel *model = self.dataArr[i][j];
            
            if (model.xqname.length >= textField.text.length && model.pyname.length >= textField.text.length) {
                if (IOS8) {
                    if ([model.xqname containsString:textField.text] || [model.pyname containsString:[textField.text uppercaseString]] || [model.pyname containsString:[textField.text lowercaseString]]) {
                        [searchArr addObject:model];
                    }
                }else{
                    NSRange range1 = [model.xqname rangeOfString:textField.text];
                    NSRange range2 = [model.pyname rangeOfString:[textField.text uppercaseString]];
                    NSRange range3 = [model.pyname rangeOfString:[textField.text lowercaseString]];
                    if (range1.location != NSNotFound || range2.location != NSNotFound || range3.location != NSNotFound) {
                        [searchArr addObject:model];
                    }
                }
            }

        }
        
        
        
    }
    self.searchArr = searchArr;
    self.tableView.hidden = YES;
    self.searchTableView.hidden = NO;
    [self.searchTableView reloadData];

    
    return YES;
}
-(void) returnCityName:(SelectCityModel *)cityModel{
    self.cityLab.text = cityModel.name;
    self.page = 1;
    [self.tempAlapter removeAllObjects];
    self.tempAlapter = [self.alapterArr mutableCopy];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:1400 + i];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    self.lineLable.frame = CGRectMake(WIDTH_CONTROLLER / 2 * (1), 64 + 40 * self.numSingleVesion, WIDTH_CONTROLLER / 2, 2);
    UIButton *cityBtn = (UIButton *)[self.view viewWithTag:1400 + 1];
    //[cityBtn setTitleColor:COMMUNITYNAMECOLOR forState:UIControlStateNormal];
    //重新刷新数据
    [self loadSelectCity:cityModel.name];
    
}
//加载选择城市的数据
- (void)loadSelectCity:(NSString *)cityName{
    [self makeHUd];
    AFNetworkTwoPackaging *twoPageing = [[AFNetworkTwoPackaging alloc] init];
    [twoPageing getUrl:[NSString stringWithFormat:COMMUNITYDATA,[cityName urlEncodeString],@"",self.page,self.size] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        NSMutableArray *temNear = [NSMutableArray arrayWithCapacity:0];
        if ([getResult[@"buzdata"] count] == 0) {
            [self.view makeToast:@"该市小区没有数据,请选择其他城市"];
            return ;
        }
        [StoreageMessage storeCity:self.cityLab.text];

        for (NSDictionary *temp in getResult[@"buzdata"]) {
            LocationModel *model = [[LocationModel alloc] initWithDictionary:temp];
            [temNear addObject:model];
        }
        [self.nearArr removeAllObjects];
        [self.nearArr addObjectsFromArray:temNear];
        self.nearArr = [[AlphabetSort returnSortArr:self.nearArr] mutableCopy];
        self.dataArr = [self.nearArr mutableCopy];
        for (NSInteger i = 0; i < self.dataArr.count; i++) {
            if ([self.dataArr[i] count] == 0) {
                [self.dataArr removeObjectAtIndex:i];
                [self.tempAlapter removeObjectAtIndex:i];
                i--;
            }
        }
        
        [self.tableView reloadData];
        //#warning message
        
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
