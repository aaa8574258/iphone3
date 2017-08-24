//
//  PartyBuildViewController.m
//  360du
//
//  Created by 利美 on 17/7/16.
//  Copyright © 2017年 wangjian. All rights reserved.
//

#import "PartyBuildViewController.h"
#import "SDCycleScrollView.h"
#import "YBPopupMenu.h"
#import "PartBuildNextViewController.h"
#import "StoreageMessage.h"
#import "PartyBuildListModel.h"
#import "PropertyNoticeModel.h"
#import "PartyBuildDetialViewController.h"
#import "UIView+Toast.h"
@interface PartyBuildViewController ()<UITableViewDelegate,YBPopupMenuDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property(nonatomic,strong)UITableView *tableView2;
@property (nonatomic ,assign) BOOL flag1;
@property (nonatomic ,copy) NSArray *titles;
@property (nonatomic ,copy) NSArray *icons;
@property (nonatomic ,strong) NSMutableArray *mainArr;
@property (nonatomic ,strong) NSMutableArray *mainImgArr;

@end

@implementation PartyBuildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    [self setNavBarImage:@"0.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"back11111.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:@"党建"];

    self.flag1 = YES;
    self.numSingleVesion = [VersionTranlate returnVersionRateAnyIphone:WIDTH_CONTROLLER];
    NSLog(@"%f",self.numSingleVesion);
    [self giveInfo];
    
    
    
    // Do any additional setup after loading the view.
}



-(void)loadDataForCatalog:(NSString *)catalogId{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:PARTYBUILDINFOLIST,catalogId,@"100",@"0"] andFinishBlock:^(id getResult) {
        NSLog(@"%@",[NSString stringWithFormat:PARTYBUILDINFOLIST,catalogId,@"100",@"0"]);
        self.mainArr = [NSMutableArray arrayWithCapacity:0];
        self.mainImgArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in getResult[@"datas"]) {
            NSLog(@"%@",dic);
            PropertyNoticeModel *model  = [[PropertyNoticeModel alloc] initWithDictionary:dic];
            [self.mainArr addObject:model];
            NSArray *imageArr = [self filterImage:dic[@"anContent"]];
            [self.mainImgArr addObject:imageArr];
        }
        
        if (self.mainArr.count == 0) {
            [self.view makeToast:@"暂无内容"];
            
        }
        
        [self makeLB];
        [self makeTable];
        [self.tableView2 reloadData];
    }];


}


-(void)makeTable{
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 200 *self.numSingleVesion +64, WIDTH_CONTENTVIEW, self.view.frame.size.height - 250 *self.numSingleVesion - 64)];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    [self.view addSubview:_tableView2];
}




-(void) makeLastBtn{
    self.DJBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.DJBtn.frame = CGRectMake(0, self.view.frame.size.height - 50*self.numSingleVesion, WIDTH_CONTENTVIEW/2, 50 *self.numSingleVesion);
    [self.DJBtn setTitle:@"党建服务" forState:UIControlStateNormal];
    [self.DJBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:self.DJBtn];
    
    self.QZBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.QZBtn.frame = CGRectMake(WIDTH_CONTENTVIEW/2, self.view.frame.size.height - 50*self.numSingleVesion, WIDTH_CONTENTVIEW/2, 50 *self.numSingleVesion);
    [self.QZBtn setTitle:@"群众服务" forState:UIControlStateNormal];
    [self.QZBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    [self.view addSubview:self.QZBtn];
    
    [self.DJBtn addTarget:self action:@selector(DJAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.QZBtn addTarget:self action:@selector(QZAct:) forControlEvents:UIControlEventTouchUpInside];

}



-(void) makeLB{
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, WIDTH_CONTENTVIEW, 200 *self.numSingleVesion) imageURLStringsGroup:nil];
    cycleScrollView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cycleScrollView2];
    cycleScrollView2.delegate = self;
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    //    cycleScrollView2.delegate = self;
    cycleScrollView2.dotColor = [UIColor clearColor];
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    //       [self.LBSuperView addSubview:cycleScrollView2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //       cycleScrollView2.imageURLStringsGroup = timeArr[@"picturePath"];
        if ([self.mainImgArr[0] count] == 0) {
            
        }else{
            NSArray *arr1 = self.mainImgArr[0];
            cycleScrollView2.imageURLStringsGroup = arr1;
        }
 //       cycleScrollView2.titlesGroup = arr2;
    });
}




