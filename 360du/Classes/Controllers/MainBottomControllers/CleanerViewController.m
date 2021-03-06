//
//  CleanerViewController.m
//  360du
//
//  Created by 利美 on 16/4/21.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "CleanerViewController.h"
#import "CleanerPublishViewController.h"
#import "ViewController.h"
#import "JSDropDownMenu.h"
#import "ChooseViewController.h"
#import "VersionTranlate.h"
#import "ViewController.h"
#import "CleanerInfoTableViewCell.h"
#import "hy_DataDownloadTools.h"
#import "StoreageMessage.h"
#import "DetialViewController.h"
#import "CleanerListModel.h"
#import "StarView.h"
#import "AddrFirstTableViewController.h"
#import "CleanerPublishTwoTableViewController.h"
#import "PaiXTableViewController.h"
#import "SendMessage.h"
#import "LogInViewController.h"
#import "StoreageMessage.h"
#import "NSString+URLEncoding.h"
#import "UIView+Toast.h"
#import "RentViewController.h"
#import "RentPublishViewController.h"
#import "RentListModel.h"
#import "RentListTableViewCell.h"
#import "RentSearchViewController.h"
#import "ZAndHDetialViewController.h"
#import "MJRefresh.h"
#import "MJRefreshHeaderView.h"
#import "MJRefreshBaseView.h"
#import "DRentDetialViewController.h"
@interface CleanerViewController ()<UITableViewDelegate,UITableViewDataSource,popString,sendLeiX,UISearchBarDelegate>{
    MJRefreshHeaderView *_header;
    MJRefreshBaseView *_baseView;

}

@property(nonatomic,strong)MBProgressHUD *hudProgress;
@property(nonatomic,assign)NSInteger page;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chooseSuperViewHeight;

@property (weak, nonatomic) IBOutlet UIView *sView;

@property (weak, nonatomic) IBOutlet UIView *dropDownView;
@property (weak, nonatomic) IBOutlet UITableView *informationTabelView;

@property (weak, nonatomic) IBOutlet UIButton *chooseAddrButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *choosePaiButton;
@property (weak, nonatomic) IBOutlet UIButton *sxBtn;


@property (nonatomic ,copy) NSString *roomCount;
@property (nonatomic ,copy) NSString *money;
@property (nonatomic ,copy) NSString *soure;
@property (nonatomic ,copy) NSString *homeType;
@property (nonatomic ,copy) NSString *floorCount;
@property (nonatomic ,copy) NSString *face;
@property (nonatomic ,copy) NSString *rommateType;
@property (nonatomic ,copy) NSString *keyWord;


@end

@implementation CleanerViewController







