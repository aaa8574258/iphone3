//
//  ParkingChargeViewController.m
//  360du
//
//  Created by linghang on 16/1/7.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ParkingChargeViewController.h"
#import "ParkingPayHistoryViewController.h"
#import "ParkingMangerViewController.h"
@interface ParkingChargeViewController ()

@end

@implementation ParkingChargeViewController
- (id)init{
    self = [super init];
    if (self) {
        [self makeNav];
        [self creteScrollview];
 
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.automaticallyAdjustsScrollViewInsets = NO;
        // Do any additional setup after loading the view.
}
- (void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:@"停车管理"];
}
- (void)creteScrollview{
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64)];
    bgImg.image = [UIImage imageNamed:@"course_class_bg.jpg"];
    bgImg.userInteractionEnabled = YES;
    [self.view addSubview:bgImg];
    
    NSArray *titleArr = @[@"停车缴费",@"缴费记录"];
    NSArray *imgArr = @[@"stop_car_payment.png",@"car_payment_info.png"];
    for (NSInteger i = 0; i < titleArr.count; i++) {
        UIView *cicreView = [[UIView alloc] initWithFrame:CGRectMake(25 * self.numSingleVesion, bgImg.frame.size.height / 2 - 105 * self.numSingleVesion + 110 * self.numSingleVesion * i, (WIDTH_CONTROLLER - 50 * self.numSingleVesion), 100 * self.numSingleVesion)];
        
        cicreView.layer.cornerRadius = 50 * self.numSingleVesion;
        [bgImg addSubview:cicreView];
        cicreView.backgroundColor = SMSColor(220, 227, 244);
        cicreView.layer.borderWidth = 1 * self.numSingleVesion;
        cicreView.layer.borderColor = [SMSColor(193, 193, 193) CGColor];
        
        UIImageView *cicreImg = [[UIImageView alloc] initWithFrame:CGRectMake(30 * self.numSingleVesion, 10 * self.numSingleVesion, 80 * self.numSingleVesion, 80 * self.numSingleVesion)];
        cicreImg.image = [UIImage imageNamed:imgArr[i]];
        [cicreView addSubview:cicreImg];

        
        //名称
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectZero];
        nameLab.font = [UIFont systemFontOfSize:18];
        nameLab.textColor = [UIColor blackColor];
        nameLab.text = titleArr[i];
        [nameLab sizeToFit];
        [cicreView addSubview:nameLab];
        nameLab.center = CGPointMake(110 * self.numSingleVesion + 10 * self.numSingleVesion + nameLab.frame.size.width / 2, 50 * self.numSingleVesion);
        
        
        
        
        UIButton *cicreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cicreBtn.frame = cicreView.bounds;
        [cicreBtn addTarget:self action:@selector(cicreBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        cicreBtn.tag = 1400 + i;
        [cicreView addSubview:cicreBtn];
    }
//    UIScrollView *scrView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, imgView.frame.size.height / 2 - 105 * self.numSingleVesion, WIDTH_VIEW, <#CGFloat height#>)];
//    [imgView addSubview:scrView];
//    scrView.contentSize = CGSizeMake(WIDTH_CONTROLLER, 70 * self.numSingleVesion * self.dataArr.count + 100 * self.numSingleVesion);

}
- (void)cicreBtnDown:(UIButton *)cicreBtn{
    BaseViewController *ctrl = nil;
    if (cicreBtn.tag == 1400) {
        ctrl = [[ParkingMangerViewController alloc] init];
    }else{
        ctrl = [[ParkingPayHistoryViewController alloc] init];
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
