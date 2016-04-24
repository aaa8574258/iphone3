//
//  PropertyListViewController.m
//  360du
//
//  Created by linghang on 15/7/18.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "PropertyListViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "PropertyListModel.h"
#import "UIImageView+WebCache.h"
#import "ProertyMendSeverViewController.h"
#import "PropertyNoticeViewController.h"
#import "ProertyTelViewController.h"
#import "ProertyPayViewController.h"
#import "ProertyPayViewController.h"
#import "ProertyWaterReaderViewController.h"
@interface PropertyListViewController ()<MBProgressHUDDelegate>{
    AFHTTPRequestOperationManager *_rom;
}

@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation PropertyListViewController
-(id)init{
    self = [super init];
    if (self) {
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        
        [self loadData];
        
        //[self makeUI];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self makeNav];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
-(void)loadData{
    [self makeHUd];
    _rom = [AFHTTPRequestOperationManager manager];
    _rom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",nil];
    //NSString *url = [NSString stringWithFormat:STUDY_CATEGORY_ITEM,self.categoryId,22];
    _rom.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    _rom.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [_rom GET:PROERTYLIST parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *tempArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        for (id temp in tempArr) {
            PropertyListModel *model = [[PropertyListModel alloc] initWithDictionary:temp];
            [self.dataArr addObject:model];
            [self makeUI];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       // [[NSURLCache sharedURLCache] removeAllCachedResponses];
        NSLog(@"%@",[error description]);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        return ;
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
    lable.text = @"物业";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
}
-(void)makeUI{
    CGFloat height = 100 * self.numSingleVesion;
    CGFloat intervalHeight = 90 * self.numSingleVesion;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64)];
    imgView.image = [UIImage imageNamed:@"course_class_bg.jpg"];
    imgView.userInteractionEnabled = YES;
    [self.view addSubview:imgView];
    
    UIScrollView *scrView = [[UIScrollView alloc] initWithFrame:imgView.bounds];
    [imgView addSubview:scrView];
    scrView.contentSize = CGSizeMake(WIDTH_CONTROLLER, height * self.dataArr.count + 100 * self.numSingleVesion);
    
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        UIView *imgViewScr = [[UIView alloc] initWithFrame:CGRectMake(25 * self.numSingleVesion, 100 * self.numSingleVesion + height  * i, (WIDTH_CONTROLLER - 50 * self.numSingleVesion), intervalHeight)];
        imgViewScr.layer.cornerRadius = intervalHeight / 2;
        [scrView addSubview:imgViewScr];
        imgViewScr.layer.borderWidth = 1 * self.numSingleVesion;
        imgViewScr.layer.borderColor = [SMSColor(221, 221, 221) CGColor];
        imgViewScr.backgroundColor = SMSColor(225, 225, 225);
//        UIImage *searchImg = [UIImage imageNamed:@"course_serach"];
//        CGFloat imgWidth =  WIDTH_CONTROLLER - 50 * self.numSingleVesion;
//        CGFloat imgHeight = searchImg.size.width / imgWidth * searchImg.size.height;
//        CGFloat intervalHeight = imgHeight - 10 * self.numSingleVesion;
//
//        UIImageView *imgViewScr = [[UIImageView alloc] initWithFrame:CGRectMake(25 * self.numSingleVesion, 100 * self.numSingleVesion + imgHeight  * i, (WIDTH_CONTROLLER - 50 * self.numSingleVesion), intervalHeight)];
//        [scrView addSubview:imgViewScr];
//        imgViewScr.image = [UIImage imageNamed:@"course_serach"];
//        imgViewScr.userInteractionEnabled = YES;
//        
        
        PropertyListModel *model = self.dataArr[i];
        UIImageView *cicreImg = [[UIImageView alloc] initWithFrame:CGRectMake(25 * self.numSingleVesion, (intervalHeight - 45 * self.numSingleVesion) / 2, 45 * self.numSingleVesion, 45 * self.numSingleVesion)];
        [cicreImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"001"]];
        [imgViewScr addSubview:cicreImg];
       
        
        //名称
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectZero];
        nameLab.font = [UIFont systemFontOfSize:15];
        nameLab.textColor = [UIColor blackColor];
        nameLab.text = model.name;
        [nameLab sizeToFit];
        [imgViewScr addSubview:nameLab];
        nameLab.center = CGPointMake(65 * self.numSingleVesion + 5 * self.numSingleVesion + nameLab.frame.size.width / 2 + 5 * self.numSingleVesion, intervalHeight / 2);
        
        //介绍
        UILabel *descLab = [[UILabel alloc] initWithFrame:CGRectMake(65 * self.numSingleVesion + 5 * self.numSingleVesion + nameLab.frame.size.width + 10 * self.numSingleVesion, intervalHeight / 2 - 20 * self.numSingleVesion, imgViewScr.frame.size.width - (65 * self.numSingleVesion + 5 * self.numSingleVesion + nameLab.frame.size.width + 10 * self.numSingleVesion + 5 * self.numSingleVesion), 40 * self.numSingleVesion)];
        descLab.text = model.desc;
        descLab.font = [UIFont systemFontOfSize:13];
        [imgViewScr addSubview:descLab];
        descLab.numberOfLines = 2;
        
        
        
        
        UIButton *cicreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cicreBtn.frame = imgViewScr.bounds;
        [cicreBtn addTarget:self action:@selector(cicreBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        cicreBtn.tag = 1400 + i;
        [imgViewScr addSubview:cicreBtn];
    }
}
-(void)cicreBtnDown:(UIButton *)cireBtn{
    BaseViewController *ctrl = nil;
    if (cireBtn.tag <= 1401) {
        ctrl = [[ProertyMendSeverViewController alloc] initWithClassId:cireBtn.tag - 1400];
    }else if (cireBtn.tag == 1402){
        ctrl = [[PropertyNoticeViewController alloc] init];
    }else if(cireBtn.tag == 1403){
        ctrl = [[ProertyTelViewController alloc] init];
    }else if (cireBtn.tag == 1404){
        ctrl = [[ProertyPayViewController alloc] initWithClassId:cireBtn.tag - 1400];
    }else if (cireBtn.tag == 1405){
        ctrl = [[ProertyWaterReaderViewController alloc] initWithNibName:@"ProertyWaterReader" bundle:nil];
    }
    [self.navigationController pushViewController:ctrl animated:YES];
}
#pragma mark hud的代理
//加载图片
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

#pragma mark HUD的代理方法,关闭HUD时执行
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
