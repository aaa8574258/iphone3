//
//  ForgetPasswordViewController.m
//  360du
//
//  Created by linghang on 16/1/15.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "AuthcodeView.h"
#import "UIView+Toast.h"
#import "AFNetworkTwoPackaging.h"
#import "NSString+NSString.h"
@interface ForgetPasswordViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)AuthcodeView *authCodeView;
@end

@implementation ForgetPasswordViewController
- (id)init{
    self = [super init];
    if (self) {
        [self createNav];
        [self createView];
    }
    return self;
}
- (void)createNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    //[self setNavTitleItemWithNameAndImage:@"登陆" imageName:@"360.png"];
    [self setNavTitleItemWithName:@"忘记密码"];

}
- (void)createView{
    CGFloat height = 64 + 20 * self.numSingleVesion;
    CGFloat width = 20 * self.numSingleVesion;
    //提示输入账号
    UILabel *userNameLable = [[UILabel alloc] initWithFrame:CGRectMake(width,height, WIDTH_CONTROLLER - width * 2, 15 * self.numSingleVesion)];
    userNameLable.text = @"请在下面输入您要找回的账号";
    userNameLable.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:userNameLable];
    userNameLable.textColor = [UIColor redColor];
    height += 15 * self.numSingleVesion + 5 * self.numSingleVesion;
    //账号和密码
    NSArray *array = @[@"login_user@2x.png",@"login_lock@2x.png"];
    NSArray *placordArr = @[@"请输入账号",@"请输入验证码"];
    CGFloat viewHeight = 50 * self.numSingleVesion;
    for (NSInteger i = 0; i < array.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(width, height + viewHeight * i, WIDTH_CONTROLLER - width * 2, viewHeight - 10 * self.numSingleVesion)];
        view.layer.borderWidth = 1 * self.numSingleVesion;
        view.layer.borderColor = [SMSColor(211, 211, 211) CGColor];
        [self.view addSubview:view];
        
        //图片
        UIImageView *leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(5 * self.numSingleVesion, 7.5 * self.numSingleVesion, 25 * self.numSingleVesion, 25 * self.numSingleVesion)];
        leftImg.image = [UIImage imageNamed:array[i]];
        [view addSubview:leftImg];
        
        //uitextfield
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(36 * self.numSingleVesion, 0 * self.numSingleVesion, view.frame.size.width - 40 * self.numSingleVesion, 40 * self.numSingleVesion)];
        textField.borderStyle = UITextBorderStyleNone;
        [view addSubview: textField];
        textField.delegate = self;
        textField.placeholder = placordArr[i];
        textField.tag = 2200 + i;
        if (i == 1) {
            textField.frame = CGRectMake(36 * self.numSingleVesion, 0 * self.numSingleVesion , view.frame.size.width - 120 * self.numSingleVesion, 40 * self.numSingleVesion);
            self.authCodeView = [[AuthcodeView alloc] initWithFrame:CGRectMake(view.frame.size.width - 120 * self.numSingleVesion, 2.5 * self.numSingleVesion, 110 * self.numSingleVesion, 35 * self.numSingleVesion)];
            [view addSubview:self.authCodeView];
            
        }
        
        
        
    }
    
    height += 110 * self.numSingleVesion;
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(width, height, WIDTH_CONTROLLER - width * 2, 50 * self.numSingleVesion);
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(logInBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:SMSColor(214,61,59)];
    [self.view addSubview:nextBtn];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(42 * self.numSingleVesion, (10 + 18 + 18) * self.numSingleVesion + 64, (WIDTH_CONTROLLER - 84 * self.numSingleVesion), 45 * 2 * self.numSingleVesion)];
//    view.layer.cornerRadius = 4 * self.numSingleVesion;
//    view.layer.borderColor = [[UIColor colorWithRed:(CGFloat)213 / 255.0 green:(CGFloat)213 / 255.0 blue:(CGFloat)213 / 255.0 alpha:1] CGColor];
//    view.layer.borderWidth = 0.8 * self.numSingleVesion;
//    [self.view addSubview:view];
    
}
- (void)logInBtnDown{
    for (NSInteger i = 0; i < 2; i++) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:2200 + i];
        [textField resignFirstResponder];
        if (textField.text.length == 0) {
            if (i == 0) {
                [self.view makeToast:@"请填写账号"];
            }else{
                [self.view makeToast:@"请填写验证码"];
            }

        }else if (i == 1){
            if ([textField.text.lowercaseString isEqual:[self.authCodeView.authCodeStr lowercaseString]]) {
                [self requestMendPassword];
            }else{
                
                [self.view makeToast:@"请填写正确的验证码"];
            }
        }
    }
    
}
- (void)requestMendPassword{
    UITextField *tempText = (UITextField *)[self.view viewWithTag:2200];
    if (![tempText.text jugeTel]) {
        [self.view makeToast:@"请输入正确手机号"];
        return;
    }
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    NSString *url = [NSString stringWithFormat:FORGETPASSWORD,tempText.text];
    [twoPack getUrl:url andFinishBlock:^(id getResult) {
        if ([getResult[@"code"] isEqual:@"000000"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"短信发送成功,请按照短信提示进行修改密码!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [alert show];
        }else{
            [self.view makeToast:getResult[@"message"]];

        }
    }];
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
