//
//  AddAdressViewController.m
//  360du
//
//  Created by linghang on 15/7/11.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "AddAdressViewController.h"
#import "StoreageMessage.h"
#import "FileOperation.h"
#import "CommitOrderViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "UIView+Toast.h"
#import "NSString+URLEncoding.h"
#import "AddressModel.h"

@interface AddAdressViewController ()
@property(nonatomic,copy)NSString *addressStr;
@property(nonatomic,copy)NSString *menAndWomen;
@property(nonatomic,strong)NSMutableArray *addRessArr;
@property(nonatomic,strong)AddressModel *model;
//@property(nonatomic,weak)UITextField *textField;
@end

@implementation AddAdressViewController
-(id)initWithAddressArr:(NSArray *)addressArr andRow:(NSInteger)row andModel:(AddressModel *)model{
    self = [super init];
    if (self) {
#warning message
//        NSLog(@"addressArr:%@",addressArr);
        self.addressStr = [[StoreageMessage getStoreAddress] substringFromIndex:2];
        if (addressArr.count == 0) {
            [self makeNav:@"新增地址"];
        }else{
            [self makeNav:@"编辑地址"];
            self.addRessArr = [addressArr mutableCopy];
            self.model = model;
            [self deleteAddress:addressArr];
        }
        [self makeUI:addressArr];
    }
    return self;
}
-(void)makeNav:(NSString *)edit{
//    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian2222.png" AndHighlightedName:@""];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = edit;
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor blackColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
    
   
    //保存
    UIButton *favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    favoriteBtn.frame = CGRectMake(WIDTH_CONTROLLER - 0 * self.numSingleVesion - 0 * self.numSingleVesion, 5, 50 * self.numSingleVesion, 34);
    [favoriteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [favoriteBtn setTitle:@"保存" forState:UIControlStateNormal];
    favoriteBtn.titleLabel.font = [UIFont systemFontOfSize:15 * self.numSingleVesion];
    [favoriteBtn addTarget:self action:@selector(saveAddress) forControlEvents:UIControlEventTouchUpInside];
    favoriteBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:favoriteBtn];
//    rightItem.
//    [[UIBarButtonItem alloc]]
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)saveAddress{
    
    if (!_model.ID) {
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < 5; i++) {
        if (i == 1) {
            if ([self.menAndWomen isEqual:@"1"]) {
                [tempArr addObject:@"先生"];
            }else{
                [tempArr addObject:@"女士"];
            }
        }else{
            UITextField *textField = (UITextField *)[self.view viewWithTag:3000 + i];
            [tempArr addObject:textField.text];
            [textField resignFirstResponder];
        }
    }
    if (![self jugeTel:tempArr[4]]) {
        [self.view makeToast:@"请填写正确的手机号!"];
        return;
    }
//#define ADDADDRESS MAININTERFACE@"serviceServlet?serviceName=MyAccountXmlGenerator&medthodName=addressAddJson&memberID=%@&name=%@&sex=%@&xqName=%@&xqLocation=%@&address=%@&phone=%@"
//
//    NSString *commituty = @"京瑞大厦";
    AFNetworkTwoPackaging *network = [[AFNetworkTwoPackaging alloc] init];
//#define ADDADDRESS MAININTERFACE@"serviceServlet?serviceName=MyAccountXmlGenerator&medthodName=addressAddJson&memberID=%@&name=%@&sex=%@&xqName=%@&xqLocation=%@&address=%@&phone=%@"
    /**
     *  加入
     */
//    NSLog(@"2212121%@",[tempArr[2] urlEncodeString]);
   NSString *urlStr = [NSString stringWithFormat:ADDADDRESS,[StoreageMessage getMessage][2],[[tempArr[0] urlEncodeString] urlEncodeString],[[tempArr[1] urlEncodeString] urlEncodeString],[[tempArr[2] urlEncodeString] urlEncodeString],@"",[[tempArr[3] urlEncodeString] urlEncodeString],tempArr[4]];
#warning message
//    NSLog(@"urlStr:%@",urlStr);
    [network getUrl:urlStr andFinishBlock:^(id getResult) {
        if ([getResult[@"code"] isEqual:@"000000"]) {
            [self.view makeToast:@"添加地址成功!"];
            if ([self.target isKindOfClass:[CommitOrderViewController class]]) {
                [self.target refreshData];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self.view makeToast:@"添加地址失败!请完善您的信息"];

        }
    }];
        
        
        
        NSLog(@"arr:%@",_model);
        
    }else{
        
        NSLog(@"arr:%@",_model);

        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = 0; i < 5; i++) {
            if (i == 1) {
                if ([self.menAndWomen isEqual:@"1"]) {
                    [tempArr addObject:@"先生"];
                }else{
                    [tempArr addObject:@"女士"];
                }
            }else{
                UITextField *textField = (UITextField *)[self.view viewWithTag:3000 + i];
                [tempArr addObject:textField.text];
                [textField resignFirstResponder];
            }
        }
        if (![self jugeTel:tempArr[4]]) {
            [self.view makeToast:@"请填写正确的手机号!"];
            return;
        }

        NSString *urlStr = [NSString stringWithFormat:ADDRESSLISTUPDATE,[StoreageMessage getMessage][2],[[tempArr[0] urlEncodeString] urlEncodeString],[[tempArr[1] urlEncodeString] urlEncodeString],[[tempArr[2] urlEncodeString] urlEncodeString],[[tempArr[3] urlEncodeString] urlEncodeString],tempArr[4],_model.ID];
