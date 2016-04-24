//
//  ProertyMiddleWaterViewController.m
//  360du
//
//  Created by linghang on 15/11/24.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "ProertyMiddleWaterViewController.h"
#import "StoreageMessage.h"
#import "SelectCityViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "ProertyAddAddressViewController.h"
#import "UIView+Toast.h"
#import "ProertyMiddlePayAddressListModel.h"
#import "NSString+URLEncoding.h"
#import "ProertyMiddlePayAddressListViewController.h"
#import "ProertyMoneyViewController.h"
@interface ProertyMiddleWaterViewController ()
@property(nonatomic,weak)UILabel *addressLab;
@property(nonatomic,strong)NSMutableArray *addressListArr;
@property(nonatomic,copy)NSString *xhid;
@property(nonatomic,copy)NSString *accountTime;
@property(nonatomic,assign)BOOL isDateBool;
@property(nonatomic,weak)UIDatePicker *datePicker;

@end

@implementation ProertyMiddleWaterViewController
- (id)init{
    self = [super init];
    if (self) {
        self.isDateBool = NO;
        self.addressListArr = [NSMutableArray arrayWithCapacity:0];
        [self makeNav];
        [self makeUI];
        [self loadData];
        [self makeDatePicker];
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
    lable.text = @"新增缴费用户";
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
    [rightBtn setTitle:[StoreageMessage getCity] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    

}
- (void)rightBtnDown{
    SelectCityViewController *selectCity = [[SelectCityViewController alloc] init];
    [self.navigationController pushViewController:selectCity animated:YES];
}
- (void)makeUI{
    NSArray *tempArr = @[@"新增地址",@"账期  "];
    for (NSInteger i = 0; i < tempArr.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 80 * i, WIDTH_CONTROLLER, 50 * self.numSingleVesion)];
        //view.backgroundColor = SMSColor(199, 199, 199);
        view.layer.borderWidth = 1 * self.numSingleVesion;
        view.layer.borderColor = [SMSColor(211, 211, 211) CGColor];
        [self.view addSubview:view];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER - 100 * self.numSingleVesion - 18 * self.numSingleVesion, (60 * self.numSingleVesion - 20 * self.numSingleVesion) / 2, 18 * self.numSingleVesion, 20 * self.numSingleVesion)];
        lable.text = tempArr[i];
        lable.font = [UIFont systemFontOfSize:14];
        lable.textColor = SMSColor(51, 51, 51);