-(void)viewWillAppear:(BOOL)animated{
    UIImage* searchBarBg = [self GetImageWithColor:SMSColor(245, 245, 245) andHeight:32.0f];
    //设置背景图片
    [_searchBar setBackgroundImage:searchBarBg];
    //设置背景色
    [_searchBar setBackgroundColor:SMSColor(245, 245, 245)];
    //设置文本框背景
    [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
    self.search = nil;
    self.page = 1;
    if ([self.target isKindOfClass:[RentViewController class]]) {
        if ([self.tag isEqualToString:@"3"]) {
            [self.sxBtn removeFromSuperview];
            self.chooseSuperViewHeight.constant = WIDTH_CONTENTVIEW;
            self.addrWidth.constant = WIDTH_CONTENTVIEW/3;
            self.typeWidth.constant = WIDTH_CONTENTVIEW/3;
            self.paiWidth.constant = WIDTH_CONTENTVIEW/3;
//            UITapGestureRecognizer *tap=[[ UITapGestureRecognizer alloc ] initWithTarget : self action : @selector (randomColor:)];
//            [self.choosePaiButton addGestureRecognizer :tap];
//            self.choosePaiButton. userInteractionEnabled = YES ;
//            [self.choosePaiButton setBackgroundColor:[UIColor redColor]];
//            [self.choosePaiButton addTarget:self action:@selector(randomColor:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
    
    self.searchBar.delegate = self;
    self.informationTabelView.delegate = self;
    self.informationTabelView.dataSource = self;
    [self makeNv];
    if ([self.target isKindOfClass:[ViewController class]]) {
        [self makeHUd];
        [self searchSomething];
    }
//
    if ([self.target isKindOfClass:[RentViewController class]]) {
        [self makeHUd];
        [self searchRentSomething];
    }
    [self makeRefrish];
}
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

-(void)randomColor:( UITapGestureRecognizer *)gestureRecognizer{
    UniversalViewController *universal = [[UniversalViewController alloc] initWithUrl:@"rentRoomCount"];
    universal.target = self;
    [self.navigationController pushViewController:universal animated:YES];
}

-(void)makeRefrish{
    _header = [MJRefreshHeaderView header];
    [self.informationTabelView addFooterWithTarget:self action:@selector(addFooter1)];
    self.informationTabelView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.informationTabelView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.informationTabelView.footerRefreshingText = @"正在加载，请稍后";
    [self.informationTabelView addHeaderWithTarget:self action:@selector(addHeader1)];
    self.informationTabelView.headerRefreshingText = @"正在帮你刷新";
}

- (void)addHeader1{
        __unsafe_unretained typeof(self) vc = self;
        [vc.informationTabelView addHeaderWithCallback:^{
            vc.page = 1;
            if ([self.target isKindOfClass:[RentViewController class]]) {
            if (_search.length == 0) {
                [vc rentGetInfoFromDic:@{@"qyCode":vc.addrId,@"location":vc.latAndLong,@"houseTypeId":vc.tag,@"apartment":vc.roomCount,@"rent":vc.money,@"soure":vc.soure,@"homeType":vc.homeType,@"floorCount":vc.floorCount,@"face":vc.face,@"roommateType":vc.rommateType,@"gotoPage":[NSString stringWithFormat:@"%ld",vc.page],@"pageSize":@"10"}];
                
            }else{
                [vc rentGetInfoFromDic:@{@"qyCode":vc.addrId,@"location":vc.latAndLong,@"houseTypeId":vc.tag,@"apartment":vc.roomCount,@"rent":vc.money,@"soure":vc.soure,@"homeType":vc.homeType,@"floorCount":vc.floorCount,@"face":self.face,@"roommateType":self.rommateType,@"keyWord":vc.keyWord,@"gotoPage":[NSString stringWithFormat:@"%ld",vc.page],@"pageSize":@"10"}];
            }
            }
            if ([self.target isKindOfClass:[ViewController class]]) {
                [self.informationTabelView headerEndRefreshing];
            }
        }];
}
- (void)addFooter1
{
    
    self.page++;
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.informationTabelView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        if ([self.target isKindOfClass:[ViewController class]]) {
            [self.informationTabelView footerEndRefreshing];
        }
        if ([self.target isKindOfClass:[RentViewController class]]){
        if (_search.length == 0) {
            [vc
             rentGetInfoFromDic:@{@"qyCode":vc.addrId,@"location":vc.latAndLong,@"houseTypeId":vc.tag,@"apartment":vc.roomCount,@"rent":vc.money,@"soure":vc.soure,@"homeType":vc.homeType,@"floorCount":vc.floorCount,@"face":vc.face,@"roommateType":vc.rommateType,@"gotoPage":[NSString stringWithFormat:@"%ld",vc.page],@"pageSize":@"10"}];
            
        }else{
            [vc rentGetInfoFromDic:@{@"qyCode":vc.addrId,@"location":vc.latAndLong,@"houseTypeId":vc.tag,@"apartment":vc.roomCount,@"rent":vc.money,@"soure":vc.soure,@"homeType":vc.homeType,@"floorCount":vc.floorCount,@"face":self.face,@"roommateType":self.rommateType,@"keyWord":vc.keyWord,@"gotoPage":[NSString stringWithFormat:@"%ld",vc.page],@"pageSize":@"10"}];
        }
        }
//        NSLog(@"1212121%@",@{@"qyCode":vc.addrId,@"location":vc.latAndLong,@"houseTypeId":vc.tag,@"apartment":vc.roomCount,@"rent":vc.money,@"soure":vc.soure,@"homeType":vc.homeType,@"floorCount":vc.floorCount,@"face":self.face,@"roommateType":self.rommateType,@"gotoPage":[NSString stringWithFormat:@"%ld",vc.page],@"pageSize":@"10"});
        NSLog(@"%@",vc.tag);
    }];
}








-(void)searchRentSomething{
    if (self.money == nil ) {
        _money = @"0";
        [self.chooseTypeButton setTitle:@"选择租金" forState:UIControlStateNormal];
    }
    if (self.addrId == nil) {
        _addrId = [StoreageMessage getCityId];
        if (_addrId.length == 0) {
            _addrId = @"11000000";
        }
        [self.chooseAddrButton setTitle:@"选择区域" forState:UIControlStateNormal];
    }
    if ([SendMessage shareInstance].singleValue) {
        self.addr = [SendMessage shareInstance].singleValue;
        self.addrId = [SendMessage shareInstance].singleCode;
        [self.chooseAddrButton setTitle:_addr forState:UIControlStateNormal];
    }
    if (self.soure == nil) {
        self.soure =@"0";
    }
    if (self.floorCount == nil) {
        self.floorCount =@"0";
    }
    if (self.homeType == nil) {
        self.homeType = @"0";
    }
    if (self.face == nil) {
        self.face = @"0";
    }
    if (self.rommateType == nil) {
        self.rommateType = @"0";
    }
    if (self.roomCount== nil){
        if ([self.tag isEqualToString:@"3"]) {
            _roomCount = @"0";
            [self.choosePaiButton setTitle:@"选择房屋类型" forState:UIControlStateNormal];
        }else{
            _roomCount = @"0";
            [self.choosePaiButton setTitle:@"选择厅室" forState:UIControlStateNormal];
        }
    }
    if (_search.length == 0) {
        NSLog(@"%@",_addrId);
        [self rentGetInfoFromDic:@{@"qyCode":_addrId,@"location":_latAndLong,@"houseTypeId":self.tag,@"apartment":self.roomCount,@"rent":self.money,@"soure":self.soure,@"homeType":self.homeType,@"floorCount":self.floorCount,@"face":self.face,@"roommateType":self.rommateType,@"gotoPage":@"1",@"pageSize":@"10"}];
    }else{
        [self rentGetInfoFromDic:@{@"qyCode":_addrId,@"location":_latAndLong,@"houseTypeId":self.tag,@"apartment":self.roomCount,@"rent":self.money,@"soure":self.soure,@"homeType":self.homeType,@"floorCount":self.floorCount,@"face":self.face,@"roommateType":self.rommateType,@"keyWord":self.keyWord,@"gotoPage":@"1",@"pageSize":@"10"}];
    }
}







-(void)searchSomething{
    if (self.leiXId == nil ) {
        _leiXId = @"";
        [self.chooseTypeButton setTitle:@"选择类型" forState:UIControlStateNormal];
    }
    if (_addrId == nil) {
        _addrId = [StoreageMessage getCityId];
        if (_addrId.length == 0) {
            _addrId = @"11000000";
        }
        [self.chooseAddrButton setTitle:@"选择区域" forState:UIControlStateNormal];
        
    }
    if ([SendMessage shareInstance].singleValue) {
        self.addr = [SendMessage shareInstance].singleValue;
        self.addrId = [SendMessage shareInstance].singleCode;
        [self.chooseAddrButton setTitle:_addr forState:UIControlStateNormal];
    }
    
    
    if (_PaiXId == nil){
        _PaiXId = @"1";
        [self.choosePaiButton setTitle:@"选择排序方式" forState:UIControlStateNormal];
    }
    if (self.searchBar.text.length == 0) {
        NSLog(@"%@",_addrId);
        NSLog(@"%@,%@,%@,%@,%@",[StoreageMessage getCommuntityId],_addr,_PaiXId,_leiXId,_latAndLong);
        [self getInfoWithURLbody:@{@"xqid":[StoreageMessage getCommuntityId],@"qycode":_addrId,@"sortType":_PaiXId,@"twoType":_leiXId,@"location":_latAndLong,@"gotoPage":@"1"}];
        
    }else{
        [self getInfoWithURLbody:@{@"xqid":[StoreageMessage getCommuntityId],@"qycode":_addrId,@"sortType":_PaiXId,@"twoType":_leiXId,@"keyWord":[_search urlEncodeString],@"location":_latAndLong,@"gotoPage":@"1"}];
    }
}




- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.target isKindOfClass:[RentViewController class]]) {
        if ([self.tag isEqualToString:@"3"]) {
            [self.sxBtn removeFromSuperview];
            self.addrWidth.constant = WIDTH_CONTENTVIEW/3;
            self.typeWidth.constant = WIDTH_CONTENTVIEW/3;
            self.paiWidth.constant = WIDTH_CONTENTVIEW/3;
            [self.choosePaiButton setTitle:@"选择房屋类型" forState:UIControlStateNormal];
        }
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [SendMessage shareInstance].singleValue = nil;
    NSString*string = [StoreageMessage getLatAndLong];
    NSArray *array = [string componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
    self.latAndLong = [NSString stringWithFormat:@"%@,%@",array[0],array[1]];
}


//缓冲
-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}
-(void) myProgressTask{
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        self.hudProgress.progress = progress;
        usleep(50000);
    }
    
}



