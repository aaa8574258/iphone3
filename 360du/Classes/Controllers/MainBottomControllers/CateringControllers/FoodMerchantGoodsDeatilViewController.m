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
#import "SendMessage.h"
//#define JOINFOOCAR MAININTERFACE@"serviceServlet?serviceName=xmlGenerator&medthodName=addShoppingCar&MemberID=%@&productID=%@&dID=%@&count=%ld&rlid=%@"
#define JOINFOOCAR MAININTERFACE@"serviceServlet?serviceName=xmlGenerator&medthodName=addOrdersToShoppingCar&memberID=1234&dID=1&goodsCars=%@"
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
//        [self.navigationController setNavigationBarHidden:YES animated:YES];

        self.model = model;
        self.numCount = 0;
        self.procudeId = produceId;
        [self makeNav];
        [self makeUI];
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];

//    [self.navigationController setNavigationBarHidden:YES animated:YES];

//    [self.navigationController.navigationBar
//setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
//    self.navigationController.navigationBar.layer.masksToBounds = YES;
//     [self.navigationController setNavigationBarHidden:YES animated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [self setNavigationBarType];

    self.navigationController.navigationBarHidden = YES;
    if (self.dicParams != nil) {
        
        AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
        NSLog(@"%@",self.dicParams[@"did"]);
        FoodMerchatListItemModel *itemModel = [[FoodMerchatListItemModel alloc] init];

        [twoPack getUrl:[NSString stringWithFormat:MERCHANTGOODSLIST,self.dicParams[@"did"]] andFinishBlock:^(id getResult) {
//            [self hudWasHidden:self.hudProgress];
//            if ([getResult count] != 0) {
                NSLog(@"%@",getResult);
                NSDictionary *dict = getResult[0];
                // [{"pid":1449,"name":"苹果","type":"","price":5.0,"imgs":["/Image/nopicture.jpg","/Image/nopicture.jpg","/Image/nopicture.jpg"],"desc":""}]
                
                itemModel.pid = dict[@"goodsId"];
                itemModel.name = dict[@"name"];
                //itemModel.price = [NSNumber numberWithDouble:[dict[@"price"] doubleValue]];
                itemModel.price = dict[@"price"];
                itemModel.imgurl = dict[@"imgs"][0];
                //itemModel.
                if ([dict[@"desc"] respondsToSelector:@selector(count)]) {
                    itemModel.rule = dict[@"desc"];
                }else{
                    itemModel.rule = @[];
                }
                
                self.model = itemModel;
              
                self.numCount = 0;
                self.procudeId = dict[@"goodsId"];
                [self makeNav];
                [self makeUI];
//                FoodMerchantGoodsDeatilViewController *goodsMerchant = [[FoodMerchantGoodsDeatilViewController alloc] initWithItemModel:itemModel andPrudctId:dict[@"pid"]];
//                goodsMerchant.merchantId = dict[@"did"];
//                
//                goodsMerchant.target = self;
//                goodsMerchant.startPrice = dict[@"startSendPrice"];
//                goodsMerchant.disPrice = @"0";
//                [self.navigationController pushViewController:goodsMerchant animated:YES];
//            }else{
//                [self.view makeToast:@"网络不好，请换个网络"];
//            }
            
        }];

    }
    
    
    

}


- (void)makeNav{

//         [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [self setNavBarImage:@"landi.png"];
//     = YES;
    //[self setBackgroud:@"lantiao x.png"];
//    [self setNavigationBarType];
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//    [self setBackImageStateName:@"back11111.png" AndHighlightedName:@""];
//    [self setNavTitleItemWithName:self.model.name];
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 40);
//    [leftBtn setImage:[UIImage imageNamed:@"back11111.png"] forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
//    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
//    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    self.navigationItem.leftBarButtonItem = leftSecondItem;
}
- (void)makeUI{
    [self makeMainView];
    [self makeBottomView];
    

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10*self.numSingleVesion, 25*self.numSingleVesion, 20 *self.numSingleVesion, 20*self.numSingleVesion);
    [btn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 395 * self.numSingleVesion, WIDTH_CONTENTVIEW, 1 * self.numSingleVesion)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion , 400 * self.numSingleVesion, WIDTH_CONTENTVIEW, 30 * self.numSingleVesion)];
    label.text = _model.name;