-(void)giveInfo{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:PARTYBUILDLIST,[StoreageMessage getCommuntityId],@"0"] andFinishBlock:^(id getResult) {
        NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:0];
        
        for (NSDictionary *dic in getResult[@"datas"]) {
            [arr1 addObject:dic[@"Name"]];
            [arr2 addObject:dic[@"ID"]];
        }
        self.titles = arr1.mutableCopy;
        self.icons = arr2.mutableCopy;
        [self makeLastBtn];
        
        if (self.icons.count != 0) {
            [self loadDataForCatalog:self.icons[0]];
        }
        
        
    }];
    
    
}



//for (NSDictionary *dic in getResult[@"datas"]) {
//    PartyBuildListModel *model = [[PartyBuildListModel alloc] initWithDictionary:dic];
//    [self.dataArr addObject:model];
//}
//
//self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 200 *self.numSingleVesion +64, WIDTH_CONTENTVIEW, self.view.frame.size.height - 250 *self.numSingleVesion - 64)];
//self.tableView2.delegate = self;
//self.tableView2.dataSource = self;
//self.tableView2.backgroundColor = [UIColor redColor];
//[self.view addSubview:_tableView2];


-(void)viewWillAppear:(BOOL)animated{

//    self.DownView.backgroundColor = [UIColor yellowColor];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",self.mainArr.count -1);
    return self.mainArr.count -1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70*self.numSingleVesion;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatryBuildCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PartyBuildCell"];
    }

    PropertyNoticeModel *model = self.mainArr[indexPath.row+1];
    NSLog(@"%@",model.anTitle);
    NSArray *imgs = self.mainImgArr[indexPath.row+1];
    if ([imgs count] != 0) {
    UIImageView *imagev = [[UIImageView alloc] init];
    imagev.frame = CGRectMake(WIDTH_CONTENTVIEW - 40*self.numSingleVesion, 20*self.numSingleVesion, 30*self.numSingleVesion, 30*self.numSingleVesion);
        imagev.backgroundColor = [UIColor whiteColor];
    [imagev sd_setImageWithURL:[NSURL URLWithString:imgs[0]]];
    [cell.contentView addSubview:imagev];
    }
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20*self.numSingleVesion, 20*self.numSingleVesion, WIDTH_CONTENTVIEW - 80*self.numSingleVesion -20*self.numSingleVesion- 20*self.numSingleVesion, 40*self.numSingleVesion)];
    lab.font = [UIFont systemFontOfSize:14];
    lab.text = model.anTitle;
    lab.numberOfLines = 2;
//    lab.backgroundColor = [UIColor cyanColor];
    [cell.contentView addSubview:lab];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(5*self.numSingleVesion, 70*self.numSingleVesion-1*self.numSingleVesion, WIDTH_CONTENTVIEW - 10*self.numSingleVesion, 1*self.numSingleVesion)];
    view1.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:view1];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PropertyNoticeModel *model = self.mainArr[indexPath.row+1];
    PartyBuildDetialViewController *controller = [[PartyBuildDetialViewController alloc] initWithTittle:model.anTitle andDetial:model.anContent andTime:model.anTime];
    [self.navigationController pushViewController:controller animated:YES];
    
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    PropertyNoticeModel *model = self.mainArr[0];
    NSLog(@"%@--%@----%@",model.anTitle,model.anContent,model.anTime);

    PartyBuildDetialViewController *controller = [[PartyBuildDetialViewController alloc] initWithTittle:model.anTitle andDetial:model.anContent andTime:model.anTime];
    [self.navigationController pushViewController:controller animated:YES];
}


-(void)DJAct:(UIButton *)sender{
    if (self.titles.count == 0) {
        [self.view makeToast:@"暂无内容"];
    }
    [YBPopupMenu showRelyOnView:sender titles:self.titles icons:self.icons menuWidth:110*self.numSingleVesion delegate:self];
}

-(void)QZAct:(UIButton *)center{

    
    PartBuildNextViewController *part = [[PartBuildNextViewController alloc] init];
    [self.navigationController pushViewController:part animated:YES];
    
    
}




- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    [self loadDataForCatalog:self.icons[index]];

}






- (NSArray *)filterImage:(NSString *)html
{
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(img|IMG)(.*?)(/>|></img>|>)" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    NSArray *result = [regex matchesInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];
    
    for (NSTextCheckingResult *item in result) {
        NSString *imgHtml = [html substringWithRange:[item rangeAtIndex:0]];
        
        NSArray *tmpArray = nil;
        if ([imgHtml rangeOfString:@"src=\""].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src=\""];
        } else if ([imgHtml rangeOfString:@"src="].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src="];
        }
        
        if (tmpArray.count >= 2) {
            NSString *src = tmpArray[1];
            
            NSUInteger loc = [src rangeOfString:@"\""].location;
            if (loc != NSNotFound) {
                src = [src substringToIndex:loc];
                [resultArray addObject:src];
            }
        }
    }
    
    return resultArray;
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