//选择区域
- (IBAction)chooseAddrAction:(UIButton *)sender {
    if ([self.target isKindOfClass:[ViewController class]]) {
        AddrFirstTableViewController *addrf = [[AddrFirstTableViewController alloc]init];
        [self.navigationController pushViewController:addrf animated:YES];
    }
    if ([self.target isKindOfClass:[RentViewController class]]) {
        AddrFirstTableViewController *addrf = [[AddrFirstTableViewController alloc]init];
        [self.navigationController pushViewController:addrf animated:YES];
    }
}


//选择类型/租金
- (IBAction)chooseTypeAction:(UIButton *)sender {
    if ([self.target isKindOfClass:[ViewController class]]) {
        CleanerPublishTwoTableViewController *two = [[CleanerPublishTwoTableViewController alloc]init];
        two.delegate = self;
        [self.navigationController pushViewController:two animated:YES];
    }
    if ([self.target isKindOfClass:[RentViewController class]]) {
        UniversalViewController *universal = [[UniversalViewController alloc] initWithUrl:@"rentMoneyChoose"];
        universal.target = self;
        [self.navigationController pushViewController:universal animated:YES];
    }
}

-(void) returnchooseAddrbuttonTitle:(NSString *)name andCode:(NSString *)code
{
    [self.chooseTypeButton setTitle:name forState:UIControlStateNormal];
    self.money = code;
}

