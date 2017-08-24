//
//  GroupPurchaseItemView.m
//  360du
//
//  Created by linghang on 15/12/25.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "GroupPurchaseItemView.h"
#import "GroupPurchasrItemListModel.h"
#import "UIImageView+WebCache.h"
#import "GroupRobGoodsDetialViewController.h"
#import "UIView+Toast.h"
#import "AFNetworkTwoPackaging.h"
#import "StoreageMessage.h"
#import "UIView+Toast.h"
#import "LogInViewController.h"
#define LOCAL_WIDTH self.frame.size.width
@interface GroupPurchaseItemView()
@property(nonatomic,strong)GroupPurchasrItemListModel *model;
@property(nonatomic,weak)NSString *countStr;
@property(nonatomic,weak)NSString *pictureUrl;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,strong)UILabel *buyCount;
@property (nonatomic,copy) NSString *bbbuy;
@property (nonatomic ,copy) NSString *csBuy;
@end
@implementation GroupPurchaseItemView
- (id)initWithFrame:(CGRect)frame andModle:(GroupPurchasrItemListModel *)model andStoreCount:(NSString *)countStr andPictureUrl:(NSString *)pictureUrl{
    self = [super initWithFrame:frame];
    if (self) {
        self.model = model;
        self.countStr = countStr;
        self.backgroundColor = [UIColor whiteColor];
        self.pictureUrl = pictureUrl;
        self.bbbuy = self.model.limitNumber;
        self.csBuy = @"1";
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    [self makeFirstView];
    [self makeSecondView];
    [self makeThirdView];
    
}
//第一个
- (void)makeFirstView{
    self.height = 40 * self.numSingleVesion;
    UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(5 * self.numSingleVesion, self.height, self.frame.size.width - 10 * self.numSingleVesion, 50 * self.numSingleVesion)];
    firstView.backgroundColor = SMSColor(246, 246, 246);
    [self addSubview:firstView];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 7.5 * self.numSingleVesion, 40 * self.numSingleVesion, 40 * self.numSingleVesion)];
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.pictureUrl]];
    [firstView addSubview:imgView];
    
    //价格
    UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectMake(70 * self.numSingleVesion, 17.5 * self.numSingleVesion, 100 * self.numSingleVesion, 15 * self.numSingleVesion)];
    priceLab.text = [NSString stringWithFormat:@"￥%@",self.model.price];
    priceLab.font = [UIFont systemFontOfSize:15];
    priceLab.textColor = SMSColor(185, 0, 0);
    [firstView addSubview:priceLab];
    //库存
    UILabel *storeLab = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2, 17.5 * self.numSingleVesion, 200 , 15 * self.numSingleVesion)];
    storeLab.text = [NSString stringWithFormat:@"库存:%@",self.countStr];
    storeLab.font = [UIFont systemFontOfSize:15];
    storeLab.textColor = SMSColor(185, 0, 0);
    [firstView addSubview:storeLab];
    //差号
    UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    removeBtn.frame = CGRectMake(firstView.frame.size.width - 40 * self.numSingleVesion, 5 * self.numSingleVesion, 40 * self.numSingleVesion, 40 * self.numSingleVesion);
    [removeBtn setTitle:@"X" forState:UIControlStateNormal];
    [removeBtn setTitleColor:SMSColor(151, 151, 151) forState:UIControlStateNormal];
    [removeBtn addTarget:self action:@selector(removeBtnDown1:) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:removeBtn];
    removeBtn.tag = 1100 ;
    self.height += 50 * self.numSingleVesion;

}
//第二个

