//
//  ProertyAddAddressViewController.m
//  360du
//
//  Created by linghang on 15/11/24.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "ProertyAddAddressViewController.h"
#import "StoreageMessage.h"
#import "ProertyCommunityListModel.h"
#import "ProertyAddressListViewController.h"
#import "UIView+Toast.h"
#import "ProertyAddressDetailViewController.h"
#import "NSString+NSString.h"
#import "AFNetworkTwoPackaging.h"
#import "NSString+URLEncoding.h"
#import "ProertyMiddlePayAddressListModel.h"
#import "ProertyMiddlePayAddressListViewController.h"
#import "ProertyMiddleWaterViewController.h"
@interface ProertyAddAddressViewController ()<UITextFieldDelegate>
@property(nonatomic,copy)NSString *regionId;
@property(nonatomic,copy)NSString *xqId;
@property(nonatomic,copy)NSString *xhId;
@property(nonatomic,strong)ProertyMiddlePayAddressListModel *model;
@end

@implementation ProertyAddAddressViewController
- (id)initWithPayAddressListModel:(ProertyMiddlePayAddressListModel *)model{
    self = [super init];
    if (self) {
        if (model != nil) {
            self.model = model;
        }
        [self makeNav];
        [self makeUI];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"新增地址";
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
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnDown) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}
- (void)rightBtnDown{
    UITextField *textField2 = (UITextField *)[self.view viewWithTag:2604];
    UITextField *textField1 = (UITextField *)[self.view viewWithTag:2600];
    [textField2 resignFirstResponder];
    [textField1 resignFirstResponder];
    //判断昵称是不是为空
    if (textField1.text.length == 0) {
        [self.view makeToast:@"请填写昵称"];
        return;
    }
    //判断是不是手机号
    if (![textField2.text jugeTel]) {
        [self.view makeToast:@"请填写正确手机号"];
        return;
    }
    //判断物业、小区
    if (self.xqId.length == 0 && self.model == nil) {
        [self.view makeToast:@"请选择小区"];
        self.xqId = @"";
        self.regionId = @"";
        return;
    }    //判断详细地址
    if (self.xhId.length == 0 && self.model == nil) {
        [self.view makeToast:@"请选择详细地址"];
        return;
    }else if (self.xhId.length == 0 && self.model != nil){
        self.xhId = self.model.xhid;
    }
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    //http://211.152.8.99/360duang/serviceServlet?serviceName=PaymentWater&medthodName=addWaterAddress&nickName=我家&xqID=86420010000009&wyBranchcode=86440000017&phone=14714151521&memberID=26227&xhID=3
    
    NSString *url = [NSString stringWithFormat:PROERTYADDPERSONALINFORAMTION,[[textField1.text urlEncodeString] urlEncodeString],self.xqId,self.regionId,textField2.text,[StoreageMessage getMessage][2],self.xhId];
    if (self.model != nil) {
//#define PROERTYMENDPERSONALINFORMATION MAININTERFACE@"serviceServlet?serviceName=PaymentWater&medthodName=updateAddress&hmid=%@&nickName=%@&xqID=%@&wyBranchcode=%@&phone=%@&memberID=%@&xhID=%@"

        url = [NSString stringWithFormat:PROERTYMENDPERSONALINFORMATION,self.model.hmid,[[textField1.text urlEncodeString] urlEncodeString],self.xqId,self.regionId,textField2.text,[StoreageMessage getMessage][2],self.xhId];
    }
    [twoPack getUrl:url andFinishBlock:^(id getResult) {
        NSLog(@"getResult:%@",getResult);
        if ([getResult[@"code"] isEqual:@"000000"]) {
            if (self.model != nil) {
                if ([self.target isKindOfClass:[ProertyMiddlePayAddressListViewController class]]) {
                    [self.target addAddress];
                    [self.navigationController popViewControllerAnimated:YES];

                    
                }
            }
            if ([self.target isKindOfClass:[ProertyMiddleWaterViewController class]]){
                [self.target getAddressNickName:textField1.text andTelPhone:textField2.text andWqName:@"" andXqName:@"" andAdressDetail:@""];
                [self.navigationController popViewControllerAnimated:YES];

            }
        }
        
    }];
}
- (void)makeUI{
    NSArray *titileArr = @[@"  昵称:",@"小区名称:",@"缴费单位:",@"详细地址:",@" 手机号:"];
    for (NSInteger i = 0; i < titileArr.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 50 * i, WIDTH_CONTROLLER, 40 * self.numSingleVesion)];
        //view.backgroundColor = SMSColor(199, 199, 199);
        [self.view addSubview:view];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER - 100 * self.numSingleVesion - 18 * self.numSingleVesion, (60 * self.numSingleVesion - 20 * self.numSingleVesion) / 2, 18 * self.numSingleVesion, 20 * self.numSingleVesion)];
        lable.text = titileArr[i];
        lable.font = [UIFont systemFontOfSize:14];
        lable.textColor = SMSColor(51, 51, 51);
        [lable sizeToFit];
        lable.center = CGPointMake(10 * self.numSingleVesion + lable.frame.size.width / 2, 20 * self.numSingleVesion);
        [view addSubview:lable];
        
