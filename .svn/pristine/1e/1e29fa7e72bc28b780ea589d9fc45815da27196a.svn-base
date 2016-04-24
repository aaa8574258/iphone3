//
//  DebitCompanyOrPersonalViewController.m
//  360du
//
//  Created by linghang on 15/11/17.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "DebitCompanyOrPersonalViewController.h"
#import "BuyFoodCarViewController.h"

@interface DebitCompanyOrPersonalViewController ()
@property(nonatomic,weak)UITextField *textField;

@end

@implementation DebitCompanyOrPersonalViewController
-(id)init{
    self = [super init];
    if (self) {
        [self makeNav];
        [self makeUI];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"发票信息";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
    
    //保存
    UIButton *favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    favoriteBtn.frame = CGRectMake(WIDTH_CONTROLLER - 0 * self.numSingleVesion - 0 * self.numSingleVesion, 5, 30 * self.numSingleVesion, 34);
    [favoriteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [favoriteBtn setTitle:@"保存" forState:UIControlStateNormal];
    favoriteBtn.titleLabel.font = [UIFont systemFontOfSize:15 * self.numSingleVesion];
    [favoriteBtn addTarget:self action:@selector(saveAddress) forControlEvents:UIControlEventTouchUpInside];
    favoriteBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:favoriteBtn];
    //    rightItem.
    //    [[UIBarButtonItem alloc]]
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)saveAddress{
    
    if ([self.target isKindOfClass:[BuyFoodCarViewController class]]) {
        [self.target retunDebitDeatil:self.textField.text];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)makeUI{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 64 + 10 * self.numSingleVesion, WIDTH_CONTROLLER - 20 * self.numSingleVesion, 40 * self.numSingleVesion)];
    textField.placeholder = @"请写公司或者个人开头的发票";
    self.textField = textField;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:textField];
}
- (void)setContent:(NSString *)content{
    if (![content isEqual:@"不需要发票"]) {
        self.textField.text = content;
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