-(void) returnchoosePaibuttonTitle:(NSString *)name andCode:(NSString *)code
{
    [self.choosePaiButton setTitle:name forState:UIControlStateNormal];
    self.roomCount = code;
}

-(void) returnfwlxWithName:(NSString *)name andcode:(NSString *)code{
    if ([self.tag isEqualToString:@"3"]) {
        [self.choosePaiButton setTitle:name forState:UIControlStateNormal];
        self.homeType = code;
    }else{
    
    [self.choosePaiButton setTitle:name forState:UIControlStateNormal];
    self.roomCount = code;
    }
}



//选择排序方式/厅室
- (IBAction)ChoosePaiAction:(UIButton *)sender {
    if ([self.target isKindOfClass:[ViewController class]]) {
        PaiXTableViewController  *PaiX = [[PaiXTableViewController alloc]init];
        PaiX.LeiXdelegate = self;
        [self.navigationController pushViewController:PaiX animated:YES];
    }
    if ([self.target isKindOfClass:[RentViewController class]]) {
        if ([self.tag isEqualToString:@"3"]) {
            UniversalViewController *universal = [[UniversalViewController alloc] initWithUrl:RENTDZHOMETYPE];
            universal.target = self;
            [self.navigationController pushViewController:universal animated:YES];
        }else{
        
        
        UniversalViewController *universal = [[UniversalViewController alloc] initWithUrl:@"rentRoomCount"];
        universal.target = self;
        [self.navigationController pushViewController:universal animated:YES];
        }
    }
}


-(void) sendLeiX:(NSString *)string andCode:(NSString *)code{
    if ([self.target isKindOfClass:[ViewController class]]) {
        [self.choosePaiButton setTitle:string forState:UIControlStateNormal];
        self.PaiX = string;
        self.PaiXId = code;
    }
}




-(void)popString:(NSString *)String andCode:(NSString *)code{
    [self.chooseTypeButton setTitle:String forState:UIControlStateNormal];
    self.leiXId = code;
    self.leiX = String;
}


-(void)makeNv{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"0.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 30);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(WIDTH_CONTROLLER + 30 , 0,50, 30);
    [rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:39/255.0 blue:77/255.0 alpha:1];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(publishButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightSecondItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightSecondItem;
    
}


-(void)setBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)publishButton{
    if (![StoreageMessage isStoreMessage]) {
        [self.view makeToast:@"请先登录!"];
        LogInViewController *logIn = [[LogInViewController alloc] init];
        [self.navigationController pushViewController:logIn animated:YES];
        return;
    }
    if ([self.target isKindOfClass:[ViewController class]]) {
    
        UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
        CleanerPublishViewController *CPVC = [cleanerSB instantiateViewControllerWithIdentifier:@"cleanerPublish"];
        [self.navigationController showViewController:CPVC sender:nil];
    }else if ([self.target isKindOfClass:[RentViewController class]]){
        UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
        RentPublishViewController *CPVC = [cleanerSB instantiateViewControllerWithIdentifier:@"rentPublish"];
        CPVC.tag = self.tag;
        [self.navigationController pushViewController:CPVC animated:YES];
    
    }
    
}

