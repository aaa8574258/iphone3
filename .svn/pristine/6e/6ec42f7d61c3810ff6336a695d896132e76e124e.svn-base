//
//  FoodMerchantGoodsDeatilViewController.m
//  360du
//
//  Created by linghang on 15/9/2.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "FoodMerchantGoodsDeatilViewController.h"
#import "FoodMerchatListModel.h"
#import "UIImageView+WebCache.h"
#import "ComplexMethod.h"
#import "AFNetworkTwoPackaging.h"
#import "StoreageMessage.h"
#import "UIView+Toast.h"
#import "GroupPurchaseItemView.h"
#import "FoodBussinessListCollectionViewController.h"
@interface FoodMerchantGoodsDeatilViewController ()
@property(nonatomic,strong)FoodMerchatListItemModel *model;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIButton *reduceBtn;
@property(nonatomic,strong)UILabel *buyCount;
@property(nonatomic,assign)NSInteger numCount;
@property(nonatomic,weak)UILabel *descLab;
@property(nonatomic,copy)NSString *procudeId;
@property(nonatomic,assign)NSInteger clickNum;
@property(nonatomic,strong)NSMutableArray *addArr;
//@property(nonatomic,copy)NSString *tempStr;
@end

@implementation FoodMerchantGoodsDeatilViewController
- (id)initWithItemModel:(FoodMerchatListItemModel *)model andPrudctId:(NSString *)produceId{
    self = [super init];
    if (self) {
//        self.addArr = [NSMutableArray arrayWithCapacity:0];
//        for (NSInteger i = 0; i < model.rule.count; i++) {
//            [self.addArr addObject:@"0"];
//        }
        self.model = model;
        self.numCount = 0;
        self.procudeId = produceId;
        [self makeNav];
        [self makeUI];
    }
    return self;
}
- (void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    [self setNavTitleItemWithName:self.model.name];
}
- (void)makeUI{
    [self makeMainView];
    [self makeBottomView];
}
//mainview
- (void)makeMainView{
    CGFloat height = 64;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, 150 * self.numSingleVesion)];
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.model.imgurl] placeholderImage:[UIImage imageNamed:@"personal_bg"]];
    [self.view addSubview:imgView];
    height = 220 * self.numSingleVesion;
    if (self.model.rule.count != 0) {
        UILabel *standardLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, height, 40 * self.numSingleVesion, 20 * self.numSingleVesion)];
        standardLab.text = @"规格";
        [self.view addSubview:standardLab];
        standardLab.font = [UIFont boldSystemFontOfSize:14];
        for (NSInteger i = 0; i < self.model.rule.count; i++) {
            UIButton *standardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            standardBtn.frame = CGRectMake(60 * self.numSingleVesion + 40 * self.numSingleVesion * i, height, 40 * self.numSingleVesion, 30 * self.numSingleVesion);
            standardBtn.layer.cornerRadius = 15 * self.numSingleVesion;
            standardBtn.layer.borderWidth = 1 * self.numSingleVesion;
            standardBtn.layer.borderColor = [SMSColor(211, 211, 211) CGColor];
            [standardBtn setTitle:self.model.rule[i][@"name"] forState:UIControlStateNormal];
            [standardBtn addTarget:self action:@selector(standardBtnDown:) forControlEvents:UIControlEventTouchUpInside];
            [standardBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.view addSubview:standardBtn];
            standardBtn.tag = 1400 + i;
            if (i == 0) {
                [standardBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
        }
        height += 40 * self.numSingleVesion;
    }
    UILabel *priceLabLeft = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, height, 40 * self.numSingleVesion, 20 * self.numSingleVesion)];
    priceLabLeft.text = @"单价";
    priceLabLeft.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:priceLabLeft];
    
    //价格
    UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectMake(60 * self.numSingleVesion, height, 40 * self.numSingleVesion, 20 * self.numSingleVesion)];
    priceLab.font = [UIFont systemFontOfSize:14];
    priceLab.textColor = [UIColor redColor];
    [self.view addSubview:priceLab];
    priceLab.text = [NSString stringWithFormat:@"%0.2f",self.model.price.doubleValue];
    [priceLab sizeToFit];
    priceLab.frame = CGRectMake(60 * self.numSingleVesion, height, priceLab.frame.size.width, 20 * self.numSingleVesion);
    
    height += 30 * self.numSingleVesion;
    
    //数量
    UILabel *numCountLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, height, 40 * self.numSingleVesion, 20 * self.numSingleVesion)];
    numCountLab.text = @"数量";
    numCountLab.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:numCountLab];
    
    //添加
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(90 * self.numSingleVesion, height, 20 * self.numSingleVesion, 20 * self.numSingleVesion);
    [self.addBtn setImage:[UIImage imageNamed:@"加.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.addBtn];
    [self.addBtn addTarget:self action:@selector(addBtnDwon:) forControlEvents:UIControlEventTouchUpInside];
    self.addBtn.layer.cornerRadius = 10 * self.numSingleVesion;
    self.addBtn.layer.borderWidth = 1 * self.numSingleVesion;
    self.addBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    //减少
    self.reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reduceBtn.frame = CGRectMake(60 * self.numSingleVesion,height, 20 * self.numSingleVesion, 20 * self.numSingleVesion);
    [self.reduceBtn setImage:[UIImage imageNamed:@"减.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.reduceBtn];
    [self.reduceBtn addTarget:self action:@selector(addBtnDwon:) forControlEvents:UIControlEventTouchUpInside];
    self.reduceBtn.layer.cornerRadius = 10 * self.numSingleVesion;
    self.reduceBtn.layer.borderWidth = 1 * self.numSingleVesion;
    self.reduceBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    //买几个
    self.buyCount = [[UILabel alloc] initWithFrame:CGRectMake(85 * self.numSingleVesion, 55 * self.numSingleVesion, 10 * self.numSingleVesion, 10 * self.numSingleVesion)];
    self.buyCount.font = [UIFont systemFontOfSize:13];
    self.buyCount.text = @"0";
    [self.view addSubview:self.buyCount];
    self.buyCount.textColor = [UIColor blackColor];
    [self.buyCount sizeToFit];
    self.buyCount.center = CGPointMake(80 * self.numSingleVesion + 5 * self.numSingleVesion, height + 10 * self.numSingleVesion);
    
    height += 30 * self.numSingleVesion;
    if (self.model.rule.count != 0) {
        //描述
        UILabel *descLabLeft = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, height, 40 * self.numSingleVesion, 20 * self.numSingleVesion)];
        descLabLeft.text = @"描述:";
        descLabLeft.font = [UIFont boldSystemFontOfSize:14];
        [self.view addSubview:descLabLeft];
        
        //描述内容
        UILabel *descDeatilLab = [[UILabel alloc] initWithFrame:CGRectMake(60 * self.numSingleVesion, height, WIDTH_CONTROLLER - 120 * self.numSingleVesion, [ComplexMethod returnEverRowHeightStr:self.model.rule[0][@"desc"] andWith:WIDTH_CONTROLLER - 120 * self.numSingleVesion andFont:14])];
        descDeatilLab.font = [UIFont boldSystemFontOfSize:14];
        descDeatilLab.text = self.model.rule[0][@"desc"];
        [self.view addSubview:descDeatilLab];
        self.descLab = descDeatilLab;
    }
    
    
}
//规格
- (void)standardBtnDown:(UIButton *)standardBtn{
    if (self.model.rule.count == 0) {
        return;
    }
    for (NSInteger i = 0; i < self.model.rule.count; i++) {
        UIButton *tempBtn = (UIButton*)[self.view viewWithTag:1400 + i];
        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [standardBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.clickNum = standardBtn.tag - 1400;
    self.descLab.text = self.model.rule[standardBtn.tag - 1400][@"desc"];
}
//添加和减少按钮
- (void)addBtnDwon:(UIButton *)addBtn{
    if (self.addBtn == addBtn) {
        self.numCount++;
        self.buyCount.text = [NSString stringWithFormat:@"%ld",self.numCount];
    }else{
        if (self.numCount == 0) {
            return;
        }else{
            self.numCount--;
            self.buyCount.text = [NSString stringWithFormat:@"%ld",self.numCount];
        }
    }
}
//bottomView
- (void)makeBottomView{
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(0, HEIGHT_CONTROLLER - 49 * self.numSingleVesion, WIDTH_CONTROLLER, 49 * self.numSingleVesion);
    [bottomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bottomBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:bottomBtn];
    [bottomBtn setBackgroundColor:[UIColor redColor]];
    bottomBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [bottomBtn addTarget:self action:@selector(bottomBtnDown:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)bottomBtnDown:(UIButton *)bottomBtn{
    if (self.numCount == 0) {
        [self.view makeToast:@"请选择物品"];
        return;
    }
    if ([self.target isKindOfClass:[FoodBussinessListCollectionViewController class]]) {
       
        if (self.model.rule.count == 0) {
            [self.target addFoodCarRlid:@"0" andCount:self.numCount andName:@"0" andModel:self.model andAddOrReduce:@"1"];
        }else{
            NSDictionary *tempDic = self.model.rule[self.clickNum];
            [self.target addFoodCarRlid:tempDic[@"rlid"] andCount:self.numCount andName:tempDic[@"name"] andModel:self.model andAddOrReduce:@"1"];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
#define JOINFOODCAR MAININTERFACE@"serviceServlet?serviceName=xmlGenerator&medthodName=addShoppingCar&MemberID=%@&productID=%@&dID=%@&count=%ld&rlid=%@"
        NSString *url = nil;
        [self makeHUd];
        if (self.model.rule.count == 0) {
            url = [NSString stringWithFormat:JOINFOODCAR,[StoreageMessage getMessage][2],self.procudeId,self.merchantId,self.numCount,@""];
        }else{
            NSDictionary *tempDic = self.model.rule[self.clickNum];

            url = [NSString stringWithFormat:JOINFOODCAR,[StoreageMessage getMessage][2],self.procudeId,self.merchantId,self.numCount,tempDic[@"rlid"]];

        }
        bottomBtn.userInteractionEnabled = NO;
        AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
        NSLog(@"url:%@",url);
        [twoPack getUrl:url andFinishBlock:^(id getResult) {
            bottomBtn.userInteractionEnabled = YES;
            [self hudWasHidden:self.hudProgress];
            if ([getResult[@"code"] isEqual:@"000000"]) {
                FoodBussinessListCollectionViewController *bussiness = [[FoodBussinessListCollectionViewController alloc] initWithId:self.merchantId andSendPrice:self.startPrice andDistributionPrice:self.disPrice];
                [self.navigationController pushViewController:bussiness animated:YES];
            }else{
                [self.view makeToast:@"添加购物车失败，请重新添加!"];

            }
        }];

    }
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
