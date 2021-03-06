//
//  ProertyAddressDetailViewController.m
//  360du
//
//  Created by linghang on 15/11/27.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "ProertyAddressDetailViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "UIView+Toast.h"
#import "ProertyAddAddressViewController.h"
@interface ProertyAddressDetailViewController ()<UITextFieldDelegate>
@property(nonatomic,copy)NSString *xqId;
@property(nonatomic,strong)NSMutableString *houseStr;
@end

@implementation ProertyAddressDetailViewController
- (id)initWithXQId:(NSString *)xqId{
    self = [super init];
    if (self) {
        self.xqId = xqId;
        [self makeNav];
        [self makeUI];
    }
    return self;
}
- (void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"设置地址";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(WIDTH_CONTROLLER - 60 * self.numSingleVesion, 5, 50 * self.numSingleVesion, 34 * self.numSingleVesion);
    [rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(rightBtnDown) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}
- (void)rightBtnDown{
    self.houseStr = [NSMutableString stringWithCapacity:0];
    NSArray *houseArr = @[@"栋",@"单元"];
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < 3; i++) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:2300 + i];
        if (![self jugeNum:textField.text]) {//判断是不是数字
           // ^[0-9]*$
            [textField resignFirstResponder];
            [self.view makeToast:@"请填写数字"];
            return;
        }
        [tempArr addObject:textField.text];
        [textField resignFirstResponder];
        [self.houseStr appendString:textField.text];
        if (i != 2 ) {
            [self.houseStr appendString:houseArr[i]];
        }
    }
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:PROERTYADDRESSDEATIL,self.xqId,tempArr[0],tempArr[1],tempArr[2]] andFinishBlock:^(id getResult) {

        if([getResult[@"code"] isEqual:@"000001"]){
            [self.view makeToast:getResult[@"message"]];

        }else{
            //[self.view makeToast:getResult[@"message"]];
            if ([self.target isKindOfClass:[ProertyAddAddressViewController class]]) {
                [self.target returnHouseNum:self.houseStr andHouseId:getResult[@"datas"][@"xhid"]];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
    //    SelectCityViewController *selectCity = [[SelectCityViewController alloc] init];
    //    [self.navigationController pushViewController:selectCity animated:YES];
}
- (BOOL)jugeNum:(NSString *)numStr{
    NSString *numRegexx = @"^[0-9]*$";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numRegexx];
    return [numTest evaluateWithObject:numStr];
}
- (void)makeUI{
    NSArray *titleArr =@[@"楼栋/弄",@"单元号",@"门牌/房号"];
    CGFloat width = WIDTH_CONTROLLER / 3;
    for (NSInteger i = 0; i < titleArr.count; i++) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(width * i, 64 + 5 * self.numSingleVesion, width, 40 * self.numSingleVesion)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = titleArr[i];
        textField.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:textField];
        textField.font = [UIFont systemFontOfSize:13];
        textField.tag = 2300 + i;
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    UILabel *tempLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 64 + 50 * self.numSingleVesion, WIDTH_CONTROLLER - 20 * self.numSingleVesion, 20 * self.numSingleVesion)];
    tempLab.textColor = SMSColor(211, 211, 211);
    [self.view addSubview:tempLab];
    tempLab.text = @"如:36栋1单元1201";
    tempLab.font = [UIFont systemFontOfSize:12];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