- (IBAction)chooseButton:(UIButton *)sender {
    if ([self.target isKindOfClass:[ViewController class]]) {
        UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
        ChooseViewController *CPVC = [cleanerSB instantiateViewControllerWithIdentifier:@"cleanerChoose"];
        CPVC.target = self;
        [self.navigationController pushViewController:CPVC animated:YES];
    }
    if ([self.target isKindOfClass:[RentViewController class]]) {
        UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
        RentSearchViewController *CPVC = [cleanerSB instantiateViewControllerWithIdentifier:@"rentSearch"];
        CPVC.taget = self;
        [self.navigationController pushViewController:CPVC animated:YES];
    }
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.target isKindOfClass:[ViewController class]]) {
        return self.listArray.count;
    }
    if ([self.target isKindOfClass:[RentViewController class]]) {
        return self.rentData.count;
    }else{
        return 3;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.target isKindOfClass:[ViewController class]]) {

    CleanerInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
        CleanerListModel *listModel = self.listArray[indexPath.row];
        cell.nameID.text = listModel.name;
        cell.addressLabel.text = listModel.qyname;
//        if (listModel.distinct) {
//            CGFloat f = [listModel.distinct floatValue] / 1000;
            cell.juliLabel.text = @"";
//        }
        if (listModel.logo.length != 0) {
            [cell.nameImage sd_setImageWithURL:[NSURL URLWithString:listModel.logo]];
        }else{
            [cell.nameImage setImage:[UIImage imageNamed:@"无.png"]];
        }
        cell.juliLabel.textColor = [UIColor lightGrayColor];
        cell.juliLabel.font = [UIFont systemFontOfSize:13];
        [cell.telButton setTitle:listModel.mobile forState:UIControlStateNormal];
        [cell.telButton addTarget:self action:@selector(selectorAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.telButton.tag = indexPath.row;
        return cell;
    }else{
        RentListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rentListCell"];
        if (!cell) {
            cell = [[RentListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rentListCell"];
        }
        RentListModel *model = self.rentData[indexPath.row];
        if (model.image == nil) {
            [cell.image setImage:[UIImage imageNamed:@"002"]];
        }
        [cell.image sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"002"]];
        cell.titleLab.text = model.houseName;
        if ([self.tag isEqualToString:@"3"]) {
            
            cell.addLab.text = [NSString stringWithFormat:@"%@-%@",model.qyName,model.xqName];
            cell.moneyLab.text = [NSString stringWithFormat:@"%@元/天",model.rent];

        }else{
            cell.addLab.text = [NSString stringWithFormat:@"%@-%@  %@  %@㎡",model.qyName,model.xqName,model.apartment,model.houseArea];
            cell.moneyLab.text = [NSString stringWithFormat:@"%@元/月",model.rent];

        }
        if (model.distinct) {
            cell.jlLab.text = [NSString stringWithFormat:@"距离:%.2fKm",model.distinct.floatValue / 1000];
        }

        return cell;
    }
}

-(void) selectorAction:(UIButton *)sender{
    CleanerListModel *listModel = self.listArray[sender.tag];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",listModel.mobile]]];
}




//保洁列表
-(void)getInfoWithURLbody:(NSDictionary *)stringBody{
    NSLog(@"%@",stringBody);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
        NSString  *url = [NSString stringWithFormat:CLEANERLIST];
        [manager GET:url parameters:stringBody success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hudWasHidden:self.hudProgress];
            [StoreageMessage getErrorMessage:@"NULL" fromUrl:url];

        NSLog(@"%@",responseObject);
        NSArray *arr = responseObject[@"buzdata"];
        self.listArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in arr) {
            CleanerListModel *listModel = [[CleanerListModel alloc]initWithDictionary:dic];
//            NSLog(@"list:%@",listModel);
            [self.listArray addObject:listModel];
//            NSLog(@"list:%@",self.listArray);
        }
        [self.informationTabelView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hudWasHidden:self.hudProgress];
//        [self.view makeToast:@"你搜索的店铺不存在，请更换搜索条件"];
        NSLog(@"%@",error);
    }];
    
}