- (void)makeSecondView{
    UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(5 * self.numSingleVesion, self.height, self.frame.size.width - 10 * self.numSingleVesion, 100 * self.numSingleVesion)];
    //firstView.backgroundColor = SMSColor(246, 246, 246);
    firstView.backgroundColor = [UIColor whiteColor];
    [self addSubview:firstView];

    
    UILabel *priceLabLeft = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 5 * self.numSingleVesion , 40 * self.numSingleVesion, 20 * self.numSingleVesion)];
    priceLabLeft.text = @"规格";
    priceLabLeft.font = [UIFont boldSystemFontOfSize:15];
    [priceLabLeft sizeToFit];
    priceLabLeft.textColor = SMSColor(51, 51, 51);
    priceLabLeft.center = CGPointMake(10 * self.numSingleVesion + priceLabLeft.frame.size.width / 2, 25 * self.numSingleVesion);
    [firstView addSubview:priceLabLeft];
    
    //价格
    UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectMake(60 * self.numSingleVesion, 7.5 * self.numSingleVesion, LOCAL_WIDTH - 80 * self.numSingleVesion, 35 * self.numSingleVesion)];
    priceLab.font = [UIFont systemFontOfSize:15];
    priceLab.textColor = SMSColor(51, 51, 51);
    [firstView addSubview:priceLab];
    priceLab.layer.cornerRadius = 17.5 * self.numSingleVesion;
    priceLab.layer.borderColor = [SMSColor(185, 0, 0) CGColor];
    priceLab.layer.borderWidth = 1 * self.numSingleVesion;
    priceLab.text = self.model.name;
    //[priceLab sizeToFit];
    priceLab.textAlignment = NSTextAlignmentCenter;

    
    //数量
    UILabel *numCountLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 60 * self.numSingleVesion, 40 * self.numSingleVesion, 20 * self.numSingleVesion)];
    numCountLab.text = @"数量";
    numCountLab.textColor = SMSColor(51, 51, 51);
    numCountLab.font = [UIFont boldSystemFontOfSize:15];
    [firstView addSubview:numCountLab];
    [numCountLab sizeToFit];
    numCountLab.center = CGPointMake(10 * self.numSingleVesion + numCountLab.frame.size.width / 2, 75 * self.numSingleVesion);
    
    NSArray *imgArr = @[@"减.png",@"加.png"];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(60 * self.numSingleVesion + 70 * self.numSingleVesion * i, 5 * self.numSingleVesion + 50 * self.numSingleVesion, 40 * self.numSingleVesion, 40 * self.numSingleVesion);
//        addBtn.backgroundColor = [UIColor cyanColor];
        [addBtn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [firstView addSubview:addBtn];
        [addBtn addTarget:self action:@selector(removeBtnDown1:) forControlEvents:UIControlEventTouchUpInside];
        addBtn.tag = 1200 + i ;
        addBtn.layer.cornerRadius = 20 * self.numSingleVesion;
        addBtn.layer.borderWidth = 1 * self.numSingleVesion;
        addBtn.layer.borderColor = [SMSColor(241, 241, 241) CGColor];
    }
    //买几个
    self.buyCount = [[UILabel alloc] initWithFrame:CGRectMake(85 * self.numSingleVesion, 5 * self.numSingleVesion, 20 * self.numSingleVesion, 10 * self.numSingleVesion)];
    self.buyCount.font = [UIFont systemFontOfSize:13];
//    self.buyCount.backgroundColor = [UIColor redColor];
    self.buyCount.text = [NSString stringWithFormat:@"%@",self.csBuy];
    [firstView addSubview:self.buyCount];
    self.buyCount.textColor = [UIColor blackColor];
//    [self.buyCount sizeToFit];
    self.buyCount.center = CGPointMake(115 * self.numSingleVesion + 0 * self.numSingleVesion,75 * self.numSingleVesion);
    self.height += 100 * self.numSingleVesion;

