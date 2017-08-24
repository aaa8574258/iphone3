//
//  PartyBuildQZTableViewController.m
//  360du
//
//  Created by 利美 on 17/7/27.
//  Copyright © 2017年 wangjian. All rights reserved.
//

#import "PartyBuildQZTableViewController.h"
#import "PropertyNoticeModel.h"
#import "PartyBuildDetialViewController.h"
@interface PartyBuildQZTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView2;
@property (nonatomic ,strong) NSMutableArray *mainArr;
@property (nonatomic ,strong) NSMutableArray *mainImgArr;
@end

@implementation PartyBuildQZTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}



-(void)viewWillAppear:(BOOL)animated{
    self.tableView2 = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    [self.view addSubview:_tableView2];
    [self loadDataForCatalog:self.catalogId];
}


-(void)loadDataForCatalog:(NSString *)catalogId{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:PARTYBUILDINFOLIST,catalogId,@"100",@"0"] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        self.mainArr = [NSMutableArray arrayWithCapacity:0];
        self.mainImgArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in getResult[@"datas"]) {
            NSLog(@"%@",dic);
            PropertyNoticeModel *model  = [[PropertyNoticeModel alloc] initWithDictionary:dic];
            [self.mainArr addObject:model];
            NSArray *imageArr = [self filterImage:dic[@"anContent"]];
            [self.mainImgArr addObject:imageArr];
        }

        [self.tableView2 reloadData];
    }];
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",self.mainArr.count );
    return self.mainArr.count;
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
    
    PropertyNoticeModel *model = self.mainArr[indexPath.row];
    NSLog(@"%@",model.anTitle);
    NSArray *imgs = self.mainImgArr[indexPath.row];
    if ([imgs count] != 0) {
        UIImageView *imagev = [[UIImageView alloc] init];
        imagev.frame = CGRectMake(WIDTH_CONTENTVIEW - 40*self.numSingleVesion, 20*self.numSingleVesion, 30*self.numSingleVesion, 30*self.numSingleVesion);
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
    PropertyNoticeModel *model = self.mainArr[indexPath.row];
    PartyBuildDetialViewController *controller = [[PartyBuildDetialViewController alloc] initWithTittle:model.anTitle andDetial:model.anContent andTime:model.anTime];
    [self.navigationController pushViewController:controller animated:YES];
    
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