//    [label sizeToFit];
    label.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion , 420 * self.numSingleVesion, WIDTH_CONTENTVIEW, 30 * self.numSingleVesion)];
//    [label1 sizeToFit];
    label1.text = [NSString stringWithFormat:@"月售:%@",_model.sendCount];
    label1.font = [UIFont systemFontOfSize:9];
    label1.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    
    [self.view addSubview:label1];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 495 * self.numSingleVesion, WIDTH_CONTENTVIEW, 1 * self.numSingleVesion)];
    view1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view1];
    
    
    //    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 25, 25)];
//    [image setImage:[UIImage imageNamed:@"back11111.png"]];
//    [self.view addSubview:image];
    
    
    
}

-(void) popAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];

}

//-(void ) viewDidDisappear:(BOOL)animated{
//    self.navigationController.navigationBar.hidden = NO;
//}



-(void) setNavigationBarType{
    self.navigationController.navigationBar.translucent = YES;
    UIColor *color = [UIColor whiteColor];
    CGRect rect = CGRectMake(0.0f, 0.0f, WIDTH_CONTENTVIEW, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
}


//mainview
- (void)makeMainView{
    CGFloat height = 64;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0 * self.numSingleVesion, 64, WIDTH_CONTROLLER, 331 * self.numSingleVesion)];
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.model.imgurl] placeholderImage:[UIImage imageNamed:@"personal_bg"]];
    [self.view addSubview:imgView];
    height = 460 * self.numSingleVesion;
//    if (self.model.rule.count != 0) {
//        UILabel *standardLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, height, 40 * self.numSingleVesion, 20 * self.numSingleVesion)];
//        standardLab.text = @"规格";
//        [self.view addSubview:standardLab];
//        standardLab.font = [UIFont boldSystemFontOfSize:14];
//        for (NSInteger i = 0; i < self.model.rule.count; i++) {
//            UIButton *standardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            standardBtn.font = [UIFont boldSystemFontOfSize:12];
//            standardBtn.frame = CGRectMake(60 * self.numSingleVesion + 40 * self.numSingleVesion * i, height, 40 * self.numSingleVesion, 30 * self.numSingleVesion);
//            standardBtn.layer.cornerRadius = 15 * self.numSingleVesion;
//            standardBtn.layer.borderWidth = 1 * self.numSingleVesion;
//            standardBtn.layer.borderColor = [SMSColor(211, 211, 211) CGColor];
//            [standardBtn setTitle:self.model.rule[i][@"name"] forState:UIControlStateNormal];
//            [standardBtn addTarget:self action:@selector(standardBtnDown:) forControlEvents:UIControlEventTouchUpInside];
//            [standardBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [self.view addSubview:standardBtn];
//            standardBtn.tag = 1400 + i;
//            if (i == 0) {
//                [standardBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//            }
//        }
//        height += 40 * self.numSingleVesion;
//    }
    
    UILabel *priceLabLeft = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, height, 40 * self.numSingleVesion, 20 * self.numSingleVesion)];
    priceLabLeft.text = @"单价";
    priceLabLeft.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];

    priceLabLeft.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:priceLabLeft];
    
    //价格
    UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectMake(60 * self.numSingleVesion, height, 40 * self.numSingleVesion, 20 * self.numSingleVesion)];
    priceLab.font = [UIFont systemFontOfSize:15];
    priceLab.textColor = [UIColor redColor];
    [self.view addSubview:priceLab];
    priceLab.text = [NSString stringWithFormat:@"%0.2f",self.model.price.doubleValue];
    [priceLab sizeToFit];
    priceLab.frame = CGRectMake(60 * self.numSingleVesion, height, priceLab.frame.size.width, 20 * self.numSingleVesion);
    
