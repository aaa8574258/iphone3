//
//  DetialViewController.m
//  360du
//
//  Created by 利美 on 16/4/27.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "DetialViewController.h"
#import "CleanerDetialModel.h"
#import "StarView.h"
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "StoreageMessage.h"
#import "UIView+Toast.h"
#import "AddrModel.h"
#import "SDCycleScrollView.h"

@interface DetialViewController ()<MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *xjaverageLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyaddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *mobileButton;
@property (weak, nonatomic) IBOutlet UILabel *serviceFeaturesLabel;
@property (weak, nonatomic) IBOutlet UILabel *dldescLabel;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *dldLabel;
@property (weak, nonatomic) IBOutlet UIView *dldView;
@property (weak, nonatomic) IBOutlet UIImageView *starImage;
@property (weak, nonatomic) IBOutlet UIButton *daoHangNextButton;
@property (weak, nonatomic) IBOutlet UIButton *daoHangButton;
@property (weak, nonatomic) IBOutlet UIButton *sendInfoButton;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIView *ssView;
@property (weak, nonatomic) IBOutlet UIView *sView;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIButton *shouCBut;
@property(nonatomic,strong)MBProgressHUD *hudProgress;
@property (weak, nonatomic) IBOutlet UIView *lunboView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextHeight;


@end

@implementation DetialViewController

-(CLGeocoder *)geocoder
 {
     if (_geocoder==nil) {
         _geocoder=[[CLGeocoder alloc]init];
     }
     return _geocoder;
 }

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeHUd];
    [_shouCBut setImage:[UIImage imageNamed:@"wscbtn.png"] forState:UIControlStateNormal];
    [self jugeCollectionMerchant];
    
    [self getInfo];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 25 , 25);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    
    _serviceFeaturesLabel.numberOfLines = 0;
    _dldescLabel.numberOfLines = 0;
    _dldLabel.numberOfLines = 0;
    
//    NSData *data2 = [NSData dataWithContentsOfFile:SHENGNAMEANDCODE];
    
    //2.创建出饭反归档类
//    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data2];
//
//    //③拿到对象
//    AddrModel *model = [unarchiver decodeDataObject];
////    Person *pp2 = [unarchiver decodeObjectForKey:@"p2"];
//    
//    
//    //④关闭
//    [unarchiver finishDecoding];
//    AddrModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
    
//    _lo.latitude = [arr[0] floatValue];
//    _lo.longitude = ;

}




- (void)getInfo{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
    NSString  *url = [NSString stringWithFormat:CLEANERDETIAL,_companyId];
    NSLog(@"1111%@",url);
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
        [self hudWasHidden:self.hudProgress];
        [StoreageMessage getErrorMessage:@"NULL" fromUrl:url];

        
        
        
        NSArray *arr = responseObject[@"data"];
        self.detialArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in arr) {
            CleanerDetialModel *detialModel = [[CleanerDetialModel alloc]initWithDictionary:dic];
            [self.detialArray addObject:detialModel];
            
            if (detialModel.imageList.count != 0) {
                [self makeLunBoWithArr:detialModel.imageList];
            }else{
                self.nextHeight.constant = 0;
            }
            
            self.nameLabel.text = detialModel.name;
            self.timeLabel.text = [NSString stringWithFormat:@"最后更新时间:%@",detialModel.time];
            self.companyaddressLabel.text = detialModel.companyaddress;
            [self.mobileButton setTitle:detialModel.mobile forState:UIControlStateNormal];
            self.serviceFeaturesLabel.text = detialModel.serviceFeatures;
         
            self.dldescLabel.text = detialModel.scname;
            self.dldescLabel.textAlignment = 0;
            self.dldLabel.text = detialModel.dldesc;
            if (detialModel.dldesc == nil) {
                self.dldLabel.text = @"暂无其他消息";
            }
            StarView *sv = [[StarView alloc]initWithFrame:self.starImage.frame];
            [self.sView addSubview:sv];
            sv.showStar = [detialModel.xjaverage integerValue];

                    [self locat];
//                }
//            }];
            NSString *string = detialModel.didLocation;
            NSArray *array = [string componentsSeparatedByString:@","];
            NSLog(@"%@",array);
            CLLocationCoordinate2D anyLocation = CLLocationCoordinate2DMake([array[0] doubleValue], [array[1] doubleValue]);
//            anyLocation.latitude = [latText doubleValue];
//            anyLocation.longitude  = [lonText doubleValue];
//            NSString *string = detialModel.didLocation;
//            NSArray *array = [string componentsSeparatedByString:@","];
//            NSLog(@"%@",array);
//            NSString *str1 = array[0];
            self.coordinate = anyLocation;
            
            //                    //经度
            //                    CLLocationDegrees longitude=firstPlacemark.location.coordinate.longitude;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}


-(void) makeLunBoWithArr:(NSArray *) array{

    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.lunboView.frame.size.width, self.nextHeight.constant) imageURLStringsGroup:nil];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.delegate = self;
    cycleScrollView2.dotColor = [UIColor yellowColor];
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.lunboView addSubview:cycleScrollView2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = array;
    });
}



