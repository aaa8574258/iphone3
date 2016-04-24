//
//  MerchantLoginViewController.m
//  360du
//
//  Created by linghang on 15/12/12.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "MerchantLoginViewController.h"
#import "UIView+Toast.h"
#import "StoreageMessage.h"
#import "MD5SixTeen.h"
#import "NSString+URLEncoding.h"
#import "MerchantViewController.h"
#import "ForgetPasswordViewController.h"
@interface MerchantLoginViewController ()<UITextFieldDelegate>

@end

@implementation MerchantLoginViewController

- (id)init{
    self = [super init];
    if (self) {
        [self makeUI];
 
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [self makeNav];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
-(void)makeNav{
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    //[self setNavTitleItemWithNameAndImage:@"登陆" imageName:@"360.png"];
    [self setNavTitleItemWithName:@"商家登陆"];
    
    //    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"注册"style:UIBarButtonItemStylePlain target:self action:@selector(leftDown)];
    //    self.navigationItem.rightBarButtonItem = leftItem;
    
    
   
}
-(void)makeUI{
    NSArray *array = @[@"login_user.png",@"login_lock.png"];
    NSArray *placeArr = @[@"请输入手机号",@"请输入密码"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(42 * self.numSingleVesion, 64 + 24 * self.numSingleVesion , (WIDTH_CONTROLLER - 84 * self.numSingleVesion), 45 * self.numSingleVesion * 2)];
    view.layer.cornerRadius = 4;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [[UIColor colorWithRed:(CGFloat)204 / 255.0 green:(CGFloat)204 / 255.0 blue:(CGFloat)204 / 255.0 alpha:1] CGColor];
    [self.view addSubview:view];;
    for (NSInteger i = 0; i < array.count; i++) {
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(26 * self.numSingleVesion + 2,  45 * self.numSingleVesion * i, (WIDTH_CONTROLLER - 84 * self.numSingleVesion - 26 * self.numSingleVesion), 45 * self.numSingleVesion)];
        textField.borderStyle = UITextBorderStyleNone;
        textField.clearButtonMode = UITextFieldViewModeAlways;
        if (i == 0) {
            textField.keyboardType = UIKeyboardTypeDefault;
        }
        if (i == 1) {
            textField.secureTextEntry = YES;
        }
        textField.delegate = self;
        textField.tag = 1300 + i;
        [view addSubview:textField];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, (45 - 28 / 2) / 2* self.numSingleVesion + 45 * self.numSingleVesion * i, 26  / 2 * self.numSingleVesion, 28 / 2* self.numSingleVesion)];
        imageView.image = [UIImage imageNamed:array[i]];
        [view addSubview:imageView];
        textField.placeholder = placeArr[i];
    }
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45 * self.numSingleVesion, view.frame.size.width, 1)];
    line.image = [UIImage imageNamed:@"line.png"];
    [view addSubview:line];
    //登陆
    UIButton *logInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logInBtn.frame = CGRectMake(42 * self.numSingleVesion, view.frame.size.height + 64 + 20 + 24 * self.numSingleVesion, (WIDTH_CONTROLLER - 84 * self.numSingleVesion), 45 * self.numSingleVesion);
    [logInBtn setBackgroundImage:[UIImage imageNamed:@"topbg.gif"] forState:UIControlStateNormal];
    [logInBtn addTarget:self action:@selector(logInBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    logInBtn.tag = 1800;
    [logInBtn setTitle:@"登陆" forState:UIControlStateNormal];
    logInBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:logInBtn];
    
//    //忘记密码
//    UIButton *forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    forgetPasswordBtn.translatesAutoresizingMaskIntoConstraints = NO;
//    [forgetPasswordBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
//    [forgetPasswordBtn setTitleColor:[UIColor colorWithRed:(CGFloat)51 / 255.0 green:(CGFloat)51 / 255.0 blue:(CGFloat)51 / 255.0 alpha:1] forState:UIControlStateNormal];
//    forgetPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
//    [forgetPasswordBtn.titleLabel sizeToFit];
//    [forgetPasswordBtn addTarget:self action:@selector(logInBtnDown:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:forgetPasswordBtn];
//    forgetPasswordBtn.tag = 1801;
//    
//    NSArray *widthForgetPasswordContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[forgetPasswordBtn]-42-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(forgetPasswordBtn)];
//    NSArray *heightForgetPasswordContranints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[logInBtn]-[forgetPasswordBtn(==20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(forgetPasswordBtn,logInBtn)];
//    [self.view addConstraints:widthForgetPasswordContraints];
//    [self.view addConstraints:heightForgetPasswordContranints];
//    
    
}
-(void)logInBtnDown:(UIButton *)logInAndRegister{
    if(logInAndRegister.tag == 1800){
        UITextField *userName = (UITextField *)[self.view viewWithTag:1300];
        UITextField *passWord = (UITextField *)[self.view viewWithTag:1301];
        [userName resignFirstResponder];
        [passWord resignFirstResponder];
        if (userName.text.length == 0 ) {
            [self.view makeToast:@"请输入商家名!"];
            return;
        }
        if (passWord.text.length == 0) {
            [self.view makeToast:@"请输入密码,密码不能为空!"];
            return;
        }
        
        AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
        NSLog(@"url%@",[NSString stringWithFormat:MERCHANTLOGIN,[userName.text urlEncodeString],[MD5SixTeen md5:passWord.text],[StoreageMessage getMessage][2]]);
        [twoPacking getUrl:[NSString stringWithFormat:MERCHANTLOGIN,[userName.text urlEncodeString],[MD5SixTeen md5:passWord.text],[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
            NSLog(@"getResult:%@",getResult);
            NSDictionary *dict = getResult;
            if ([dict[@"code"] integerValue] == 000000) {
                [StoreageMessage storeMerchantUserName:dict[@"userName"] andPassWord:[MD5SixTeen md5:passWord.text] andMemerId:dict[@"did"] ];
                [self.view makeToast:@"登陆成功!"];
                MerchantViewController *merchantView = [[MerchantViewController alloc] init];
                [self.navigationController pushViewController:merchantView animated:YES];
                
            }else{
                [self.view makeToast:dict[@"message"]];
            }
            
            
        }];
    }else{
        ForgetPasswordViewController *forgetPassword = [[ForgetPasswordViewController alloc] init];
        [self.navigationController pushViewController:forgetPassword animated:YES];
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