//    height += 30 * self.numSingleVesion;
    
    //数量
    UILabel *numCountLab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - 100 * self.numSingleVesion, height, 40 * self.numSingleVesion, 20 * self.numSingleVesion)];
    numCountLab.text = @"数量";
    numCountLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];

    numCountLab.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:numCountLab];
    
    //添加
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(WIDTH_CONTENTVIEW - 30 * self.numSingleVesion, height+2 , 15 * self.numSingleVesion, 15 * self.numSingleVesion);
    [self.addBtn setImage:[UIImage imageNamed:@"加.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.addBtn];
    [self.addBtn addTarget:self action:@selector(addBtnDwon:) forControlEvents:UIControlEventTouchUpInside];
    self.addBtn.layer.cornerRadius = 7.5 * self.numSingleVesion;
    self.addBtn.layer.borderWidth = 1 * self.numSingleVesion;
    self.addBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    //减少
    self.reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reduceBtn.frame = CGRectMake(WIDTH_CONTENTVIEW - 60 * self.numSingleVesion,height + 2 , 15 * self.numSingleVesion, 15 * self.numSingleVesion);
    [self.reduceBtn setImage:[UIImage imageNamed:@"减.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.reduceBtn];
    [self.reduceBtn addTarget:self action:@selector(addBtnDwon:) forControlEvents:UIControlEventTouchUpInside];
    self.reduceBtn.layer.cornerRadius = 7.5 * self.numSingleVesion;
    self.reduceBtn.layer.borderWidth = 1 * self.numSingleVesion;
    self.reduceBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    //买几个
    self.buyCount = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - 45 * self.numSingleVesion, 55 * self.numSingleVesion, 10 * self.numSingleVesion, 10 * self.numSingleVesion)];
    self.buyCount.font = [UIFont systemFontOfSize:13];
    self.buyCount.text = @"0";
    self.buyCount.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];

    [self.view addSubview:self.buyCount];
//    self.buyCount.textColor = [UIColor blackColor];
    [self.buyCount sizeToFit];
    self.buyCount.center = CGPointMake(WIDTH_CONTENTVIEW - 38, height + 10 * self.numSingleVesion);
    
//    height += 30 * self.numSingleVesion;
    if (self.model.rule.count != 0) {
        //描述
        UILabel *descLabLeft = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 516 *self.numSingleVesion, 40 * self.numSingleVesion, 20 * self.numSingleVesion)];
        descLabLeft.text = @"描述:";
        descLabLeft.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];

        descLabLeft.font = [UIFont boldSystemFontOfSize:16];
        [self.view addSubview:descLabLeft];
        
        //描述内容
        UILabel *descDeatilLab = [[UILabel alloc] initWithFrame:CGRectMake(60 * self.numSingleVesion, 516 *self.numSingleVesion, WIDTH_CONTROLLER - 120 * self.numSingleVesion, [ComplexMethod returnEverRowHeightStr:self.model.rule[0][@"desc"] andWith:WIDTH_CONTROLLER - 120 * self.numSingleVesion andFont:14])];
        descDeatilLab.font = [UIFont boldSystemFontOfSize:16];
        descDeatilLab.text = self.model.rule[0][@"desc"];
        descDeatilLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];

        [self.view addSubview:descDeatilLab];
        self.descLab = descDeatilLab;
    }else{
        UILabel *descLabLeft = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 516 *self.numSingleVesion, 40 * self.numSingleVesion, 20 * self.numSingleVesion)];
        descLabLeft.text = @"描述:";
        descLabLeft.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        descLabLeft.font = [UIFont boldSystemFontOfSize:16];
        [self.view addSubview:descLabLeft];
        UILabel *descDeatilLab = [[UILabel alloc] initWithFrame:CGRectMake(60 * self.numSingleVesion, 516 *self.numSingleVesion, WIDTH_CONTROLLER - 120 * self.numSingleVesion, [ComplexMethod returnEverRowHeightStr:self.model.detailDesc andWith:WIDTH_CONTROLLER - 120 * self.numSingleVesion andFont:14])];
        descDeatilLab.font = [UIFont boldSystemFontOfSize:16];
        descDeatilLab.numberOfLines = 0;
        descDeatilLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];

        descDeatilLab.text = self.model.detailDesc;
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
    bottomBtn.frame = CGRectMake(0, HEIGHT_CONTROLLER - 50 * self.numSingleVesion, WIDTH_CONTROLLER, 50 * self.numSingleVesion);
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:bottomBtn];
    [bottomBtn setBackgroundColor:[UIColor colorWithRed:255/255.0 green:39/255.0 blue:79/255.0 alpha:1]];
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
        
