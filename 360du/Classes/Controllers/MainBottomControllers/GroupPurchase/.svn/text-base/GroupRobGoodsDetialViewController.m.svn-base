  //
//  GroupRobGoodsDetialViewController.m
//  360du
//
//  Created by 利美 on 16/7/7.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "GroupRobGoodsDetialViewController.h"
#import "CZCountDownView.h"
#import "TranlateTime.h"
#import "SDCycleScrollView.h"
#import "UIView+Toast.h"
#import "NSString+URLEncoding.h"
#import "JSCartModel.h"
#import "ShopCarViewController.h"
#import "LogInViewController.h"
@interface GroupRobGoodsDetialViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *theHi;
@property(nonatomic,strong)CZCountDownView *countDownView;
//@property(nonatomic ,strong) UILabel *lineMoney;
@property(nonatomic,strong)NSMutableArray *imageData;
@property(nonatomic,strong)UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H5Hight;
@property(nonatomic,strong)GroupPurchaseItemView *itemView;
@end

@implementation GroupRobGoodsDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numSingleVesion = [VersionTranlate returnVersionRateAnyIphone:self.view.frame.size.width];
    self.view.backgroundColor = [UIColor whiteColor];
    self.theHi.constant = 120 * self.numSingleVesion;
//    self.H5Hight.constant = self.view.frame.size.height - 44*self.numSingleVesion;
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    UILabel *lable = [[UILabel alloc] init];
    lable.text = @"商品详情";
    lable.font = [UIFont systemFontOfSize:18 * self.numSingleVesion];
    [lable sizeToFit];
    lable.textColor = [UIColor blackColor];
    lable.center = CGPointMake(lable.frame.size.width / 2, lable.bounds.size.height);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width , 44);
    self.navigationItem.titleView = view;
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    self.automaticallyAdjustsScrollViewInsets = NO;

    // Do any additional setup after loading the view.
    
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.bounces = NO;
    self.mainScrollView.showsVerticalScrollIndicator = YES;
    self.mainScrollView.backgroundColor = [UIColor whiteColor];
//    self.superView.backgroundColor = [UIColor yellowColor];
    self.LBSuperView.backgroundColor = [UIColor whiteColor];
    [self giveInfo];
    [self makeUI];
}



-(void) giveInfo{
    self.nameLab.text = self.model.cpname;
    self.nameLab.numberOfLines = 0;
    self.JGLab.text = [NSString stringWithFormat:@"￥%.2f",[self.model.unitPirce floatValue]];
    self.JG1Lab.text = [NSString stringWithFormat:@"¥%.2f",[self.model.marketPrice floatValue]];
//    UIView *view11 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.JG1Lab.frame.size.width, 1 *self.numSingleVesion)];
//    view11.backgroundColor = [UIColor lightGrayColor];
//    view11.center = self.JG1Lab.center;
//    [self.mainScrollView addSubview:view11];
    
    self.moneyLineWidth.constant = 88;
    self.countDownView = [CZCountDownView countDown];
//    self.countDownView.backgroundColor = [UIColor redColor];
    self.countDownView.frame = CGRectMake(0, 0, self.view.frame.size.width/2 - 10 * self.numSingleVesion, 20 *self.numSingleVesion);
//    self.lineMoney = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1 * self.numSingleVesion)];
//    self.lineMoney.backgroundColor = SMSColor(150,150,150);
//    [self.mainScrollView addSubview:self.lineMoney];
//    self.lineMoney.center = self.JG1Lab.center;
    //self.countDownView.backgroundColor = SMSColor(211, 211, 211);
    [self.timeSuperView addSubview:self.countDownView];
    self.countDownView.backgroundImageName = @"search_k";
    self.countDownView.timestamp = [[TranlateTime returnTimeStamp:self.model.stopTime] integerValue];
    self.countDownView.timerStopBlock = ^{
        NSLog(@"时间停止");
        
    };
//    [self.timeSuperView addSubview:self.countDownView];
    
//    self.WebSuperView = [[UIWebView alloc]initWithFrame:self.WebSuperView.frame];
    self.WebSuperView.scalesPageToFit = YES;
//    [self.mainScrollView addSubview:webView];
    
    //接受代理
    self.WebSuperView.delegate = self;
    
    NSURL * url = [NSURL URLWithString:self.model.groupDetails];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    
    //加载请求
    [self.WebSuperView loadRequest:request];
    
    
    self.imageData = [NSMutableArray arrayWithCapacity:0];
    if([self.model.detailsDes rangeOfString:@","].location !=NSNotFound)//_roaldSearchText
    {
       NSArray *array = [self.model.detailsDes componentsSeparatedByString:@","];
        self.imageData = [NSMutableArray arrayWithArray:array];
    }
    else
    {
        [self.imageData addObject:self.model.detailsDes];
    }
    NSLog(@"%@",self.imageData);
    if (self.imageData.count == 1) {
        UIImageView *view = [[UIImageView alloc] init];
        view.frame = CGRectMake(0, 0, self.view.frame.size.width, 200 * self.numSingleVesion);
        view.contentMode = UIViewContentModeScaleToFill;
        [view sd_setImageWithURL:self.imageData.firstObject];
        [self.LBSuperView addSubview:view];
    }else{
        NSLog(@"%f",self.numSingleVesion);
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200 * self.numSingleVesion) imageURLStringsGroup:nil];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//    cycleScrollView2.delegate = self;
    cycleScrollView2.dotColor = [UIColor whiteColor];
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.LBSuperView addSubview:cycleScrollView2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = self.imageData;
    });
    }
}


