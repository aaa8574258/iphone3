//
//  GainPrivilageSuccessViewController.m
//  360du
//
//  Created by linghang on 15/12/12.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "GainPrivilageSuccessViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "UIView+Toast.h"
#import "FoodMerchantGoodsDeatilViewController.h"
#import "FoodBussinessListCollectionViewController.h"
#import "FoodMerchatListModel.h"
@interface GainPrivilageSuccessViewController ()
@property(nonatomic,weak)NSDictionary *dict;
@end

@implementation GainPrivilageSuccessViewController
- (id)initWithArr:(NSDictionary *)array{
    self = [super init];
    if (self) {
        [self makeNav];
        [self makeMainView];
        self.dict = array;
        [self makeBottom];
    }
    return self;
}
- (void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    [self setNavTitleItemWithName:@"领券成功"];
}
- (void)makeMainView{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 - 49 * self.numSingleVesion)];
    imgView.image = [UIImage imageNamed:@"coupons_page_bg.jpg"];
    [self.view addSubview:imgView];
}
- (void)makeBottom{
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(10 * self.numSingleVesion, HEIGHT_CONTROLLER - 49 * self.numSingleVesion, WIDTH_CONTROLLER - 20 * self.numSingleVesion, 40 * self.numSingleVesion);
    [bottomBtn setBackgroundColor:[UIColor redColor]];
    [bottomBtn setTitle:@"去商店看看" forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(bottomBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    
}
- (void)bottomBtnDown:(UIButton *)bottomBtn{
    
    NSDictionary *dict = self.dict[@"datas"];
    //    yhLevel是2时没有产品参数"goodsId":"1562"
    if ([dict[@"yhLevel"] integerValue] == 2) {
        FoodBussinessListCollectionViewController *foodBusssiness = [[FoodBussinessListCollectionViewController alloc] initWithId:dict[@"did"] andSendPrice:dict[@"startSendPrice"] andDistributionPrice:@"0"];
        [self.navigationController pushViewController:foodBusssiness animated:YES];
    }else{//yhLevel是1时还有产品参数"goodsId":"1562"
        [self makeHUd];
        FoodMerchatListItemModel *itemModel = [[FoodMerchatListItemModel alloc] init];
       // itemModel.name = model.businessName;
        AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
        [twoPack getUrl:[NSString stringWithFormat:MERCHANTPRODUCTDETAIL,dict[@"goodsId"]] andFinishBlock:^(id getResult) {
            [self hudWasHidden:self.hudProgress];
            if ([getResult count] != 0) {
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
                FoodMerchantGoodsDeatilViewController *goodsMerchant = [[FoodMerchantGoodsDeatilViewController alloc] initWithItemModel:itemModel andPrudctId:dict[@"pid"]];
                goodsMerchant.merchantId = dict[@"did"];
                
                goodsMerchant.target = self;
                goodsMerchant.startPrice = dict[@"startSendPrice"];
                goodsMerchant.disPrice = @"0";
                [self.navigationController pushViewController:goodsMerchant animated:YES];
            }else{
                [self.view makeToast:@"网络不好，请换个网络"];
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