//租房条件搜索列表
-(void) rentGetInfoFromDic:(NSDictionary *)dic{
    NSLog(@"%@-%@",RENTSEARCHLIST,dic);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
    NSString  *url = [NSString stringWithFormat:RENTSEARCHLIST];
    [manager GET:url parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hudWasHidden:self.hudProgress];
        [StoreageMessage getErrorMessage:@"NULL" fromUrl:url];

        [self.informationTabelView headerEndRefreshing];
        [self.informationTabelView footerEndRefreshing];
        NSLog(@"21212%@",responseObject);
        self.rentData = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in responseObject[@"datas"]) {
            RentListModel *model = [[RentListModel alloc] initWithDictionary:dic];
            [self.rentData addObject:model];
        }
        [self.informationTabelView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hudWasHidden:self.hudProgress];
        [self.view makeToast:@"你搜索的店铺不存在，请更换搜索条件"];
        NSLog(@"%@",error);
    }];
}








//列表跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.target isKindOfClass:[ViewController class]]) {
        UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
        DetialViewController *detial = [cleanerSB instantiateViewControllerWithIdentifier:@"detial"];
        CleanerListModel *listModel = self.listArray[indexPath.row];
        detial.companyId = listModel.did;
        NSLog(@"%@",listModel.distinct);
        [self.navigationController pushViewController:detial animated:YES];
    }
    if ([self.target isKindOfClass:[RentViewController class]]) {
        if ([self.tag isEqualToString:@"3"]) {
            UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
            DRentDetialViewController *detial = [cleanerSB instantiateViewControllerWithIdentifier:@"DRentDetial"];
            RentListModel *model = self.rentData[indexPath.row];
            NSLog(@"%@",model.memberId);
            detial.houseId = model.houseId;
            [self.navigationController pushViewController:detial animated:YES];
            
        }else{
            UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
            ZAndHDetialViewController *detial = [cleanerSB instantiateViewControllerWithIdentifier:@"ZAndH"];
            RentListModel *model = self.rentData[indexPath.row];
            NSLog(@"%@",model.memberId);

            detial.houseId = model.houseId;
        [self.navigationController pushViewController:detial animated:YES];
        }
    }
}




- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self doSearch:searchBar];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self doSearch:searchBar];
}


- (void)doSearch:(UISearchBar *)searchBar{
    if (searchBar.text.length) {
        _search = searchBar.text;
//         NSLog(@"%@-%@-%@-%@-%@-%@-%@-%@-%@-%@-%@",_addrId,_latAndLong,_tag,_roomCount,_money,_soure,_homeType,_floorCount,_face,_rommateType,[_search urlEncodeString]);
        
        if ([self.target isKindOfClass:[RentViewController class]]) {
            [self rentGetInfoFromDic:@{@"qyCode":_addrId,@"location":_latAndLong,@"houseTypeId":self.tag,@"apartment":self.roomCount,@"rent":self.money,@"soure":self.soure,@"homeType":self.homeType,@"floorCount":self.floorCount,@"face":self.face,@"roommateType":self.rommateType,@"keyWord":[_search urlEncodeString]}];
        }else if ([self.target isKindOfClass:[ViewController class]]) {
            [self getInfoWithURLbody:@{@"xqid":[StoreageMessage getCommuntityId],@"qycode":_addrId,@"sortType":_PaiXId,@"twoType":_leiXId,@"keyWord":[_search urlEncodeString],@"location":[StoreageMessage getLatAndLong]}];
        }
    }else{
        if ([self.target isKindOfClass:[ViewController class]]) {
        [self getInfoWithURLbody:@{@"xqid":[StoreageMessage getCommuntityId],@"qycode":_addrId,@"sortType":_PaiXId,@"twoType":_leiXId,@"location":_latAndLong}];
        }
        if ([self.target isKindOfClass:[RentViewController class]]) {
         [self  rentGetInfoFromDic:@{@"qyCode":_addrId,@"location":_latAndLong,@"houseTypeId":self.tag,@"apartment":self.roomCount,@"rent":self.money,@"soure":self.soure,@"homeType":self.homeType,@"floorCount":self.floorCount,@"face":self.face,@"roommateType":self.rommateType}];
        }
    }
}


