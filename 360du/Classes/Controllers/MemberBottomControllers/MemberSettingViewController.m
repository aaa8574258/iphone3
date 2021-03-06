//
//  MemberSettingViewController.m
//  360du
//
//  Created by linghang on 15/7/18.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "MemberSettingViewController.h"
#import "PersonalFeedbackViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "AbountOurViewController.h"
#import "StoreageMessage.h"
#import "MenberViewController.h"

#define MEMBERCELL @"settingCell"
@interface MemberSettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)NSArray *imgArr;
@property(nonatomic,assign)BOOL swithOn;
@end

@implementation MemberSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.swithOn = [StoreageMessage jugeMerchantStoreMessageState];
    [self makeNav];
    [self laodData];
    [self makeTable];
    // Do any additional setup after loading the view.
}
- (void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    //[self setNavTitleItemWithNameAndImage:@"登陆" imageName:@"360.png"];
    [self setNavTitleItemWithName:@"系统设置"];
}
-(void)laodData{
    NSArray *tempArr1 = @[@"订单消息提醒",@"意见反馈"];
    NSArray *tempArr2 = @[@"关于我们",@"400-887-6675",@"退出登录"];
    self.dataArr = @[tempArr1,tempArr2];
    NSArray *imgArr1 = @[@"personal_item2@2x.png",@"personal_item3@2x.png"];
    NSArray *imgArr2 = @[@"personal_item4@2x.png",@"personal_item1@2x.png",@"personal_item6@2x.png"];
    self.imgArr = @[imgArr1,imgArr2];
}
-(void)makeTable{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 )style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MEMBERCELL];
    self.tableView = tableView;
}
#pragma mark tableview的协议代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10 * self.numSingleVesion;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50 * self.numSingleVesion;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 45 * self.numSingleVesion;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MEMBERCELL forIndexPath:indexPath];
           tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.section][indexPath.row]];
    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, cell.contentView.frame.size.height - 1 *self.numSingleVesion, cell.contentView.frame.size.width, 1 * self.numSingleVesion)];
    view1.backgroundColor = SMSColor(245, 245, 245);
    [cell.contentView addSubview:view1];
    
    if (indexPath.section == 0 && indexPath.row < 1) {
        UISwitch *switchOn = [[UISwitch alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER - 40 * self.numSingleVesion, 0, 30 * self.numSingleVesion, 20 * self.numSingleVesion)];
        switchOn.center = CGPointMake(WIDTH_CONTROLLER - 15 * self.numSingleVesion - 30 * self.numSingleVesion, 25 * self.numSingleVesion);
        switchOn.on = self.swithOn;
        [cell.contentView addSubview:switchOn];
        [switchOn addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
        
        
    }
//    else if (indexPath.section == 0 && indexPath.row == 2){
//        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
//        
//        NSString *nowVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
//        
//        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
//        lable.font = [UIFont systemFontOfSize:13];
//        lable.text = nowVersion;
//        lable.textColor = SMSColor(211, 211, 211);
//        [lable sizeToFit];
//        [cell.contentView addSubview:lable];
//        lable.center = CGPointMake(WIDTH_CONTROLLER - 10 * self.numSingleVesion - lable.frame.size.width / 2, 25 * self.numSingleVesion);
        
//    }
    else if (indexPath.section == 1 && indexPath.row == 1){
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
        lable.font = [UIFont systemFontOfSize:13];
        lable.text = @"每天9:00-22:00";
        lable.textColor = SMSColor(211, 211, 211);
        [lable sizeToFit];
        [cell.contentView addSubview:lable];
        lable.center = CGPointMake(WIDTH_CONTROLLER - 10 * self.numSingleVesion - lable.frame.size.width / 2, 25 * self.numSingleVesion);
    }else{
        UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER - 15 * self.numSingleVesion, 0, 11.5 * self.numSingleVesion, 21.5 * self.numSingleVesion)];
        arrowImg.image = [UIImage imageNamed:@"personal_enter@2x.png"];
        [cell.contentView addSubview:arrowImg];
        arrowImg.center = CGPointMake(WIDTH_CONTROLLER - 15 * self.numSingleVesion - 23 * self.numSingleVesion, 25 * self.numSingleVesion);
        arrowImg.clipsToBounds = YES;
    }
    
    
    //cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 1) {
        PersonalFeedbackViewController *personalFeedBack = [[PersonalFeedbackViewController alloc] init];
        [self.navigationController pushViewController:personalFeedBack animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        AbountOurViewController *abountOur = [[AbountOurViewController alloc] init];
        [self.navigationController pushViewController:abountOur animated:YES];
    }else if (indexPath.section == 1 && indexPath.row ==1){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"联系客服" message:@"确定要联系客服吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.delegate = self;
        alertView.tag = 9528;
        [alertView show];
    }else if (indexPath.section == 1 && indexPath.row == 2){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"退出登录" message:@"确定要退出当前账号吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.delegate = self;
        [alertView show];
        alertView.tag = 1000011;
        
    }else if (indexPath.section == 0 && indexPath.row == 2){
//        [self checkUpdate];
    }
}

//- (void)checkUpdate{
//    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
//    NSString *nowVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
//    
//    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
//    NSString *url = @"http://itunes.apple.com/lookup?id=1060289940";
//    @weakify(self);
//    [twoPack getUrl:url andFinishBlock:^(id getResult) {
//        @strongify(self);
//        NSArray *resultArr = [getResult objectForKey:@"results"];
//        if([resultArr count]){
//            NSDictionary *resDict = [resultArr objectAtIndex:0];
//            NSString *newVersion = [resDict objectForKey:@"version"];
//            NSLog(@"%@--%@",newVersion,nowVersion);
//            [StoreageMessage storeValue:newVersion andTeacher:@"versionStr"];
//            if(newVersion.floatValue > nowVersion.floatValue){
//                UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"检测版本更新" message:@"现在有新的版本，是否要更新！"   delegate:self     cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil ];
//                alert.delegate = self;
//                alert.tag = 9527;
//                [alert show];
//            }else{
//                UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"检测版本更新" message:@"已经是最新版本！"   delegate:self     cancelButtonTitle:nil otherButtonTitles:@"确定", nil ];
//                
//                alert.delegate = self;
//                [alert show];
//            }
//        }
//    }];
//    
//    
//}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    NSLog(@"%ld",buttonIndex);
    if (alertView.tag == 1000011) {
        if (buttonIndex == 1) {
            [StoreageMessage clearPersonalLogin];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if (alertView.tag == 9528) {
        if (buttonIndex == 1) {
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.dataArr[1][1]]];
        
        UIWebView *phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];//创建一个webView
        [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];//加载电话url
        [self.view addSubview:phoneCallWebView];
        
        }
    }else if (alertView.tag == 9527) {
        if (buttonIndex == 1) {
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/kuai-kuai-mao/id1060289940?mt=8"];
        [[UIApplication sharedApplication] openURL:url];
        }

    }
}
//推送开关
-(void)switchValueChange:(UISwitch*)switchView
{
    
    //判断是开还是关，是转还是停
    if(switchView.on)
    {
//         [[UIApplication sharedApplication] unregisterForRemoteNotifications];
        [StoreageMessage storePushMessage:YES];
        self.swithOn = YES;
    }
    else
    {
        [StoreageMessage storePushMessage:NO];
        self.swithOn = NO;
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