//        if (i == 0) {
//            self.addressLab = lable;
//        }
        
        if (i == 1 || i == 2 || i ==3) {
            UIImageView *arroeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER - 100 * self.numSingleVesion - 18 * self.numSingleVesion, (60 * self.numSingleVesion - 20 * self.numSingleVesion) / 2, 18 * self.numSingleVesion, 20 * self.numSingleVesion)];
            arroeImgView.image = [UIImage imageNamed:@"下一步.png"];
            arroeImgView.center = CGPointMake(WIDTH_CONTROLLER - 10 * self.numSingleVesion - 9 * self.numSingleVesion, 20 * self.numSingleVesion);
            [view addSubview:arroeImgView];
        }
        
        
        
        //主要是写右边小区名称、缴费单位、详细地址
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectZero];
        timeLab.font = [UIFont systemFontOfSize:12];
        timeLab.textColor = SMSColor(151, 151, 151);
        [view addSubview:timeLab];
        timeLab.tag = 2200 + i;
        if (i == 1) {
            timeLab.text = @"请选择你所需的小区";
            if (self.model != nil) {
                timeLab.text = self.model.xqName;
            }
            [timeLab sizeToFit];
            timeLab.center = CGPointMake(WIDTH_CONTROLLER - ( 40 * self.numSingleVesion + timeLab.frame.size.width / 2), 20 * self.numSingleVesion);
        }else if (i == 3){
            timeLab.text = @"请选择详细地址";
            if (self.model != nil) {
                NSMutableString *tempStr = [NSMutableString stringWithCapacity:0];
                NSArray *valueArr = @[self.model.UnitNo,self.model.builde,self.model.houseNo];
                NSArray *keyArr = @[@"栋",@"单元",@"号"];
                for (NSInteger i = 0; i < keyArr.count; i++) {
                    [tempStr appendString:[NSString stringWithFormat:@"%ld",[valueArr[i] integerValue]]];
                    [tempStr appendString:keyArr[i]];
                }
                timeLab.text = tempStr;
            }
            [timeLab sizeToFit];
            timeLab.center = CGPointMake(WIDTH_CONTROLLER - ( 40 * self.numSingleVesion + timeLab.frame.size.width / 2), 20 * self.numSingleVesion);
        }else if (i == 2){
            if (self.model != nil) {
                timeLab.text = self.model.wyName;
                [timeLab sizeToFit];
                timeLab.center = CGPointMake(WIDTH_CONTROLLER - ( 40 * self.numSingleVesion + timeLab.frame.size.width / 2), 20 * self.numSingleVesion);
            }
        }
        //}else if (i == 3){