-(void)makeHUd{
    self.hudProgress = [[MBProgressHUD alloc] initWithView:self.view];
    self.hudProgress.delegate = self;
    //self.hudProgress.color = [UIColor clearColor];
    self.hudProgress.labelText = @"loading";
    self.hudProgress.dimBackground = YES;
    //self.hudProgress.margin = 80.f;
    //self.hudProgress.yOffset = 150.f;
    [self.view addSubview:self.hudProgress];
    [self.hudProgress showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}



-(void)chooseGetqyCode:(NSString *)qycode andzjcode:(NSString *)zjCode andhxCode:(NSString *)hxCode andlyCode:(NSString *)lyCode andlxCode:(NSString *)lxCode andlcCode:(NSString *)lcCode andcxCode:(NSString *)cxCode andkeyword:(NSString *)keyWord{
    self.addrId = qycode;
    self.money = zjCode;
    self.roomCount = hxCode;
    self.soure = lyCode;
    self.homeType = lxCode;
    self.floorCount = lcCode;
    self.face = cxCode;
    self.keyWord = keyWord;
    NSLog(@"%@-%@-%@-%@-%@-%@-%@-%@-%@-%@-%@",_addrId,_latAndLong,_tag,_roomCount,_money,_soure,_homeType,_floorCount,_face,_rommateType,self.keyWord);
    if (self.keyWord == nil){
    [self rentGetInfoFromDic:@{@"qyCode":_addrId,@"location":_latAndLong,@"houseTypeId":self.tag,@"apartment":self.roomCount,@"rent":self.money,@"soure":self.soure,@"homeType":self.homeType,@"floorCount":self.floorCount,@"face":self.face,@"roommateType":self.rommateType}];
    }
    [self rentGetInfoFromDic:@{@"qyCode":_addrId,@"location":_latAndLong,@"houseTypeId":self.tag,@"apartment":self.roomCount,@"rent":self.money,@"soure":self.soure,@"homeType":self.homeType,@"floorCount":self.floorCount,@"face":self.face,@"roommateType":self.rommateType,@"keyWord":self.keyWord}];
}




-(void) searchIOPWithxqid:(NSString *)xqid andqyCode:(NSString *)qycode andsortType:(NSString *)sortType andTwoType:(NSString *)twoType andlocation:(NSString *)location andkeyWord:(NSString *)keyword{

//    if (self.searchBar.text.length == 0) {
//        [self getInfoWithURLbody:@{@"xqid":[StoreageMessage getCommuntityId],@"qycode":_addrId,@"sortType":_PaiXId,@"twoType":_leiXId,@"location":_latAndLong}];
//        
//    }else{
//        [self getInfoWithURLbody:@{@"xqid":[StoreageMessage getCommuntityId],@"qycode":_addrId,@"sortType":_PaiXId,@"twoType":_leiXId,@"keyWord":[_search urlEncodeString],@"location":_latAndLong}];
//        
//    }
    self.addrId = qycode;
    self.PaiXId = sortType;
    self.leiXId = twoType;
    self.keyWord = keyword;
    if (self.leiXId == nil ) {
        _leiXId = @"15";
        [self.chooseTypeButton setTitle:@"选择类型" forState:UIControlStateNormal];
    }
    if (_addrId == nil) {
        _addrId = @"110000";
        [self.chooseAddrButton setTitle:@"选择区域" forState:UIControlStateNormal];
        
    }
    if ([SendMessage shareInstance].singleValue) {
        self.addr = [SendMessage shareInstance].singleValue;
        self.addrId = [SendMessage shareInstance].singleCode;
        [self.chooseAddrButton setTitle:_addr forState:UIControlStateNormal];
    }
    
    
    if (_PaiXId == nil){
        _PaiXId = @"1";
        [self.choosePaiButton setTitle:@"选择排序方式" forState:UIControlStateNormal];
    }
    NSLog(@"%@",self.keyWord);
    if (self.keyWord.length == 0) {
        [self getInfoWithURLbody:@{@"xqid":[StoreageMessage getCommuntityId],@"qycode":_addrId,@"sortType":_PaiXId,@"twoType":_leiXId,@"location":_latAndLong}];
        
    }else{
        [self getInfoWithURLbody:@{@"xqid":[StoreageMessage getCommuntityId],@"qycode":_addrId,@"sortType":_PaiXId,@"twoType":_leiXId,@"keyWord":[[keyword urlEncodeString] urlEncodeString],@"location":_latAndLong}];
        
    }

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
