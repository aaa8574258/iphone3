//
//  JifenNextViewController.m
//  360du
//
//  Created by 利美 on 17/3/13.
//  Copyright © 2017年 wangjian. All rights reserved.
//

#import "JifenNextViewController.h"
#import "SDCycleScrollView.h"
#import "UIButton+WebCache.h"
#import "JfDhDetialViewController.h"
#import "MineJFViewController.h"
#import "JfIconListViewController.h"
#import "JfDhListViewController.h"
#import "StoreageMessage.h"

@interface JifenNextViewController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic ,weak) UIScrollView *Scro;
@property(nonatomic,weak)UIScrollView *mainScr;
@property(nonatomic,assign)CGFloat scrHeight;
@property (nonatomic ,strong) NSArray *midImageArr;
@property (nonatomic ,strong) NSArray *midTitleArr;
@property (nonatomic ,strong) NSArray *midTag;
@property (nonatomic ,strong) NSArray *lbTagArr;
@property (nonatomic ,strong) NSArray *lastTagArr;
@property (nonatomic ,copy) NSString *score;
@end

@implementation JifenNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *Scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, HEIGHT_CONTENTVIEW)];
    Scro.contentSize = CGSizeMake(WIDTH_CONTENTVIEW, 1000);
    Scro.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.view addSubview:Scro];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, 20)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    self.Scro = Scro;
    self.Scro.delegate = self;
    self.title = @"积分商城";
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 30);
    [leftBtn setImage:[UIImage imageNamed:@"叉号@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    [self makeScro];

}



-(void) makeScro{

    
    [self lbNet];
    [self iconNet];
    [self lastNet];
//    [self makeScrollView];
}

- (void)make1TimeScr:(NSInteger)count andTimeArr:(NSArray *)timeArr andTitleArr:(NSArray *)titltArr{
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER, 156 * self.numSingleVesion) imageURLStringsGroup:nil];
    cycleScrollView2.backgroundColor = [UIColor whiteColor];
    [self.Scro addSubview:cycleScrollView2];
    cycleScrollView2.delegate = self;
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    //    cycleScrollView2.delegate = self;
    cycleScrollView2.dotColor = [UIColor whiteColor];
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    //       [self.LBSuperView addSubview:cycleScrollView2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //       cycleScrollView2.imageURLStringsGroup = timeArr[@"picturePath"];
//        self.imageArr = [NSMutableArray arrayWithCapacity:0];
//        NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
//        for (NSInteger i = 0; i < count; i++) {
//            NSLog(@"%ld--%@",count,[NSURL URLWithString:timeArr[i][@"picturePath"]]);
//            [self.imageArr addObject:timeArr[i][@"picturePath"]];
//            [arr1 addObject:timeArr[i][@"description"]];
//        }
        cycleScrollView2.imageURLStringsGroup = timeArr;
        cycleScrollView2.titlesGroup = titltArr;
    });
    
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    JfDhDetialViewController *detial = [[JfDhDetialViewController alloc] init];
    detial.pro_id = self.lbTagArr[index];
    [self.navigationController pushViewController:detial animated:YES];
    
}


-(void) make2Jf{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 156 *self.numSingleVesion, self.view.frame.size.width , 40 *self.numSingleVesion)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.Scro addSubview:view1];
    
    UIView *viewj = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120 * self.numSingleVesion, 30 *self.numSingleVesion)];
    viewj.center = CGPointMake(self.view.frame.size.width/4, view1.frame.size.height/2);
//    viewj.backgroundColor = [UIColor redColor];
    [view1 addSubview:viewj];
    UIImageView *imagej = [[UIImageView alloc] initWithFrame:CGRectMake(10 *self.numSingleVesion, 2 *self.numSingleVesion, 22 *self.numSingleVesion, 25 *self.numSingleVesion)];
    [imagej setImage:[UIImage imageNamed:@"积分@2x.png"]];
    [viewj addSubview:imagej];
    UILabel * labj = [[UILabel alloc] initWithFrame:CGRectMake(42 *self.numSingleVesion, 6 *self.numSingleVesion, 80 *self.numSingleVesion, 25*self.numSingleVesion)];
    labj.text = [NSString stringWithFormat:@"积分 %@",self.score];
    labj.font = [UIFont systemFontOfSize:15 *self.numSingleVesion];
    labj.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    [labj sizeToFit];
    [viewj addSubview:labj];
    viewj.userInteractionEnabled = YES;
    UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvatarView:)];
    [viewj addGestureRecognizer:PrivateLetterTap];
    
    
    UIView *viewd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120 * self.numSingleVesion, 30 *self.numSingleVesion)];
    viewd.center = CGPointMake(self.view.frame.size.width - self.view.frame.size.width/4, view1.frame.size.height/2);