-(void)locat{
    self.urlScheme = @"mapURI://";
    self.appName = @"limeiMap";
//    NSString *str = [StoreageMessage getLatAndLong];
//    NSArray *arr = [str componentsSeparatedByString:@","];
    
//    CLLocationDegrees a = [arr[0] floatValue];
//    CLLocationDegrees b = [arr.lastObject floatValue];
//    NSLog(@"%f--%f",a,b);
//    _lo  = CLLocationCoordinate2DMake(a,b);
    NSLog(@"%f",self.coordinate.latitude);
    [_daoHangButton addTarget:self action:@selector(actionSheet) forControlEvents:UIControlEventTouchUpInside];
}


- (void)actionSheet
{
    __block NSString *urlScheme = self.urlScheme;
    __block NSString *appName = self.appName;
    __block CLLocationCoordinate2D coordinate = self.coordinate;
//    __block CLLocationCoordinate2D location = self.lo;

    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com/"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"苹果地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
//            NSLog(@"12121%f",[[StoreageMessage getLatAndLong][1] floatValue]);
            
            
//            CLLocationCoordinate2D lo = CLLocationCoordinate2DMake([arr[0] floatValue],[arr[1] floatValue]);
//            NSLog(@"%@",coordinate);

            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        }];
        
        [alert addAction:action];
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
    {
        NSLog(@"%f_%f",coordinate.longitude,coordinate.latitude);
//        [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",coordinate.longitude, coordinate.latitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//            NSLog(@"%@",[StoreageMessage getLatAndLong].latitude);
            
//            
//            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=%@&destination=%f,%f&mode=driving",[StoreageMessage getLatAndLong],coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];

        }];
        
        [alert addAction:action];
    }
    //高德地图导航
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
    {
//         [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&lat=%f&lon=%f&dev=0&style=2",appName,coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            &dev=1&style=2  ///
//            NSLog(@"%@",urlString);
             NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&poiname=%@&lat=%f&lon=%f&dev=1&style=2",@"app name", urlScheme, @"终点", coordinate.longitude, coordinate.latitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [alert addAction:action];
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]])
    {
//         [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"谷歌地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",appName,urlScheme,coordinate.longitude, coordinate.latitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        [alert addAction:action];
    }
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{
    }];
}

- (IBAction)duanXButton:(UIButton *)sender {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.mobileButton.titleLabel.text]]];
 }

- (IBAction)dianHButton:(UIButton *)sender {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",self.mobileButton.titleLabel.text]]];

}

- (IBAction)dianHBut:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.mobileButton.titleLabel.text]]];
}

- (IBAction)ShouCBut:(UIButton *)sender {
    
    [self jugeCollectionMerchant];
    
    NSString *url = [NSString stringWithFormat:COLLECTMERCHANT,self.companyId,[StoreageMessage getMessage][2]];
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",nil];
    manger.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    manger.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manger GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [StoreageMessage getErrorMessage:@"NULL" fromUrl:url];

        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //            NSString *tempStr =  [str substringFromIndex:1];
        //            NSString *fianlStr = [tempStr substringToIndex:tempStr.length - 1];
        if ([str isEqual:@"&取消收藏！"]) {
            NSLog(@"1");
            [self cancelFavBtnName];
        }else{
            NSLog(@"2");
            [self mendFavBtnName];
        }
        [self.view makeToast:str];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //  [[NSURLCache sharedURLCache] removeAllCachedResponses];
        //            NSLog(@"%@",[error description]);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        return ;
    }];

}

//判断是否收藏
- (void)jugeCollectionMerchant{
    if (![StoreageMessage isStoreMessage]) {
        return;
    }
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:ISORNOTFAVORITEMERCHANT,[StoreageMessage getMessage][2],self.companyId] andFinishBlock:^(id getResult) {
        if ([getResult[@"status"] isEqual:@"1"]) {
            //已经收藏
            [self mendFavBtnName];
        }
    }];
}
//收藏成功
- (void)mendFavBtnName{
//    [self.shouCBut setTitle:@"已收藏" forState:UIControlStateNormal];
    [self.shouCBut setImage:[UIImage imageNamed:@"scbtn.png"] forState:UIControlStateNormal];
    
}
//取消收藏
- (void)cancelFavBtnName{
//    [self.shouCBut setTitle:@"收藏" forState:UIControlStateNormal];
    [self.shouCBut setImage:[UIImage imageNamed:@"wscbtn.png"] forState:UIControlStateNormal];
    
}

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

-(void)setBack{
    
    [self.navigationController popViewControllerAnimated:YES];
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