#warning message
        //    NSLog(@"urlStr:%@",urlStr);
        AFNetworkTwoPackaging *network = [[AFNetworkTwoPackaging alloc] init];

        [network getUrl:urlStr andFinishBlock:^(id getResult) {
            if ([getResult[@"code"] isEqual:@"000000"]) {
                [self.view makeToast:@"添加地址成功!"];
                if ([self.target isKindOfClass:[CommitOrderViewController class]]) {
                    [self.target refreshData];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self.view makeToast:@"添加地址失败!请完善您的信息"];
                
            }
        }];

    
    
    
    
    
    
    
    
    
    
    
    }
//    NSArray *keyArr = @[@"person",@"menAndWomen",@"address",@"houseNumber",@"telPhone"];
//    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithCapacity:0];
//    for (NSInteger i = 0; i < 5; i++) {
//        [mutDic setObject:tempArr[i] forKey:keyArr[i]];
//    }
//    
//    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//    BOOL cacheBool = [FileOperation jugeFileExist:@"address.txt" andPath:@"address" andDocument:cache];
//    NSMutableArray *adderArr = [NSMutableArray arrayWithCapacity:0];
//    NSString *addressTemp = nil;
//    if (cacheBool) {
//       NSString *pathStr = [FileOperation getCachePathFile:@"address.txt"  andPath:@"address" andDocument:cache];
//        NSArray *tempArr = [NSKeyedUnarchiver unarchiveObjectWithFile:pathStr];;
//        for (NSInteger i = 0; i < tempArr.count; i++) {
//            [adderArr addObject:tempArr[i]];
//        }
////#warning message
////        NSLog(@"mdoel:%@",self.model);
////        for (NSInteger i = 0; i < adderArr.count; i++) {
////            CommitOrderModel *mdoel = [[CommitOrderModel alloc] initWithDictionary:adderArr[i]];
////#warning message
////            NSLog(@"mdoel:%@",mdoel);
////            if ([mdoel.person isEqual:self.model.person] && [mdoel.menAndWomen isEqual:self.model.menAndWomen] && [mdoel.address isEqual:self.model.address] && [mdoel.houseNumber isEqual:self.model.houseNumber] && [mdoel.telPhone isEqual:self.model.telPhone]) {
////                 [adderArr removeObjectAtIndex:i];
////                i--;
////            }
////            
////        }
//        addressTemp = [FileOperation getCachePathFile:@"address.txt" andPath:@"address" andDocument:cache];
//    }else{
//        addressTemp = [FileOperation createCacheFile:@"address.txt" andPath:@"address" andDocument:cache];
//    }
//    [adderArr addObject:mutDic];
//
//    NSData *addressData = [NSKeyedArchiver archivedDataWithRootObject:adderArr];
//    
//    [FileOperation storeCacheDataFile:@"address.txt" andPath:@"address" andFileData:addressData andDocument:cache];
//    if ([self.target isKindOfClass:[CommitOrderViewController class]]) {
//        [self.target refreshData];
//    }
//    [self.navigationController popViewControllerAnimated:YES];
}
-(void)makeUI:(NSArray *)array{
    NSArray *temp = @[@"联系人",@"",@"小区名字",@"详细地址",@"手机"];
    NSArray *textFieldArr = @[@"您输入您的姓名",@"",@"请选择小区、大厦或学校",@"请输入门牌号等详细信息",@"请输入您的手机号"];
    if (self.addRessArr.count != 0) {
       textFieldArr = @[self.model.name,@"",self.model.xqName,self.model.address,self.model.phone];
//        NSLog(@"xqname:%@",self.model.xqName);
    }
    for (NSInteger i = 0; i < 5; i++) {
        UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.numSingleVesion, 64 + (50 - 15) / 2 * self.numSingleVesion + 50 * self.numSingleVesion * i, 60 * self.numSingleVesion, 15 * self.numSingleVesion)];
        leftLab.font = [UIFont systemFontOfSize:14];
        leftLab.textColor = [UIColor blackColor];
        leftLab.text = temp[i];
        [self.view addSubview:leftLab];
        if(i != 1){
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(70 * self.numSingleVesion, 64 + 50 * self.numSingleVesion * i + 10 * self.numSingleVesion, WIDTH_CONTROLLER - 90 * self.numSingleVesion, 30 * self.numSingleVesion)];
            textField.clearButtonMode = UITextFieldViewModeAlways;
            textField.tag = 3000 + i;
            if(self.addRessArr.count != 0){
                textField.text = textFieldArr[i];
            }else{
                textField.placeholder = textFieldArr[i];
            }
            
            [self.view addSubview:textField];
            if (i == 2) {
                textField.text = self.model.xqName;
            }else if (i == 4){
                textField.keyboardType = UIKeyboardTypeNumberPad;
            }
            textField.font = [UIFont systemFontOfSize:14];
        }else{
            NSArray *manAndWomenArr = @[@"先生",@"女士"];
            
            for (NSInteger j = 0; j < 2; j++) {
                UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                selectBtn.frame = CGRectMake(WIDTH_CONTROLLER / 4 + WIDTH_CONTROLLER / 2 * j, 64 + (50 - 18) / 2 * self.numSingleVesion + 50 * self.numSingleVesion * i, 18 * self.numSingleVesion, 18 * self.numSingleVesion);
                [selectBtn addTarget:self action:@selector(selectBtnDown:) forControlEvents:UIControlEventTouchUpInside];
                [selectBtn setImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
                selectBtn.tag = 1200 + j;
                [self.view addSubview:selectBtn];
                if (self.addRessArr.count != 0) {
                    if ([self.model.sex isEqualToString:@"先生"]) {
                        if(j == 0){
                            [selectBtn setImage:[UIImage imageNamed:@"确认"] forState:UIControlStateNormal];
                            self.menAndWomen = @"1";
                        }
                        
                    }else{
                        if(j == 1){
                            [selectBtn setImage:[UIImage imageNamed:@"确认"] forState:UIControlStateNormal];
                            self.menAndWomen = @"0";
                        }
                    }
                    
                }
                UILabel *menAndWomenLab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER / 4 + 18 * self.numSingleVesion + 5 * self.numSingleVesion + WIDTH_CONTROLLER / 2 * j,  64 + (50 - 15) / 2  * self.numSingleVesion + 50 * self.numSingleVesion * i, 50 * self.numSingleVesion, 15 * self.numSingleVesion)];
                menAndWomenLab.text = manAndWomenArr[j];
                menAndWomenLab.font = [UIFont systemFontOfSize:16];
                menAndWomenLab.textColor = [UIColor blackColor];
                [self.view addSubview:menAndWomenLab];
            }
            
        }
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + 50 * self.numSingleVesion + 50 * self.numSingleVesion * i - 1 * self.numSingleVesion, WIDTH_CONTROLLER, 1 * self.numSingleVesion)];
        lineLab.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:lineLab];
    }
}
-(void)selectBtnDown:(UIButton *)selectBtn{
    for (NSInteger i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:1200 + i];
        [btn setImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
    }
    if (selectBtn.tag == 1200) {
        self.menAndWomen = @"1";
    }else{
        self.menAndWomen = @"0";
    }
    [selectBtn setImage:[UIImage imageNamed:@"确认"] forState:UIControlStateNormal];
}
//删除地址
- (void)deleteAddress:(NSArray *)array{
    UIButton *delteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    delteBtn.frame = CGRectMake(40 * self.numSingleVesion, 5 * 50 * self.numSingleVesion + 20 * self.numSingleVesion + 64, WIDTH_CONTROLLER - 80 * self.numSingleVesion, 40 * self.numSingleVesion);
    [delteBtn setTitle:@"删除当前地址" forState:UIControlStateNormal];
    
    [delteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [delteBtn setBackgroundColor:[UIColor redColor]];
    [delteBtn addTarget:self action:@selector(deleteBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delteBtn];
}
- (void)deleteBtnDown:(UIButton *)delteBtn{
    for (NSInteger i = 0; i < 5; i++) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:3000 + i];
        [textField resignFirstResponder];
    }
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:DELEGATEADDRESS,[StoreageMessage getMessage][2],self.model.ID] andFinishBlock:^(id getResult) {
        if([getResult[@"code"] isEqual:@"000001"]){
            [self.view makeToast:getResult[@"message"]];
            return ;
        }
        if ([self.target isKindOfClass:[CommitOrderViewController class]]) {
            [self.target refreshData];
            
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark 判断是不是手机号
-(BOOL)jugeTel:(NSString *)telPhone{
    //手机号以13， 15，18开头，八个 \d 数字字符
    // NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:telPhone];
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