//    viewd.backgroundColor = [UIColor cyanColor];
    [view1 addSubview:viewd];
    
    
    UIImageView *imaged = [[UIImageView alloc] initWithFrame:CGRectMake(10 *self.numSingleVesion, 2 *self.numSingleVesion, 22 *self.numSingleVesion, 25 *self.numSingleVesion)];
    [imaged setImage:[UIImage imageNamed:@"积分兑换记录@2x.png"]];
    [viewd addSubview:imaged];
    UILabel * labd = [[UILabel alloc] initWithFrame:CGRectMake(42 *self.numSingleVesion, 6 *self.numSingleVesion, 80 *self.numSingleVesion, 25*self.numSingleVesion)];
    labd.text = [NSString stringWithFormat:@"兑换记录"];
    labd.font = [UIFont systemFontOfSize:15 *self.numSingleVesion];
    labd.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    [labd sizeToFit];
    [viewd addSubview:labd];
    viewj.userInteractionEnabled = YES;
    UITapGestureRecognizer * PrivateLetterTap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvatarView1:)];
    [viewd addGestureRecognizer:PrivateLetterTap1];
}

- (void)tapAvatarView: (UITapGestureRecognizer *)gesture
{
    MineJFViewController *mine = [[MineJFViewController alloc] init];
    [self.navigationController pushViewController:mine animated:YES];
}

- (void)tapAvatarView1: (UITapGestureRecognizer *)gesture
{
    JfDhListViewController *listViewController = [[JfDhListViewController alloc] init];
    [self.navigationController pushViewController:listViewController animated:YES];
}


-(void) lbNet{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    NSLog(@"%@",[NSString stringWithFormat:LBREQUE,[StoreageMessage getMessage][2]]);
    [twoPacking getUrl:[NSString stringWithFormat:LBREQUE,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        self.score = getResult[@"score"];
        NSLog(@"%@",getResult);
        NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr3 = [NSMutableArray arrayWithCapacity:0];

        for (NSDictionary *dic in getResult[@"datas"]) {
            [arr1 addObject:dic[@"ha_url"]];
            [arr2 addObject:dic[@"hs_Name"]];
            [arr3 addObject:dic[@"pro_id"]];
        }
        self.lbTagArr = arr3.mutableCopy;
        [self make2Jf];

        [self make1TimeScr:arr2.count andTimeArr:arr1.mutableCopy andTitleArr:arr2.mutableCopy];
    }];
}


-(void) iconNet{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:JFICONINTER andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr3 = [NSMutableArray arrayWithCapacity:0];

        for (NSDictionary *dic in getResult[@"datas"]) {
            [arr1 addObject:dic[@"TypeName"]];
            [arr2 addObject:dic[@"ac_id"]];
            [arr3 addObject:dic[@"icon"]];
        }
        self.midImageArr = arr3.mutableCopy;
        self.midTitleArr = arr1.mutableCopy;
        self.midTag = arr2.mutableCopy;
        [self makeScrollView];
    }];
}


