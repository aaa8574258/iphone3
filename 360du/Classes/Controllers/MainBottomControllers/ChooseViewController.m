//
//  ChooseViewController.m
//  360du
//
//  Created by 利美 on 16/4/22.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ChooseViewController.h"
#import "AddrFirstTableViewController.h"
#import "CleanerPublishTwoTableViewController.h"
#import "PaiXTableViewController.h"
#import "CleanerViewController.h"
#import "SendMessage.h"
@interface ChooseViewController ()<popString,sendAddr,sendLeiX>
@property (weak, nonatomic) IBOutlet UIButton *chooseAddr;
@property (weak, nonatomic) IBOutlet UIButton *chooseLeiX;
@property (weak, nonatomic) IBOutlet UIButton *chooseP;
@property (weak, nonatomic) IBOutlet UITextField *infoText;

@end

@implementation ChooseViewController


-(void)viewWillAppear:(BOOL)animated{
    
    if ([SendMessage shareInstance].singleValue) {
        
        //    }<#statements#>
        NSLog(@"12121212%@",[SendMessage shareInstance].singleValue);
        //    if (!self.chooseName) {
        self.addr = [SendMessage shareInstance].singleValue;
        self.addrId = [SendMessage shareInstance].singleCode;
        [self.chooseAddr setTitle:_addr forState:UIControlStateNormal];
    }
    if (self.chooseAddr.titleLabel.text == nil) {
        [self.chooseAddr setTitle:@"请选择区域" forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SendMessage shareInstance].singleValue = nil;
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"landi.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 40);
    [leftBtn setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    
    [_chooseAddr addTarget:self action:@selector(chooseAddrAction) forControlEvents:UIControlEventTouchUpInside];
    [_chooseLeiX addTarget:self action:@selector(chooseLeiXAction) forControlEvents:UIControlEventTouchUpInside];
    [_chooseP addTarget:self action:@selector(choosePAction) forControlEvents:UIControlEventTouchUpInside];
    
//    NSLog(@"leixing%ld",(long)self.PaiXId);
//    NSLog(@"%@2222%@3333%@",_addrId,_leiXId,_PaiXId);
//    _bodyDic = [[NSDictionary alloc]init];
////    _bodyDic = @{@"qycode":_addrId,@"twoType":_leiXId,@"sortType":_PaiXId};
//    if (_addrId == nil || _leiXId == nil || _PaiXId) {
//        
//    }else{
//    [_bodyDic setValuesForKeysWithDictionary:@{@"qycode":_addrId,@"twoType":_leiXId,@"sortType":_PaiXId}];
//    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

- (void)chooseAddrAction{
    AddrFirstTableViewController *addrf = [[AddrFirstTableViewController alloc]init];
    
    addrf.sendAddrDelegate = self;
    [self.navigationController pushViewController:addrf animated:YES];


}

- (void)chooseLeiXAction{
    CleanerPublishTwoTableViewController *two = [[CleanerPublishTwoTableViewController alloc]init];
    //    UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
    //
    //    CleanerPublishTwoTableViewController *two = [cleanerSB instantiateViewControllerWithIdentifier:@"publishTwo"];
    //    two.delegate = self;
    two.delegate = self;
    
    
    
    [self.navigationController pushViewController:two animated:YES];

    
}

- (void)choosePAction{
    PaiXTableViewController  *PaiX = [[PaiXTableViewController alloc]init];
//    [self.chooseP setTitle:self.leiX forState:UIControlStateNormal];
    PaiX.LeiXdelegate = self;
    [self.navigationController pushViewController:PaiX animated:YES];
    
}

-(void) sendLeiX:(NSString *)string andCode:(NSString *)code{
    [self.chooseP  setTitle:string forState:UIControlStateNormal];
    self.PaiX = string;
    self.PaiXId = code;
}

//
//-(void) sendAddr:(NSString *)string andCode:(NSString *)code{
//    [self.chooseAddr setTitle:string forState:UIControlStateNormal];
//    self.addr = string;
//    self.addrId = code;
//}

-(void)popString:(NSString *)String andCode:(NSString *)code{
    [self.chooseLeiX setTitle:String forState:UIControlStateNormal];
    self.leiX = String;
    self.leiXId = code;
}


-(void)setBack{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)makeOKButtonAction:(UIButton *)sender {
//    UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
//    
//    CleanerViewController *cleanerViewController = [cleanerSB instantiateViewControllerWithIdentifier:@"cleaner"];
//    cleanerViewController.addrId = _addrId;
//    cleanerViewController.leiXId = _leiXId;
//    cleanerViewController.PaiXId = _PaiXId;
//    
//    cleanerViewController.search = self.infoText.text;
//    [self.navigationController showViewController:cleanerViewController sender:nil];
    
    //    NSLog(@"1  %@  %@",self.taget,self.keywordTextF.text);
    if (self.infoText.text.length == 0) {
        self.infoText.text = nil;
    }
    [self.target searchIOPWithxqid:nil andqyCode:_addrId andsortType:_PaiXId andTwoType:_leiXId andlocation:nil andkeyWord:self.infoText.text];
//    if (_qyCode == nil) {
//        _qyCode = @"0";
//    }if (_zjCode == nil) {
//        _zjCode = @"0";
//    }if (_hxCode == nil) {
//        _hxCode = @"0";
//    }if (_lyCode == nil) {
//        _lyCode = @"0";
//    }if (_lxCode == nil) {
//        _lxCode = @"0";
//    }if (_lcCode == nil) {
//        _lcCode = @"0";
//    }if (_cxCode == nil) {
//        _cxCode = @"0";
//    }
//    [self.]
//    NSLog(@"%@",_lyCode);
//    [self.taget  chooseGetqyCode:self.qyCode andzjcode:self.zjCode andhxCode:self.hxCode andlyCode:self.lyCode andlxCode:self.lxCode andlcCode:self.lcCode andcxCode:self.cxCode andkeyword:self.keywordTextF.text];
    [self.navigationController popViewControllerAnimated:YES];
//    }
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
