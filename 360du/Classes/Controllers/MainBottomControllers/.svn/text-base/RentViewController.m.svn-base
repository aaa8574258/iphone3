//
//  RentViewController.m
//  360du
//
//  Created by 利美 on 16/6/13.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "RentViewController.h"
#import "UIImageView+WebCache.h"
#import "CleanerViewController.h"
@interface RentViewController ()
@property (nonatomic ,strong) NSArray *data1;
@property (nonatomic ,strong) NSArray *data2;

@end

@implementation RentViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadData];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"租房";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"租房";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;

}


-(void)loadData{
    self.data1 = @[@"整租",@"合租",@"短租"];
    self.data2 = @[@"hezu.png",@"zhengzu.png",@"duanzu.png"];
    [self makeUI];
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
    scrView.contentSize = CGSizeMake(WIDTH_CONTROLLER, height * self.data1.count + 100 * self.numSingleVesion);
    
    for (NSInteger i = 0; i < self.data1.count; i++) {
        UIView *imgViewScr = [[UIView alloc] initWithFrame:CGRectMake(25 * self.numSingleVesion, 100 * self.numSingleVesion + height  * i, (WIDTH_CONTROLLER - 50 * self.numSingleVesion), intervalHeight)];
        imgViewScr.layer.cornerRadius = intervalHeight / 2;
        [scrView addSubview:imgViewScr];
        imgViewScr.layer.borderWidth = 1 * self.numSingleVesion;
        imgViewScr.layer.borderColor = [SMSColor(221, 221, 221) CGColor];
        imgViewScr.backgroundColor = SMSColor(225, 225, 225);
        UIImageView *cicreImg = [[UIImageView alloc] initWithFrame:CGRectMake(65 * self.numSingleVesion, (intervalHeight - 45 * self.numSingleVesion) / 2, 45 * self.numSingleVesion, 45 * self.numSingleVesion)];
        [cicreImg setImage:[UIImage imageNamed:self.data2[i]]];
        [imgViewScr addSubview:cicreImg];
        
        
        //名称
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectZero];
        nameLab.font = [UIFont systemFontOfSize:18];
        nameLab.textColor = [UIColor blackColor];
        nameLab.text = self.data1[i];
        [nameLab sizeToFit];
        [imgViewScr addSubview:nameLab];
        nameLab.center = CGPointMake(125 * self.numSingleVesion + 5 * self.numSingleVesion + nameLab.frame.size.width / 2 + 5 * self.numSingleVesion, intervalHeight / 2);
        
        //介绍
        //        UILabel *descLab = [[UILabel alloc] initWithFrame:CGRectMake(65 * self.numSingleVesion + 5 * self.numSingleVesion + nameLab.frame.size.width + 10 * self.numSingleVesion, intervalHeight / 2 - 20 * self.numSingleVesion, imgViewScr.frame.size.width - (65 * self.numSingleVesion + 5 * self.numSingleVesion + nameLab.frame.size.width + 10 * self.numSingleVesion + 5 * self.numSingleVesion), 40 * self.numSingleVesion)];
        //        descLab.text = model.desc;
        //        descLab.font = [UIFont systemFontOfSize:13];
        //        [imgViewScr addSubview:descLab];
        //        descLab.numberOfLines = 2;
        
        
        
        
        UIButton *cicreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cicreBtn.frame = imgViewScr.bounds;
        [cicreBtn addTarget:self action:@selector(cicreBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        cicreBtn.tag = 1400 + i;
        [imgViewScr addSubview:cicreBtn];
    }
}
-(void)cicreBtnDown:(UIButton *)cireBtn{
//    BaseViewController *ctrl = nil;
    UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
    CleanerViewController *cleanerViewController = [cleanerSB instantiateViewControllerWithIdentifier:@"cleaner" ] ;
    cleanerViewController.target = self;
    if (cireBtn.tag == 1400) {
        cleanerViewController.tag = @"1";
    }else if (cireBtn.tag == 1401){
        cleanerViewController.tag = @"2";
    }else if(cireBtn.tag == 1402){
        cleanerViewController.tag = @"3";
    }
    [self.navigationController pushViewController:cleanerViewController animated:YES];
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