-(void)makeScrollView{
    

    
    NSLog(@"%f",self.view.frame.size.width);
    [self.mainScr.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.mainScr = nil;
    CGFloat height = 206 * self.numSingleVesion;
    self.scrHeight = height;
    UIScrollView *mainScr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.scrHeight , self.view.frame.size.width, 190 * self.numSingleVesion)];
    mainScr.backgroundColor = [UIColor whiteColor];
    mainScr.pagingEnabled = YES;
    mainScr.delegate = self;
    mainScr.showsHorizontalScrollIndicator = NO;
    [self.Scro addSubview:mainScr];
    //    CGFloat iconWidth = (WIDTH_CONTROLLER - 10 * self.versionTralate * 3 - 40 * self.versionTralate) / 4;
    //    CGFloat iconHeight = (iconWidth + 20 + 20 * self.versionTralate);
    CGFloat iconWidth;
    CGFloat iconHeight;
    iconWidth = iconHeight = 42 *self.numSingleVesion;
    if (self.midImageArr.count > 8) {
        mainScr.contentSize = CGSizeMake(WIDTH_CONTROLLER * 2, iconHeight * 2 + iconWidth + 20);
        [self makePageContro];
    }else{
        mainScr.contentSize = CGSizeMake(WIDTH_CONTROLLER, iconHeight * 2 + iconWidth + 20);
    }
    for (NSInteger i = 0; i < self.midImageArr.count; i++) {
        //        MainModel *model = self.dataArr[i];
        UILabel *iconTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
        iconTitle.text = _midTitleArr[i];
        iconTitle.font = [UIFont systemFontOfSize:13 * self.numSingleVesion];
        iconTitle.textColor = MAINVIEICONCOLOR;
        [iconTitle sizeToFit];
        [mainScr addSubview:iconTitle];
        iconTitle.center = CGPointMake(26 * self.numSingleVesion + iconWidth / 2 + (iconWidth + 50 * self.numSingleVesion ) * (i % 4), iconWidth +  (iconHeight + 43 * self.numSingleVesion) * (i / 4) + 35 *self.numSingleVesion);
        UIButton *iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        iconBtn.frame = CGRectMake(20 * self.numSingleVesion + (iconWidth + 10 * self.numSingleVesion) * (i % 4) , iconHeight * (i / 2), iconWidth , iconWidth );
        if (i >= 8) {
            iconBtn.center = CGPointMake(26 * self.numSingleVesion + iconWidth / 2 + (iconWidth + 50 * self.numSingleVesion ) * (i % 4) + WIDTH_CONTROLLER, iconWidth / 2 + (iconHeight + 43* self.numSingleVesion) * ((i - 8) / 4) + 20 *self.numSingleVesion);
            iconTitle.center = CGPointMake(26 * self.numSingleVesion + iconWidth / 2 + (iconWidth + 50 * self.numSingleVesion ) * (i % 4) + WIDTH_CONTROLLER, iconWidth +  (iconHeight + 43 * self.numSingleVesion) * ((i - 8) / 4) + 35 * self.numSingleVesion);
            
        }else{
            iconBtn.center = CGPointMake(26 * self.numSingleVesion + iconWidth / 2 + (iconWidth + 50 * self.numSingleVesion ) * (i % 4), iconWidth / 2 +( 43 * self.numSingleVesion +  iconHeight) * (i / 4) + 20 * self.numSingleVesion);
        }
        //MainModel *model = self.dataArr[i];
        [iconBtn sd_setImageWithURL:[NSURL URLWithString:_midImageArr[i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"001.png"]];
        iconBtn.tag = 10086 + i;
        [iconBtn addTarget:self action:@selector(scrBtnDown:) forControlEvents:UIControlEventTouchUpInside];
//        iconBtn.tag = [self.midTag[i] integerValue];
        [mainScr addSubview:iconBtn];
        self.mainScr = mainScr;
    }
    
    
    //    UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, HEIGHT - 49 - 20, WIDTH, 20)];
    //    page.numberOfPages = 2;
    //    page.userInteractionEnabled = NO;
    //    page.tag = 12000;
    //    page.backgroundColor = [UIColor grayColor];
    //    [self.view addSubview:page];
}



-(void) scrBtnDown:(UIButton *)sender{
    JfIconListViewController *iconViewController = [[JfIconListViewController alloc] initWithId:self.midTag[sender.tag - 10086]];
    NSLog(@"%@--%@",self.midTitleArr[sender.tag - 10086],self.midTag[sender.tag - 10086]);
    iconViewController.titleName = self.midTitleArr[sender.tag - 10086];
    iconViewController.ac_id = self.midTag[sender.tag - 10086];
    [self.navigationController pushViewController:iconViewController animated:YES];

}



-(void)makePageContro{
    UIPageControl *pageContro = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 429 * self.numSingleVesion, WIDTH_CONTROLLER, 10 * self.numSingleVesion)];
    pageContro.numberOfPages = 2;
    pageContro.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageContro.currentPageIndicatorTintColor = [UIColor redColor];
    [self.Scro addSubview:pageContro];
    //pageContro.backgroundColor = [UIColor lightGrayColor];
    pageContro.userInteractionEnabled = NO;
    pageContro.tag = 12000;
    if (self.midImageArr.count < 10) {
        [pageContro removeFromSuperview];
    }
    
}

-(void)lastNet{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:LASTREQUE,@"100",@"1"] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
//        for (NSArray *arr in getResult[@"datas"]) {
//            NSLog(@"%@",arr);
//            [self makeLastViewWithArr:arr];
//        }
        for (NSInteger i = 0; i < [getResult[@"datas"] count]; i ++) {
            [self makeLastViewWithArr:getResult[@"datas"][i] andCount:i];

        }
    }];
}



