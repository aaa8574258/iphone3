//
//  MenberViewController.m
//  360du
//
//  Created by linghang on 15/7/18.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "MenberViewController.h"
#import "StoreageMessage.h"
#import "NSString+URLEncoding.h"
#import "BottomPersonScrollview.h"
#import "ScrOrderCenterViewController.h"
#import "RobOrderCenterViewController.h"
#import "QuicjOrderManagerViewController.h"
#import "ApplyCommitRobOrderViewController.h"
#import "LogInViewController.h"
#import "UIView+Toast.h"
#import "MemberFavoriteViewController.h"
#import "MinePrivilageViewController.h"
#import "MerchantLoginViewController.h"
#import "MerchantViewController.h"
#import "GroupWMPageViewController.h"
#import "MineGroupViewController.h"
@interface MenberViewController ()
@property(nonatomic,weak)UIButton *welcomeBtn;
@property(nonatomic,weak)UILabel *telLab;
@property(nonatomic,weak)UILabel *chapterLab;
@end

@implementation MenberViewController
-(id)init{
    self = [super init];
    if (self) {

        [self makeHeaderView];
        [self makeScrollView];

    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self makeNav];
    if ([StoreageMessage isStoreMessage]) {
        self.telLab.text = [[StoreageMessage getMessage][0] URLDecodedString];
        self.chapterLab.text = @"欢迎进入快快猫个人中心!";
        self.welcomeBtn.userInteractionEnabled = NO;
    }
    else{
        self.telLab.text = @"Welcome";
        self.chapterLab.text = @"立即登录 进入个人中心";
        self.welcomeBtn.userInteractionEnabled = YES;
    }
}
-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:@"个人中心"];
    //注销按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, (44 - 30) / 2, 50 * self.numSingleVesion, 30);
   // [rightBtn setTitle:@"注销" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
    rightBtn.backgroundColor = [UIColor colorWithRed:(CGFloat)255 / 255.0 green:(CGFloat)255 / 255.0 blue:(CGFloat)255 / 255.0 alpha:0.3];
    // rightBtn.layer.borderWidth = 1 * self.numSingleVesion;
    //rightBtn.layer.borderColor = [[UIColor colorWithRed:(CGFloat)(208) / 255.0 green:(CGFloat)(211) / 255.0 blue:(CGFloat)(211) / 255.0 alpha:1] CGColor];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [rightBtn addTarget:self action:@selector(rightDown) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.center = CGPointMake(WIDTH_CONTROLLER - 25 * self.numSingleVesion - 5 * self.numSingleVesion, 22);
    
    if ([StoreageMessage isStoreMessage]) {
        [rightBtn setTitle:@"注销" forState:UIControlStateNormal];
    }else{
        [rightBtn setTitle:@"登陆" forState:UIControlStateNormal];

    }

    
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBar;
}
//注销
-(void)rightDown{
    //注销
    if ([StoreageMessage isStoreMessage]) {
        [StoreageMessage storeMessageUsername:@"" andPassword:@"" andToken:@""];
        [self.view makeToast:@"账号已退出!"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        LogInViewController *logIn = [[LogInViewController alloc] init];
        [self.navigationController pushViewController:logIn animated:YES];
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view.
}
-(void)makeHeaderView{
    //背景图
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, 135 * self.numSingleVesion)];
    bgImgView.image = [UIImage imageNamed:@"personal_bg.png"];
    [self.view addSubview:bgImgView];
    bgImgView.userInteractionEnabled = YES;
    
    //横图
    UIImageView *horizeImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40 * self.numSingleVesion, WIDTH_CONTROLLER, 54 * self.numSingleVesion)];
    //UIImage *image = [[UIImage imageNamed:@"personal_bg_1.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:54 * self.numSingleVesion];
    UIImage *image = [[UIImage imageNamed:@"personal_bg_1"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0,0,0)];
    horizeImg.image = image;
    horizeImg.userInteractionEnabled = YES;
    [bgImgView addSubview:horizeImg];
    //    NSString *backgroudpath = [[NSBundle mainBundle] pathForResource:@"personal_bg_1" ofType:@"png"];
    //    UIImage  *backgroudImage = [UIImage imageWithContentsOfFile:backgroudpath];
    //    horizeImg.image = backgroudImage;
    
    //image = [image stretchableImageWithLeftCapWidth:floorf(image.size.width/2) topCapHeight:floorf(image.size.height/2)];
    
    //    UIImage *buttonImageselected = [UIImage imageNamed:@"contactselected.png"];
    //    buttonImage = [buttonImage stretchableImageWithLeftCapWidth:floorf(buttonImage.size.width/2) topCapHeight:floorf(buttonImage.size.height/2)];
    //
    
    //按钮
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = horizeImg.bounds;
    [nextBtn addTarget:self action:@selector(headImgBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.tag = 1101;
    [horizeImg addSubview:nextBtn];
    self.welcomeBtn = nextBtn;
    
    //作者头像，以后改成按钮
    UIButton *authorImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    authorImgBtn.frame = CGRectMake(61.5 * self.numSingleVesion, (54 - 48) / 2 * self.numSingleVesion, 48* self.numSingleVesion, 48 * self.numSingleVesion);
    [authorImgBtn setImage:[UIImage imageNamed:@"personal_user"] forState:UIControlStateNormal];
    [authorImgBtn addTarget:self action:@selector(headImgBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [horizeImg addSubview:authorImgBtn];
    authorImgBtn.layer.cornerRadius = 24 * self.numSingleVesion;
    authorImgBtn.clipsToBounds = YES;
    authorImgBtn.userInteractionEnabled = YES;
    authorImgBtn.layer.borderWidth = 1.5 * self.numSingleVesion;
    authorImgBtn.layer.borderColor = [SMSColor(160, 160, 160) CGColor];
    //self.imgHead = authorImgBtn;
    authorImgBtn.tag = 1100;
    
    //手机号
    UILabel *telLable = [[UILabel alloc] initWithFrame:CGRectMake((54 + 48 + 30) * self.numSingleVesion, horizeImg.frame.size.height / 2 - 20 * self.numSingleVesion, 300, 15 * self.numSingleVesion)];
    if ([StoreageMessage isStoreMessage]) {
        telLable.text = [[StoreageMessage getMessage][0] URLDecodedString];
    }
    else{
        telLable.text = @"Welcome";
    }
    telLable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    telLable.textColor = [UIColor colorWithRed:(CGFloat)149 / 255.0 green:(CGFloat)81 / 255.0 blue:(CGFloat)23 / 255.0 alpha:1];
    [telLable sizeToFit];
    [horizeImg addSubview:telLable];
    self.telLab = telLable;
    //self.nameStr = telLable;
    
    
    
    //学院名称
    UILabel *departMentLable = [[UILabel alloc] initWithFrame:CGRectMake((54 + 48 + 30) * self.numSingleVesion, horizeImg.frame.size.height / 2 + 5 * self.numSingleVesion, 400, 15 * self.numSingleVesion)];
    departMentLable.font = [UIFont systemFontOfSize:13 * self.numSingleVesion];
    departMentLable.textColor = [UIColor colorWithRed:(CGFloat)0 / 255.0 green:(CGFloat)0 / 255.0 blue:(CGFloat)0 / 255.0 alpha:1];
    if ([StoreageMessage isStoreMessage]) {
        departMentLable.text = @"欢迎进入快快猫个人中心!";
    }else{
        departMentLable.text = @"立即登录 进入个人中心";
    }
    [departMentLable sizeToFit];
    self.chapterLab = departMentLable;
//self.department = departMentLable;
    
    //横线
    //    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake((54 + 48 + 25) * self.numSingleVesion, horizeImg.frame.size.height / 2 - 1 * self.numSingleVesion, departMentLable.frame.size.width, 2 * self.numSingleVesion)];
    //    lineImg.image = [UIImage imageNamed:@"line_1.jpg"];
    //    [horizeImg addSubview:lineImg];
    //    self.lineImg = lineImg;
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake((54 + 48 + 25) * self.numSingleVesion, horizeImg.frame.size.height / 2 - 0.5 * self.numSingleVesion, departMentLable.frame.size.width, 1 * self.numSingleVesion)];
    lineLab.backgroundColor = SMSColor(149, 81, 23);
    [horizeImg addSubview:lineLab];
    //self.lineImg = lineLab;
    
    [horizeImg addSubview:departMentLable];
}
- (void)headImgBtnDown:(UIButton *)headImgBtn{
    if (headImgBtn.tag == 1101) {
        if (![StoreageMessage isStoreMessage]) {
            LogInViewController *logIn = [[LogInViewController alloc] init];
            [self.navigationController pushViewController:logIn animated:YES];
        }
       
    }
}
//scrollvoew
- (void)makeScrollView{
    //NSArray *scrArr = @[@"我的收藏",@"消息中心",@"我的预约",@"我的团购",@"订单中心",@"抢单中心",@"申请快递员",@"申请小区抢单",@"扫码取货",@"我的优惠券"];
    NSArray *scrArr = @[@"消息中心",@"我的团购",@"我的快递单",@"抢单中心",@"申请快递员",@"申请小区抢单",@"我的优惠券",@"商家管理"];

   // NSArray *scrArr = @[@"我的收藏",@"消息中心",@"我的预约",@"我的团购",@"我的优惠券",@"商家管理"];
    //NSArray *imageArr = @[@"person_collect.png",@"person_message.png",@"person_order.png",@"person_buying.png",@"my_coupon.png",@"my_coupon.png"];
//    NSArray *scrArr = @[@"我的优惠券",@"商家管理"];

    //NSArray *imageArr = @[@"my_coupon.png",@"my_coupon.png"];
        NSArray *imageArr = @[@"person_message.png",@"person_buying.png",@"my_coupon.png",@"my_coupon.png",@"person_message.png",@"person_order.png",@"person_buying.png",@"my_coupon.png",@"my_coupon.png",@"my_coupon.png"];
    // NSArray *imageArr = @[@"person_collect.png",@"person_message.png",@"person_order.png",@"person_buying.png",@"my_coupon.png",@"my_coupon.png",@"person_message.png",@"person_order.png",@"person_buying.png",@"my_coupon.png",@"my_coupon.png"];
    BottomPersonScrollview *bottomPerson = [[BottomPersonScrollview alloc] initWithFrame:CGRectMake(0, 64 + 135 * self.numSingleVesion + 5 * self.numSingleVesion, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 - 135 * self.numSingleVesion - 49 * self.numSingleVesion - 5 * self.numSingleVesion) andNameArr:scrArr andImageArr:imageArr];
    bottomPerson.target = self;
    [self.view addSubview:bottomPerson];
    
}
//返回ScrBtn
-(void)returnSctBtnTag:(NSInteger)btnTag{
    BaseViewController *ctrl = nil;
    switch (btnTag) {
//            //我的团购
//        case 0:{
//            ctrl = [[QuicjOrderManagerViewController alloc] init];
//            break;
//        }
            //我的优惠券
//        case 0:{
//            ctrl = [[MinePrivilageViewController alloc] init];
//            break;
//        }
//            //商家管理
//        case 1:{
//            //            MerchantViewController *merchant1 = [[MerchantViewController alloc] init];
//            //            [self.navigationController pushViewController:merchant1 animated:YES];
//            //            return;
//            if ([StoreageMessage isMerchantStoreMesssage]) {
//                MerchantViewController *merchant = [[MerchantViewController alloc] init];
//                [self.navigationController pushViewController:merchant animated:YES];
//                return;
//            }
//            
//            MerchantLoginViewController *merchant = [[MerchantLoginViewController alloc] init];
//            [self.navigationController pushViewController:merchant animated:YES];
//            //ctrl = [[ScanTwoDimessionViewController alloc] init];
//            break;
//        }

//            //我的收藏
//        case 0:{
//            ctrl = [[MemberFavoriteViewController alloc] init];
//            break;
//        }
            //消息中心
        case 0:{
            if (![StoreageMessage isStoreMessage]) {
                [self.view makeToast:@"请先登录!"];
                LogInViewController *logIn = [[LogInViewController alloc] init];
                [self.navigationController pushViewController:logIn animated:YES];
                return;
            }
            //ctrl = [[ScrOrderCenterViewController alloc] init];
            break;
        }
//         //我的预约
//        case 2:{
//            ctrl = [[RobOrderCenterViewController alloc] init];
//            break;
//        }
            //我的团购
        case 1:{
            if (![StoreageMessage isStoreMessage]) {
                [self.view makeToast:@"请先登录!"];
                LogInViewController *logIn = [[LogInViewController alloc] init];
                [self.navigationController pushViewController:logIn animated:YES];
                return;
            }
           Class vcClass = [MineGroupViewController class];
 
            GroupWMPageViewController *pageVC = [[GroupWMPageViewController alloc] initWithViewControllerClasses:@[vcClass,vcClass,vcClass] andTheirTitles:@[@"全部",@"待付款",@"待收货"]];
            pageVC.pageAnimatable = YES;
            pageVC.menuItemWidth = 85;
            pageVC.menuHeight = 45 * self.numSingleVesion;
            pageVC.postNotification = YES;
            pageVC.bounces = YES;
            // 默认
            pageVC.title = @"我的团购";
            pageVC.preloadPolicy = WMPageControllerPreloadPolicyNeighbour;
            pageVC.keys = [@[@"statue",@"statue",@"statue"]mutableCopy];
            pageVC.values = [@[@"0",@"1",@"3"] mutableCopy];
            [self.navigationController pushViewController:pageVC animated:YES];

            return;
            break;
        }
//            //我的优惠券
//        case 4:{
//            ctrl = [[MinePrivilageViewController alloc] init];
//            break;
//        }
//            //商家管理
//        case 5:{
////            MerchantViewController *merchant1 = [[MerchantViewController alloc] init];
////            [self.navigationController pushViewController:merchant1 animated:YES];
////            return;
//            if ([StoreageMessage isMerchantStoreMesssage]) {
//                MerchantViewController *merchant = [[MerchantViewController alloc] init];
//                [self.navigationController pushViewController:merchant animated:YES];
//                return;
//            }
// 
//            MerchantLoginViewController *merchant = [[MerchantLoginViewController alloc] init];
//            [self.navigationController pushViewController:merchant animated:YES];
//            //ctrl = [[ScanTwoDimessionViewController alloc] init];
//            break;
//        }

            //订单中心
        case 2:{
            if (![StoreageMessage isStoreMessage]) {
                [self.view makeToast:@"请先登录!"];
                LogInViewController *logIn = [[LogInViewController alloc] init];
                [self.navigationController pushViewController:logIn animated:YES];
                return;
            }
            ctrl = [[ScrOrderCenterViewController alloc] init];
            break;
        }
         //抢单中心
        case 3:{
            if (![StoreageMessage isStoreMessage]) {
                [self.view makeToast:@"请先登录!"];
                LogInViewController *logIn = [[LogInViewController alloc] init];
                [self.navigationController pushViewController:logIn animated:YES];
                return;
            }
            ctrl = [[RobOrderCenterViewController alloc] init];
            break;
        }
            //快单掌柜
        case 4:{
            if (![StoreageMessage isStoreMessage]) {
                [self.view makeToast:@"请先登录!"];
                LogInViewController *logIn = [[LogInViewController alloc] init];
                [self.navigationController pushViewController:logIn animated:YES];
                return;
            }
            ctrl = [[QuicjOrderManagerViewController alloc] init];
            break;
        }
            //申请小区抢单
        case 5:{
            if (![StoreageMessage isStoreMessage]) {
                [self.view makeToast:@"请先登录!"];
                LogInViewController *logIn = [[LogInViewController alloc] init];
                [self.navigationController pushViewController:logIn animated:YES];
                return;
            }
            ctrl = [[ApplyCommitRobOrderViewController alloc] init];
            break;
        }
            //扫码取货
//        case 8:{
//            ctrl = [[ScanTwoDimessionViewController alloc] init];
//            break;
//        }
            //我的优惠券
        case 6:{
            if (![StoreageMessage isStoreMessage]) {
                [self.view makeToast:@"请先登录!"];
                LogInViewController *logIn = [[LogInViewController alloc] init];
                [self.navigationController pushViewController:logIn animated:YES];
                return;
            }
            ctrl = [[MinePrivilageViewController alloc] init];
            break;
        }
                        //商家管理
                    case 7:{
                        if (![StoreageMessage isStoreMessage]) {
                            [self.view makeToast:@"请先登录!"];
                            LogInViewController *logIn = [[LogInViewController alloc] init];
                            [self.navigationController pushViewController:logIn animated:YES];
                            return;
                        }
            //            MerchantViewController *merchant1 = [[MerchantViewController alloc] init];
            //            [self.navigationController pushViewController:merchant1 animated:YES];
            //            return;
                        if ([StoreageMessage isMerchantStoreMesssage]) {
                            MerchantViewController *merchant = [[MerchantViewController alloc] init];
                            [self.navigationController pushViewController:merchant animated:YES];
                            break;
                        }
                        MerchantLoginViewController *merchant = [[MerchantLoginViewController alloc] init];
                        [self.navigationController pushViewController:merchant animated:YES];
                        //ctrl = [[ScanTwoDimessionViewController alloc] init];
                        break;
                    }
        default:
            break;
    }
    [self.navigationController pushViewController:ctrl animated:YES];
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