//    //添加
//    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.addBtn.frame = CGRectMake(90 * self.numSingleVesion, height, 20 * self.numSingleVesion, 20 * self.numSingleVesion);
//    [self.addBtn setImage:[UIImage imageNamed:@"加.png"] forState:UIControlStateNormal];
//    [self.view addSubview:self.addBtn];
//    [self.addBtn addTarget:self action:@selector(addBtnDwon:) forControlEvents:UIControlEventTouchUpInside];
//    self.addBtn.layer.cornerRadius = 10 * self.numSingleVesion;
//    self.addBtn.layer.borderWidth = 1 * self.numSingleVesion;
//    self.addBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//    //减少
//    self.reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.reduceBtn.frame = CGRectMake(60 * self.numSingleVesion,height, 20 * self.numSingleVesion, 20 * self.numSingleVesion);
//    [self.reduceBtn setImage:[UIImage imageNamed:@"减.png"] forState:UIControlStateNormal];
//    [self.view addSubview:self.reduceBtn];
//    [self.reduceBtn addTarget:self action:@selector(addBtnDwon:) forControlEvents:UIControlEventTouchUpInside];
//    self.reduceBtn.layer.cornerRadius = 10 * self.numSingleVesion;
//    self.reduceBtn.layer.borderWidth = 1 * self.numSingleVesion;
//    self.reduceBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
}
//第三个
- (void)makeThirdView{
    UIView *firstView1 = [[UIView alloc] initWithFrame:CGRectMake(5 * self.numSingleVesion, self.height, self.frame.size.width - 10 * self.numSingleVesion, 20 * self.numSingleVesion)];
    firstView1.backgroundColor = SMSColor(246, 246, 246);
    //firstView1.backgroundColor = [UIColor redColor];
    [self addSubview:firstView1];
    
    self.height += 20 * self.numSingleVesion;
    UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(5 * self.numSingleVesion, self.height , LOCAL_WIDTH - 10 * self.numSingleVesion, 80 * self.numSingleVesion)];
   // firstView1.backgroundColor = SMSColor(246, 246, 246);
    firstView.backgroundColor = [UIColor whiteColor];
    [self addSubview:firstView];
    
    //描述
    UILabel *priceLabLeft = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 5 * self.numSingleVesion , LOCAL_WIDTH -  40 * self.numSingleVesion, 20 * self.numSingleVesion)];
    priceLabLeft.text = [NSString stringWithFormat:@"描述:%@",self.model.proDetails];
    priceLabLeft.font = [UIFont boldSystemFontOfSize:15];
    [priceLabLeft sizeToFit];
    priceLabLeft.textColor = SMSColor(51, 51, 51);
    [firstView addSubview:priceLabLeft];
    //确定
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(5 * self.numSingleVesion, 35 * self.numSingleVesion,LOCAL_WIDTH - 20 * self.numSingleVesion, 40 * self.numSingleVesion);
    [confirmBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:SMSColor(231, 61, 61)];
    confirmBtn.tag = 1300 ;

    [confirmBtn addTarget:self action:@selector(removeBtnDown1:) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:confirmBtn];
}

- (void)removeBtnDown1:(UIButton *)btn{
    //tag==1100,是取消，tag = 1200,1201,减，加，tag=1300,确定
    if (![self.target isKindOfClass:[GroupRobGoodsDetialViewController class]]) {
        return;
    }
    if (btn.tag == 1100) {
        [self.target cancelOrNot:0 andArr:@[]];
        
    }else if(btn.tag == 1200 || btn.tag == 1201){
//        NSString *url = nil;
        if (btn.tag == 1200) {
          
            if (self.buyCount.text.integerValue == 0) {
                [self makeToast:@"商品数不能为负数"];
            }else{
                self.buyCount.text = [NSString stringWithFormat:@"%ld",(self.buyCount.text.integerValue - 1)];
//                self.buyCount.text = self.model.limitNumber;
//                url = [NSString stringWithFormat:GROUPPURCHASEADDGOODORPLUSGOODS,self.cpid,[StoreageMessage getMessage][2],@"-1",self.model.id];
//                [self requestUrl:url andType:0];
            }
        }else{
            NSLog(@"%@-%@",self.bbbuy,self.csBuy);
            if (self.buyCount.text.integerValue >= self.bbbuy.integerValue) {
                [self makeToast:[NSString stringWithFormat:@"只能限购%@个",self.bbbuy]];
            }else{
                self.buyCount.text = [NSString stringWithFormat:@"%ld",(self.buyCount.text.integerValue + 1)];
//                self.buyCount.text = self.model.limitNumber;

//                url = [NSString stringWithFormat:GROUPPURCHASEADDGOODORPLUSGOODS,self.cpid,[StoreageMessage getMessage][2],@"1",self.model.id];
//                [self requestUrl:url andType:1];
            }
        }
    }else{
        NSString *url = [NSString stringWithFormat:GROUPPURCHASEADDGOODORPLUSGOODS,self.cpid,[StoreageMessage getMessage][2],self.buyCount.text,self.model.id];
        [self requestUrl:url andType:1];

    }
}
- (void)requestUrl:(NSString *)url andType:(NSInteger)type {//1,添加，0减少

    [self makeHUd];
    
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:url andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        NSLog(@"2333%@",getResult);
        if ([getResult[@"code"] isEqual:@"000000"]) {
//            [self.target cancelOrNot:1 andArr:@[self.model.id]];
            [self.target cancelOrNot:1 andArr:@[self.model.id] andCount:self.buyCount.text andPid:self.model.id andShopType:@"2" andRule:self.model.unit];
        }else{
            [self makeToast:getResult[@"message"]];
        }
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