//        if (i == 0) {
//            lable.frame = CGRectMake(10 * self.numSingleVesion,17.5 * self.numSingleVesion, WIDTH_CONTROLLER - 40 * self.numSingleVesion, 15 * self.numSingleVesion);
//        }else{
//            //[lable sizeToFit];
//            lable.center = CGPointMake(10 * self.numSingleVesion + lable.frame.size.width / 2, 25 * self.numSingleVesion);
//        }
        lable.frame = CGRectMake(10 * self.numSingleVesion,17.5 * self.numSingleVesion, WIDTH_CONTROLLER - 40 * self.numSingleVesion, 15 * self.numSingleVesion);
        [view addSubview:lable];
        
        if (i == 0) {
            self.addressLab = lable;
        }

        
        UIImageView *arroeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER - 100 * self.numSingleVesion - 18 * self.numSingleVesion, (60 * self.numSingleVesion - 20 * self.numSingleVesion) / 2, 18 * self.numSingleVesion, 20 * self.numSingleVesion)];
        arroeImgView.image = [UIImage imageNamed:@"下一步.png"];
        arroeImgView.center = CGPointMake(WIDTH_CONTROLLER - 10 * self.numSingleVesion - 9 * self.numSingleVesion, 25 * self.numSingleVesion);
        [view addSubview:arroeImgView];

        if (i == 1) {
            UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectZero];
            timeLab.text = @"请选择配送时间";
            timeLab.font = [UIFont systemFontOfSize:12];
            [timeLab sizeToFit];
            timeLab.textColor = SMSColor(151, 151, 151);
            timeLab.center = CGPointMake(WIDTH_CONTROLLER - ( 40 * self.numSingleVesion + timeLab.frame.size.width / 2), 25 * self.numSingleVesion);
            timeLab.tag = 2300;
            [view addSubview:timeLab];
        }
        UIButton *buttom = [UIButton buttonWithType:UIButtonTypeCustom];
        buttom.frame = view.bounds;
        [view addSubview:buttom];
        [buttom setTitle:@"" forState:UIControlStateNormal];
        buttom.tag = 1200 + i;
        [buttom addTarget:self action:@selector(nextBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame = CGRectMake(25 * self.numSingleVesion, 150 * self.numSingleVesion + 64, WIDTH_CONTROLLER - 50 * self.numSingleVesion, 50 * self.numSingleVesion);
    [payBtn setBackgroundColor:[UIColor redColor]];
    [payBtn addTarget:self action:@selector(nextBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payBtn];
    [payBtn setTitle:@"去交费" forState:UIControlStateNormal];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payBtn.tag = 1202;
}
- (void)nextBtnDown:(UIButton *)nextBtn{
    switch (nextBtn.tag - 1200) {
        case 0:{
            if (self.addressListArr.count == 0) {
                ProertyAddAddressViewController *ctrl = [[ProertyAddAddressViewController alloc] initWithPayAddressListModel:nil];
                ctrl.target = self;
                [self.navigationController pushViewController:ctrl animated:YES];
            }else{
                ProertyMiddlePayAddressListViewController *middlePayAddressList = [[ProertyMiddlePayAddressListViewController alloc] initWithAddressListArr:self.addressListArr];
                middlePayAddressList.target = self;
                [self.navigationController pushViewController:middlePayAddressList animated:YES];
            }
            

            break;
        }
        case 1:{//去选择时间
            
            if (!self.isDateBool) {
                self.datePicker.hidden = NO;
            }else{
                self.datePicker.hidden = YES;
            }
            self.isDateBool = !self.isDateBool;
            break;
        }
        case 2:{
            if (self.xhid.length == 0) {
                [self.view makeToast:@"请添加地址"];
                break;
            }
            if (self.accountTime.length == 0) {
                [self.view makeToast:@"请选择时间"];
            }
            ProertyMoneyViewController *money = [[ProertyMoneyViewController alloc] initWithXid:self.xhid andAccounttime:self.accountTime];
            [self.navigationController pushViewController:money animated:YES];
            break;
        }
        default:
            break;
    }
}
- (void)loadData{
    [self makeHUd];
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:PROERTYMIDLLEPAYADDRESSLIST,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        if (![getResult[@"code"] isEqual:@"000000"]) {
            return ;
        }
        [self.addressListArr removeAllObjects];
        for (NSInteger i = 0; i < [getResult[@"datas"] count]; i++) {
            ProertyMiddlePayAddressListModel *model = [[ProertyMiddlePayAddressListModel alloc] initWithDictionary:getResult[@"datas"][i]];
            [self.addressListArr addObject:model];
            if ([model.isDefault isEqual:@"Y"]) {
                NSMutableString *tempStr = [NSMutableString stringWithCapacity:0];
                self.xhid = model.xhid;
                NSArray *valueArr = @[model.UnitNo,model.builde,model.houseNo];
                NSArray *keyArr = @[@"栋",@"单元",@"号"];
                for (NSInteger i = 0; i < keyArr.count; i++) {
                    [tempStr appendString:[NSString stringWithFormat:@"%ld",[valueArr[i] integerValue]]];
                    [tempStr appendString:keyArr[i]];
                }
                self.addressLab.text = [NSString stringWithFormat:@"%@  %@ %@\n%@  %@",[model.nickName URLDecodedString],model.phone,model.wyName,model.xqName,tempStr];
            }
        }
        //NSLog(@"getResult%@",getResult);
        //self.addressLab.text = getResult[@"message"];
        //[self.addressLab sizeToFit];
        self.addressLab.frame = CGRectMake(10 * self.numSingleVesion, 5 * self.numSingleVesion, WIDTH_CONTROLLER - 40 * self.numSingleVesion, 45 * self.numSingleVesion);
        self.addressLab.numberOfLines = 2;
    }];
}
//返回地址
- (void)getAddress:(NSString *)address andAddressId:(NSString *)addressId{
    
}
//默认缴费信息
- (void)gainDefaultAddress:(ProertyMiddlePayAddressListModel *)model{
    NSMutableString *tempStr = [NSMutableString stringWithCapacity:0];
    NSArray *valueArr = @[model.UnitNo,model.builde,model.houseNo];
    NSArray *keyArr = @[@"栋",@"单元",@"号"];
    for (NSInteger i = 0; i < keyArr.count; i++) {
        [tempStr appendString:[NSString stringWithFormat:@"%ld",[valueArr[i] integerValue]]];
        [tempStr appendString:keyArr[i]];
    }
    self.addressLab.text = [NSString stringWithFormat:@"%@  %@ %@\n%@  %@",[model.nickName URLDecodedString],model.phone,model.wyName,model.xqName,tempStr];
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:PERSONALDEFAULTPAYPERSONAL,[StoreageMessage getMessage][2],model.hmid] andFinishBlock:^(id getResult) {
        
    }];

}
//返回地址
- (void)getAddressNickName:(NSString *)nickName andTelPhone:(NSString *)telPhonr andWqName:(NSString *)wqName andXqName:(NSString *)xqName andAdressDetail:(NSString *)addressDeatil{
    [self loadData];
}
//makeDatePicker
-(void)makeDatePicker{
    UIDatePicker *datePick = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER - 200 * self.numSingleVesion, WIDTH_CONTROLLER, 200 * self.numSingleVesion)];
    [datePick addTarget:self action:@selector(datePickDown) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePick];
    datePick.datePickerMode = UIDatePickerModeDate;
    NSDate *date = [NSDate date];
    [datePick setMinimumDate:date];
    self.datePicker = datePick;
    datePick.hidden = YES;
    
    //datePick.datePickerMode = UIDatePickerModeCountDownTimer;
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)datePickDown{
    NSDate *select = [self.datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月"];
    NSString *dateAndTime = [dateFormatter stringFromDate:select];
    //self.textField.text = dateAndTime;
    UILabel *timeLab = (UILabel *)[self.view viewWithTag:2300];
    timeLab.text = dateAndTime;
    [timeLab sizeToFit];
    self.accountTime = dateAndTime;
    timeLab.center = CGPointMake(WIDTH_CONTROLLER - ( 40 * self.numSingleVesion + timeLab.frame.size.width / 2), 25 * self.numSingleVesion);
    NSLog(@"%@",dateAndTime);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.datePicker.hidden = YES;
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