-(void)makeLastViewWithArr:(NSDictionary *)dic andCount:(NSInteger )i{
    
    //pro_id 商品编号  picUrl 商品图片  proName 商品名称  proSource 商品来源  proIntegral 商品积分 是否包邮 1 2   postage 邮费
    //    for (NSInteger i = 0; i < count; i++) {
    //        UIView *view = [UIView alloc] initWithFrame:CGRectMake( WIDTH_CONTENTVIEW/2 * i%2, 450 + (i % 2) * WIDTH_CONTENTVIEW/2, <#CGFloat width#>, <#CGFloat height#>)
    //    }
//    self.Scro.contentSize = CGSizeMake(WIDTH_CONTENTVIEW,430 * self.numSingleVesion+ (count /2) * 136 * self.numSingleVesion );
//    for (NSInteger i = 0; i < count ; i ++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW/2 * (i%2),406 * self.numSingleVesion+ (i /2) * 136 * self.numSingleVesion, WIDTH_CONTENTVIEW/2, 212 * self.numSingleVesion)];
        view.tag = 100086 + [dic[@"pro_id"] integerValue];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap:)];
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:tap];
        view.backgroundColor = [UIColor whiteColor];
        [self.Scro addSubview:view];
    NSLog(@"%@",dic[@"pro_id"]);
        [self  makeViewWithTitle:dic[@"proSource"] andMoney:dic[@"proName"] andJf:dic[@"proIntegral"] andYou:dic[@"postage"] andImageUrl:dic[@"picUrl"] InView:view];
//    }
    
}

-(void) makeViewWithTitle:(NSString *)title andMoney:(NSString *)money andJf:(NSString *)jf andYou:(NSString *)you andImageUrl:(NSString *)image  InView:(UIView *)view{
    UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(15 * self.numSingleVesion,113 * self.numSingleVesion, view.frame.size.width, 30 * self.numSingleVesion)];
    titLab.text = title;
    titLab.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [titLab sizeToFit];
    titLab.font = [UIFont systemFontOfSize:12 *self.numSingleVesion];
    [view addSubview:titLab];
    
    UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(15 * self.numSingleVesion, 113 * self.numSingleVesion + titLab.frame.size.height + 10 *self.numSingleVesion, 168 * self.numSingleVesion, 60 * self.numSingleVesion)];
    moneyLab.text = money;
    moneyLab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    [moneyLab sizeToFit];
    moneyLab.font = [UIFont systemFontOfSize:15 *self.numSingleVesion];
    moneyLab.numberOfLines = 2;
    [view addSubview:moneyLab];
    
    UILabel *jfLab = [[UILabel alloc] initWithFrame:CGRectMake(15 * self.numSingleVesion,moneyLab.frame.origin.y + moneyLab.frame.size.height + 10 * self.numSingleVesion, 168 * self.numSingleVesion, 30 * self.numSingleVesion)];
    jfLab.text = [NSString stringWithFormat:@"%@积分",jf];
    jfLab.textColor = [UIColor colorWithRed:255/255.0 green:122/255.0 blue:63/255.0 alpha:1];
    [jfLab sizeToFit];
    jfLab.font = [UIFont systemFontOfSize:15 *self.numSingleVesion];
    [view addSubview:jfLab];
    
    UILabel *youLab = [[UILabel alloc] initWithFrame:CGRectMake(jfLab.frame.origin.x + jfLab.frame.size.width + 10 * self.numSingleVesion,jfLab.frame.origin.y, view.frame.size.width/2, 30 * self.numSingleVesion)];
    youLab.text = [NSString stringWithFormat:@" %@包邮",you];
    youLab.textColor = [UIColor colorWithRed:255/255.0 green:122/255.0 blue:63/255.0 alpha:1];
    [youLab sizeToFit];
    youLab.font = [UIFont systemFontOfSize:11 *self.numSingleVesion];
    youLab.textAlignment = NSTextAlignmentCenter;
    youLab.layer.borderWidth = 1 * self.numSingleVesion;
    youLab.layer.borderColor = [SMSColor(255, 122, 63) CGColor];
    [view addSubview:youLab];
    

    
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 *self.numSingleVesion, 0, 168 *self.numSingleVesion, 108 * self.numSingleVesion)];
    imageView.backgroundColor = [UIColor cyanColor];
//    imageView.center = CGPointMake(view.frame.size.width /3 * 2 + 20 * self.numSingleVesion, view.frame.size.height/2);
    [imageView sd_setImageWithURL:[NSURL URLWithString:image]];
    [view addSubview:imageView];
}

-(void)doTap:(UITapGestureRecognizer *)center{
    NSLog(@"%ld",center.view.tag -100086);
    JfDhDetialViewController *detial = [[JfDhDetialViewController alloc] init];
    detial.pro_id = [NSString stringWithFormat:@"%ld",center.view.tag - 100086];
    
    [self.navigationController pushViewController:detial animated:YES];
    
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