//            UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectZero];
//            timeLab.text = @"请选择详细地址";
//            timeLab.font = [UIFont systemFontOfSize:12];
//            [timeLab sizeToFit];
//            timeLab.textColor = SMSColor(151, 151, 151);
//            timeLab.center = CGPointMake(WIDTH_CONTROLLER - ( 40 * self.numSingleVesion + timeLab.frame.size.width / 2), 20 * self.numSingleVesion);
//            [view addSubview:timeLab];
//        }
        //输入框
        if (i == 0 || i == 4) {
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion + lable.frame.size.width + 10 * self.numSingleVesion, 5 * self.numSingleVesion, WIDTH_CONTROLLER - 10 * self.numSingleVesion - 20 * self.numSingleVesion - lable.frame.size.width, 30 * self.numSingleVesion)];
            textField.borderStyle = UITextBorderStyleRoundedRect;
            [view addSubview:textField];
            textField.userInteractionEnabled = YES;
            textField.tag = 2600 + i;
            textField.clearButtonMode = UITextFieldViewModeAlways;
            if (i == 4) {
                textField.text = [StoreageMessage getMessage][0];
            }
            if (self.model != nil) {
                if (i == 0) {
                    textField.text = [self.model.nickName URLDecodedString];
                }else{
                    textField.text = self.model.phone;
                }
            }
        }else{
            if(i != 0 || i != 4){
                UIButton *buttom = [UIButton buttonWithType:UIButtonTypeCustom];
                buttom.frame = view.bounds;
                [view addSubview:buttom];
                [buttom setTitle:@"" forState:UIControlStateNormal];
                buttom.tag = 1200 + i;
                [buttom addTarget:self action:@selector(nextBtnDown:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
}
- (void)nextBtnDown:(UIButton *)nextBtn{
    switch (nextBtn.tag - 1200) {
        case 1:{
            //ctrl = (ProertyAddressListViewController *);
           ProertyAddressListViewController *ctrl = [[ProertyAddressListViewController alloc] initWithCityName:@""];
            ctrl.target = self;
            [self.navigationController pushViewController:ctrl animated:YES];

            break;
        }
        case 2:{
            
            break;
        }
        case 3:{
            
            if (self.xqId.length == 0 && self.model == nil) {
                [self.view makeToast:@"请选择小区"];
            }else{
                ProertyAddressDetailViewController *addressDetail = [[ProertyAddressDetailViewController alloc] initWithXQId:self.xqId];
                addressDetail.target = self;
                [self.navigationController pushViewController:addressDetail animated:YES];
            }
            break;
        }
        default:
            break;
    }
}
//返回小区ID
- (void)returnCommitutyId:(ProertyCommunityListModel *)listModel andRegionId:(ProertyCommunityListDetailModel *)detailModel{
    UILabel *communityName = (UILabel *)[self.view viewWithTag:2200 + 1];
    communityName.text = detailModel.xqname;
    [communityName sizeToFit];
    communityName.center = CGPointMake(WIDTH_CONTROLLER - ( 40 * self.numSingleVesion + communityName.frame.size.width / 2), 20 * self.numSingleVesion);

    UILabel *companyName = (UILabel *)[self.view viewWithTag:2200 + 2];
    companyName.text = listModel.wyName;
    [companyName sizeToFit];
    companyName.center = CGPointMake(WIDTH_CONTROLLER - ( 40 * self.numSingleVesion + companyName.frame.size.width / 2), 20 * self.numSingleVesion);
    self.regionId = listModel.wyBranchcode;
    self.xqId = detailModel.xqBranchcode;
}
//返回多少栋，号
- (void)returnHouseNum:(NSString *)houseStr andHouseId:(NSString *)hosueId{
    UILabel *communityName = (UILabel *)[self.view viewWithTag:2200 + 3];
    communityName.text = houseStr;
    [communityName sizeToFit];
    communityName.center = CGPointMake(WIDTH_CONTROLLER - ( 40 * self.numSingleVesion + communityName.frame.size.width / 2), 20 * self.numSingleVesion);
    self.xhId = hosueId;
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