-(void)makeUI{
    UITapGestureRecognizer *tap=[[ UITapGestureRecognizer alloc ] initWithTarget : self action : @selector (randomColor:)];
    [self.goToWebView addGestureRecognizer :tap];
    self.goToWebView. userInteractionEnabled = YES ;
    
}

-(void)randomColor:( UITapGestureRecognizer *)gestureRecognizer{
    self.mainScrollView.contentOffset = CGPointMake(0, self.WebSuperView.frame.origin.y);
    
}

- (IBAction)sender:(id)sender {
//    GroupPurchaseItemView *itemView = [[GroupPurchaseItemView alloc] init];
    NSString *url = [NSString stringWithFormat:GROUPPURCHASESPECIFICATION,self.model.cpid];
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl: url andFinishBlock:^(id getResult) {
        if ([getResult[@"code"] isEqual:@"000000"]) {
            GroupPurchasrItemListModel *itemModel = nil;
            for (id temp in getResult[@"datas"]) {
                itemModel = [[GroupPurchasrItemListModel alloc] initWithDictionary:temp];
                
            }
            self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, WIDTH_CONTROLLER, 500)];
            self.bgView.backgroundColor = SMSColor(221, 221, 221);
            [self.view addSubview:self.bgView];
            self.itemView = [[GroupPurchaseItemView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER,400) andModle:itemModel andStoreCount:[NSString stringWithFormat:@"%ld",(self.model.topLimit.integerValue - self.model.nowCount.integerValue)] andPictureUrl:self.model.detailsDes];
            self.itemView.cpid = self.model.cpid;
            self.itemView.target = self;
            [self.bgView addSubview:self.itemView];
//            [self.mainScrollView bringSubviewToFront:self.itemView];
//            [self createBgViewHeight:400 ];

            //
        }else{
//            [self.view makeToast:getResult[@"message"]];
        }
    }];

}
- (void)cancelOrNot:(NSInteger)cancelOrConfirm andArr:(NSArray *)infoArr andCount:(NSString *)count andPid:(NSString *)pid andShopType:(NSString *)shopType andRule:(NSString *)rule{
//    [self removeBgViewTouch];
    if (![StoreageMessage isStoreMessage]) {
        [self.view makeToast:@"请先登录!"];
        LogInViewController *logIn = [[LogInViewController alloc] init];
        [self.navigationController pushViewController:logIn animated:YES];
        return;
    }
    if (cancelOrConfirm == 0) {
        [self removeBgViewTouch];

    }else{
//        [self makeHUd];
//        AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
//        //NSString *url3 = [NSString stringWithFormat:GROUPGAINORDERINFORMATION,[StoreageMessage getMessage][2],infoArr[0]];
//        NSLog(@"qwqww%@",self.model.cpid);
//        NSString *url3 = [NSString stringWithFormat:GROUPGAINORDERINFORMATION,[StoreageMessage getMessage][2],self.model.cpid];
//        [twoPack getUrl:url3 andFinishBlock:^(id getResult) {
//            [self hudWasHidden:self.hudProgress];
//            NSLog(@"23333%@",getResult);
//            if ([getResult[@"code"] isEqual:@"000000"]) {
//                GroupOrderDeatilModel *detailModel = [[GroupOrderDeatilModel alloc] initWithDictionary:getResult[@"datas"]];
//                GroupPurchaseOrderDetailViewController *orderDeatil = [[GroupPurchaseOrderDetailViewController alloc] initWithModel:detailModel];
//                [self.navigationController pushViewController:orderDeatil animated:YES];
//            }else{
////                [self.view makeToast:getResult[@"message"]];
//            }
//        }];
        
        
        AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
        NSLog(@"%@",[NSString stringWithFormat:OPERATOSHOPPINGCAR,[StoreageMessage getMessage][2],self.model.cpid,count,pid,shopType,[[rule urlEncodeString] urlEncodeString]]);
        [twoPacking getUrl:[NSString stringWithFormat:OPERATOSHOPPINGCAR,[StoreageMessage getMessage][2],self.model.cpid,count,pid,shopType,[[rule urlEncodeString] urlEncodeString]] andFinishBlock:^(id getResult) {
            NSLog(@"%@",getResult);
            if ([getResult[@"code" ] isEqualToString:@"000000"]) {
//                [self.view makeToast:@"加入购物车成功"];
//                
//                NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
//                JSCartModel *model = [[JSCartModel alloc] init];
//                NSDictionary *dic = @{@"count":count,@"":@""};
                
                
                
                
                
                
                
                
                
//                JSCartModel *model = [[JSCartModel alloc] init];
//                NSDictionary *dic1 = @{@"shopCarId":self.model.cpid};
//                NSDictionary *dic2 = @{@"shopType":@"2"};
//                NSDictionary *dic3 = @{@"shopName":self.model.cpname};
//                NSDictionary *dic4 = @{@"proName":self.}
//                
//                
//                
//                AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
//                [twoPacking getUrl:[NSString stringWithFormat:SHOPPINGCARLIST,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
//                    NSLog(@"%@",getResult);
////                    NSLog(@"%@----%@",getResult,self.memchantId);
//                    NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
//                    for (NSDictionary *dic1 in getResult[@"datas"]) {
//                        
////                        if ([dic1[@"did"] isEqualToString:self.memchantId]) {
////                            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
//                        
////                            for (NSDictionary *dic in dic1[@"prosArray"]) {
////                                JSCartModel *model = [[JSCartModel alloc] init];
////                                [model setValuesForKeysWithDictionary:dic];
////                                [arr addObject:model];
////                            }
////                            [arr1 addObject:arr];
//                            
//                        }
//                        
//                    }
                    
//                    ShopCarViewController *shopCar = [[ShopCarViewController alloc] initWithData:arr1];
                    //                NSLog(@"%@",arr1);
                    //        shopCar.dataArr = arr1;
//                    [self.navigationController pushViewController:shopCar animated:YES];
//                }];
                
            }else{
                [self.view makeToast:getResult[@"message"]];
            }
            NSLog(@"%@",[NSString stringWithFormat:GETSHOPPINGCAR,[StoreageMessage getMessage][2],self.model.cpid]);
            AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
            [twoPacking getUrl:[NSString stringWithFormat:GETSHOPPINGCAR,[StoreageMessage getMessage][2],self.model.cpid] andFinishBlock:^(id getResult) {
                NSLog(@"%@",getResult);
                NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *dic1 in getResult[@"datas"]) {
                    
//                    if ([dic1[@"did"] isEqualToString:self.memchantId]) {
                        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
                        
                        for (NSDictionary *dic in dic1[@"prosArray"]) {
                            JSCartModel *model = [[JSCartModel alloc] init];
                            [model setValuesForKeysWithDictionary:dic];
                            [arr addObject:model];
                        }
                        [arr1 addObject:arr];
                        
                    }
                    
//                }

                ShopCarViewController *shopCar = [[ShopCarViewController alloc] initWithData:arr1];
                //                NSLog(@"%@",arr1);
                //        shopCar.dataArr = arr1;
                [self.navigationController pushViewController:shopCar animated:YES];
            }];
        }];
        
        
        
    }
}


- (void)cancelOrNot:(NSInteger)cancelOrConfirm andArr:(NSArray *)infoArr{
    [self removeBgViewTouch];
    if (cancelOrConfirm == 0) {
        [self removeBgViewTouch];
        
    }

}
//触摸
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = [touches anyObject];
//    NSLog(@"%@",touch.view);
//    if (![touch.view isEqual:self.bgView]) {
//        //
//        [self removeBgViewTouch];
//    }
//    if ([touch.view isEqual:self.itemView]) {
//        
//    }
}
- (void)removeBgViewTouch{
    [self.itemView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.itemView removeFromSuperview];
    self.itemView = nil;
    [self removeBgView];
}
//创建背景图
- (void)createBgViewHeight:(NSInteger)height{
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER, height - 64)];
    self.bgView.backgroundColor = SMSColor(221, 221, 221);
    [self.view addSubview:self.bgView];
}
//移除背景图
- (void)removeBgView{
    [self.bgView removeFromSuperview];
    self.bgView = nil;
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
