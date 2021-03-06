//
//  BaseViewController.m
//  360du
//
//  Created by linghang on 15-4-11.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseViewController.h"
#import "VersionTranlate.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "ViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.numSingleVesion = [VersionTranlate returnVersionRateAnyIphone:WIDTH_CONTROLLER];
        NSLog(@"1212121212%f",self.numSingleVesion);
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    [self setBackImageStateName:@"fanhuijian2222.png" AndHighlightedName:@""];
    [self setNavBarImage:@"0.png"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//导航条背景图
-(void)setNavBarImage:(NSString *)name{
    if (name.length == 0) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"0.png"] forBarMetrics:UIBarMetricsDefault];
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:name] forBarMetrics:UIBarMetricsDefault];
    
}
-(void)setNavBack:(NSString *)name{
    
}
//返回按钮
-(void)setBackImageStateName:(NSString *)state AndHighlightedName:(NSString *)highligh{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 30);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    
}
-(void)setBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}
////没有导航条的返回
//-(void)setBackNoNavgationImageStateName:(NSString *)state AndHightlightedName:(NSString *)highligh{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 44, 44);
//    [btn setBackgroundImage:[UIImage imageNamed:state] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:highligh] forState:UIControlStateHighlighted];
//    [btn addTarget:self action:@selector(setNoNavBack) forControlEvents:UIControlEventTouchUpInside];
//    [self setLeftItem:btn];
//}
//-(void)setNoNavBack{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//左边视图
-(void)setLeftItem:(UIView *)view{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -16;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,leftItem];
}
//右边视图
-(void)setRightItem:(UIView *)view{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItems = @[rightItem];
}
//中间视图和字
-(void)setNavTitleItemWithNameAndImage:(NSString *)name imageName:(NSString *)imageName{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    UIImage *img = [UIImage imageNamed:imageName];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.frame = CGRectMake(0,10, 34, 24);
    [view addSubview:imgView];
    
    UILabel *lable = [[UILabel alloc] init];
    lable.text = name;
    lable.font = [UIFont systemFontOfSize:18];
    [lable sizeToFit];
    lable.center = CGPointMake(imgView.frame.size.width  + lable.frame.size.width / 2, lable.bounds.size.height);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width + imgView.frame.size.width, 44);
    self.navigationItem.titleView = view;
}
//中间名字
-(void)setNavTitleItemWithName:(NSString *)name{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    UILabel *lable = [[UILabel alloc] init];
    lable.text = name;
    lable.font = [UIFont systemFontOfSize:18];
    [lable sizeToFit];
    lable.textColor = [UIColor blackColor];
    lable.center = CGPointMake(lable.frame.size.width / 2, lable.bounds.size.height);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width , 44);
    self.navigationItem.titleView = view;
}
//背景图
-(void)setBackgroud:(NSString *)name{
    UIImage *img = [UIImage imageNamed:name];
    self.view.layer.contents = (id)img.CGImage;
}
-(void)setTwoViewWithLeftOne:(NSString *)leftOne AndLefTwo:(NSString *)leftTwo{
    
    
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