//    
//        NSString *url = nil;
//        [self makeHUd];
//        
//
        /**
         *  加入购物车
         */
//        if (self.model.rule.count == 0) {
        
//        [SendMessage shareInstance].theCount = [NSString stringWithFormat:@"%ld",(long)self.numCount];
//        if (self.model.rule.count) {
//            [SendMessage shareInstance].type = self.model.rule[self.clickNum][@"rlid"];
//        }
//        
//        [self.navigationController popViewControllerAnimated:YES];
        
//        
//        self.merchantId = [StoreageMessage gainMerchantUserNameAndPasswordAndMemerId][2];
        NSLog(@"%@",self.merchantId);

        NSString *url = nil;
//        [self makeHUd];
        NSLog(@"%lu",(unsigned long)self.model.rule.count);
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
            NSLog(@"%@",getResult);
            bottomBtn.userInteractionEnabled = YES;
            [self hudWasHidden:self.hudProgress];
            if ([getResult[@"code"] isEqual:@"000000"]) {
                FoodBussinessListCollectionViewController *bussiness = [[FoodBussinessListCollectionViewController alloc] initWithId:self.merchantId andSendPrice:self.startPrice andDistributionPrice:self.disPrice];
                [self.navigationController pushViewController:bussiness animated:YES];
            }else{
                [self.view makeToast:getResult[@"message"]];
                
                
            }
        }];

//        FoodBussinessListCollectionViewController *bussiness = [[FoodBussinessListCollectionViewController alloc] initWithId:self.merchantId andSendPrice:self.startPrice andDistributionPrice:self.disPrice];
//        [self.navigationController pushViewController:bussiness animated:YES];
        
//        NSMutableArray *upLoadDataArr = [NSMutableArray arrayWithCapacity:0];
//        NSArray *keyArr = @[@"productID",@"count",@"rlid"];
//        
//        for (NSInteger i = 0; i < [[self returnUploadGoodsCar] count] - 1; i++) {
//            NSDictionary *tempDict = [self returnUploadGoodsCar][i];
//            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
//            FoodMerchatListItemModel *model = tempDict[@"ItemModel"];
//            //[upLoadArr addObject:@{@"rlid":@"",@"count":dict[@"count"],@"descName":@"",@"ItemModel":dict[@"model"]}];
//            [dict setValue:model.pid forKey:@"productID"];
//            [dict setValue:tempDict[@"count"] forKey:@"count"];
//            NSString *tempStr = [NSString stringWithFormat:@"%ld",[tempDict[@"rlid"] integerValue]] ;
//            
//            if([tempStr integerValue] == 0){
//                tempStr = @"";
//            }
//            [dict setValue:tempStr forKey:@"rlid"];
//            [upLoadDataArr addObject:dict];
//            
//        }
//        //生成json字符串
//        NSMutableString *jsonString1 = [NSMutableString stringWithCapacity:0];
//        [jsonString1 appendString:@"["];
//        //    NSLog(@"jsonString:%@",jsonString);
//        for (NSDictionary *temp in upLoadDataArr) {
//            NSString *string ;//遍历数组，取出键值对并按json格式存放
//            string = [NSString stringWithFormat:@"{\"productID\":\"%@\",\"count\":\"%@\",\"rlid\":\"%@\"}",temp[@"productID"],temp[@"count"],temp[@"rlid"]];
//            [jsonString1 appendString:string];
//            [jsonString1 appendString:@","];
//        }
//        
//        //获取末尾逗号所在位置
//        NSUInteger location = [jsonString1 length] - 1;
//        NSRange range = NSMakeRange(location, 1);
//        [jsonString1 replaceCharactersInRange:range withString:@"]"];
//        
////        NSString *url =  [jsonString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSString *url1 = [jsonString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        AFHTTPSessionManager *_rom = [AFHTTPSessionManager manager];
//        _rom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",nil];
//        _rom.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
//        _rom.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
//        NSString *tempUrl = [NSString stringWithFormat:AddAllGoodsCar,[StoreageMessage getMessage][2],self.memchantId,url];
//        [_rom GET:tempUrl parameters:nil      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            [self hudWasHidden:self.hudProgress];
//            NSString *tempStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//            NSData *strData = [tempStr dataUsingEncoding:NSUTF8StringEncoding];
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableLeaves error:nil];
//            if ([dict[@"code"] isEqual:@"000000"]) {
//                BuyFoodCarViewController *buyFood = [[BuyFoodCarViewController alloc] initWithArr:[self returnUploadGoodsCar] andPrice:self.priceAll andFoodTypeArr:self.rlidArr andMerchantId:self.memchantId andSendPrice:self.sendPrice andDistrutionPrice:self.distributionprice];
//                buyFood.shopDesc = self.shopDesc;
//                buyFood.shopName = self.shopName;
//                [self.navigationController pushViewController:buyFood animated:YES];
//            }
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            [self hudWasHidden:self.hudProgress];
//            NSLog(@"error:%@",error);
//            [self.view makeToast:@"由于网络原因,请重新确认"];
//        }];
//
        
        
        
        
//            url = [NSString stringWithFormat:MAININTERFACE@"serviceServlet?serviceName=xmlGenerator&medthodName=addShoppingCar&MemberID=%@&productID=%@&dID=%@&count=%ld",[StoreageMessage getMessage][2],self.procudeId,[SendMessage shareInstance].did,self.numCount];
//        }else{
//            NSLog(@"%@",self.model.rule[self.clickNum][@"rlid"]);
//
//            
//            
//            NSDictionary *tempDic = self.model.rule[self.clickNum];
//            url = [NSString stringWithFormat:JOINFOOCAR,[StoreageMessage getMessage][2],self.procudeId,self.merchantId,self.numCount,tempDic[@"rlid"]];

//        }
//        bottomBtn.userInteractionEnabled = NO;
//        AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
//        NSLog(@"pid:%@",[SendMessage shareInstance].did);
//        NSLog(@"url:%@",url);
//        [twoPack getUrl:url andFinishBlock:^(id getResult) {
//            bottomBtn.userInteractionEnabled = YES;
//            NSLog(@"%@",getResult);
//            [self hudWasHidden:self.hudProgress];
//            if ([getResult[@"code"] isEqual:@"000000"]) {
////                FoodBussinessListCollectionViewController *bussiness = [[FoodBussinessListCollectionViewController alloc] initWithId:self.merchantId andSendPrice:self.startPrice andDistributionPrice:self.disPrice];
////                [self.navigationController pushViewController:bussiness animated:YES];
//                [self.view makeToast:@"添加购物车成功"];
//
//                [self.navigationController popViewControllerAnimated:YES];
//            }else{
//                NSLog(@"1111%@",getResult[@"error"]);
//                [self.view makeToast:@"添加购物车失败，请重新添加!"];
//
//            }
//        }];
//
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];

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
