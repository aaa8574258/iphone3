//
//  GroupRobGoodsViewController.m
//  360du
//
//  Created by linghang on 15/12/24.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "GroupRobGoodsViewController.h"
#import "GroupPurchaseModel.h"
#import "CZCountDownView.h"
#import "UIImageView+WebCache.h"
#import "TranlateTime.h"
#import "AFNetworkTwoPackaging.h"
#import "UIView+Toast.h"
#import "GroupPurchasrItemListModel.h"
#import "GroupPurchaseItemView.h"
#import "StoreageMessage.h"
#import "GroupOrderDeatilModel.h"
#import "GroupPurchaseOrderDetailViewController.h"
#import "UMSocial.h"
#import "UIImageView+WebCache.h"

@interface GroupRobGoodsViewController ()<UMSocialUIDelegate>
@property(nonatomic,strong)GroupPurchaseModel *model;
@property(nonatomic,strong)UILabel *nameLable;//0,0,0
@property(nonatomic,strong)UIImageView *leftImg;
@property(nonatomic,strong)UILabel *nowMoneyLable;//252,193,69
@property(nonatomic,strong)UILabel *beforeMoneyLable;//150,150,150
@property(nonatomic,strong)UIImageView *robImage;
@property(nonatomic,strong)UILabel *surplusCountLab;//200,200,200
@property(nonatomic,strong)UILabel *surplusTimeLab;//193,193,193,25,25,25
@property(nonatomic,strong)UILabel *lineMoney;//钱数横线
@property(nonatomic,weak)UIView *timeView;//时间图
@property(nonatomic,strong)CZCountDownView *countDownView;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,weak)UIView *itemView;

@end

@implementation GroupRobGoodsViewController
- (id)initWithModel:(GroupPurchaseModel *)model{
    self = [super init];
    if (self) {
        self.model = model;
        [self makeNav];
        [self makeUI];
    }
    return self;
}
- (void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:self.model.cpname];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 2, 60, 40);
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    rightBtn.titleLabel.textColor = [UIColor whiteColor];
    rightBtn.layer.borderWidth = 1;
    rightBtn.layer.borderColor = [SMSColor(241, 241, 241) CGColor];
    rightBtn.hidden = YES;
    rightBtn.userInteractionEnabled = NO;
    [rightBtn addTarget:self action:@selector(rightBtnDonwn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *batItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = batItem;
    
}
- (void)rightBtnDonwn{
     NSString *shareText = [NSString stringWithFormat:@"%@ %@",self.model.cpname,@"http://www.360duang.net/360duang/Shop/purchase/introduction/jicai.jsp?cpid=20151200003"];
    //= @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。 http://www.umeng.com/social";             //分享内嵌文字
    //    UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];
    //分享内嵌图片
    UIImageView *imgView = nil;
    
    UIImage *shareImage = [self getImageFromURL:self.model.cppicture];
    //    //调用快速分享接口
    //    [UMSocialSnsService presentSnsIconSheetView:self
    //                                         appKey:@"53290df956240b6b4a0084b3"
    //                                      shareText:shareText
    //                                     shareImage:shareImage
    //                                shareToSnsNames:nil
    //                                       delegate:self];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"53290df956240b6b4a0084b3"
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQQ,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,nil]
                                       delegate:self];

}
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    NSLog(@"执行图片下载函数");
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}
//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

- (void)makeUI{
    [self makeMainView];
    [self makeBottom];
}




















- (void)makeMainView{
    CGFloat height = 64 * self.numSingleVesion + 80 * self.numSingleVesion;
    //图片
    self.leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(40 * self.numSingleVesion, height,WIDTH_CONTROLLER - 80 * self.numSingleVesion, 140 * self.numSingleVesion)];
    [self.leftImg sd_setImageWithURL:[NSURL URLWithString:self.model.cppicture]];
    [self.view addSubview:self.leftImg];
    height += 140 * self.numSingleVesion + 10 * self.numSingleVesion;
    //名字
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, height, WIDTH_CONTENTVIEW - 30 * self.numSingleVesion, 15 * self.numSingleVesion)];
    self.nameLable.font = [UIFont systemFontOfSize:18];
    self.nameLable.textColor = SMSColor(0, 0, 0);
    self.nameLable.text = self.model.cpname;
    [self.view addSubview:self.nameLable];
    [self.nameLable sizeToFit];
    self.nameLable.center = CGPointMake(WIDTH_CONTROLLER / 2, height + 7.5 * self.numSingleVesion);
    
    
    height += 15 * self.numSingleVesion + 20 * self.numSingleVesion;
    
    
    //现在价格
    self.nowMoneyLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nowMoneyLable.textColor = SMSColor(51,51,51);
    self.nowMoneyLable.font = [UIFont systemFontOfSize:40];
    self.nowMoneyLable.text = [NSString stringWithFormat:@"￥%@",self.model.unitPirce];
    [self.view addSubview:self.nowMoneyLable];
    [self.nowMoneyLable sizeToFit];
    self.nowMoneyLable.frame = CGRectMake((WIDTH_CONTROLLER - self.nowMoneyLable.frame.size.width) / 2, height, self.nowMoneyLable.frame.size.width, 30 * self.numSingleVesion);
    
    //原先价格
    self.beforeMoneyLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.beforeMoneyLable.textColor = SMSColor(150,150,150);
    self.beforeMoneyLable.font = [UIFont systemFontOfSize:15];
    self.beforeMoneyLable.text = [NSString stringWithFormat:@"RMB:%@",self.model.marketPrice];
    [self.view addSubview:self.beforeMoneyLable];
    [self.beforeMoneyLable sizeToFit];
    self.beforeMoneyLable.frame  = CGRectMake((WIDTH_CONTROLLER - self.nowMoneyLable.frame.size.width) / 2 + self.nowMoneyLable.frame.size.width + 5 * self.numSingleVesion, height + 3 * self.numSingleVesion, self.beforeMoneyLable.frame.size.width, 15 * self.numSingleVesion);

    //钱数横线
    self.lineMoney = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1 * self.numSingleVesion)];
    self.lineMoney.backgroundColor = SMSColor(150,150,150);
    //        self.lineMoney.textColor = [UIColor redColor];
    //self.lineMoney.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.lineMoney];
    self.lineMoney.frame = CGRectMake((WIDTH_CONTROLLER - self.nowMoneyLable.frame.size.width) / 2 + self.nowMoneyLable.frame.size.width + 5 * self.numSingleVesion, height + 3 * self.numSingleVesion + 7.5 * self.numSingleVesion, self.beforeMoneyLable.frame.size.width, 1 * self.numSingleVesion);
    
    height += 50 * self.numSingleVesion;
    //剩余时间
    UILabel  *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, height, WIDTH_CONTENTVIEW - 30 * self.numSingleVesion, 15 * self.numSingleVesion)];
  //  timeLab.font = [UIFont systemFontOfSize:14];
    timeLab.textColor = SMSColor(151, 151, 151);
    timeLab.text = @"距离活动结束还有  ";
    timeLab.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:timeLab];
    [timeLab sizeToFit];
    timeLab.frame = CGRectMake(40 * self.numSingleVesion, height + 7.5 * self.numSingleVesion, timeLab.frame.size.width, 15 * self.numSingleVesion);
    
    self.countDownView = [CZCountDownView countDown];
    self.countDownView.backgroundColor = [UIColor redColor];
    self.countDownView.frame = CGRectMake(WIDTH_CONTROLLER - 140 * self.numSingleVesion -  timeLab.frame.size.width, height, WIDTH_CONTENTVIEW - 50 * self.numSingleVesion - timeLab.frame.size.width, 30 * self.numSingleVesion);
    //self.countDownView.backgroundColor = SMSColor(211, 211, 211);
    [self.view addSubview:self.countDownView];
    self.countDownView.backgroundImageName = @"search_k";
    self.countDownView.timestamp = [[TranlateTime returnTimeStamp:self.model.stopTime] integerValue];
    self.countDownView.timerStopBlock = ^{
        NSLog(@"时间停止");
    };
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 180 * self.numSingleVesion, WIDTH_CONTENTVIEW - 20 * self.numSingleVesion, 30 * self.numSingleVesion)];
    //    view.backgroundColor = SMSColor(211, 211, 211);
    //    [self.contentView addSubview:view];
    //    self.timeView = view;
    //
    //    self.surplusTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW - 20 * self.numSingleVesion, 15 * self.numSingleVesion)];
    //    self.surplusTimeLab.center = CGPointMake(WIDTH_CONTENTVIEW / 2, 15 * self.numSingleVesion);
    //    [view addSubview:self.surplusTimeLab];
    
}

- (void)makeBottom{
//    231,61,60
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(20 * self.numSingleVesion, HEIGHT_CONTENTVIEW - 70 * self.numSingleVesion, WIDTH_CONTENTVIEW - 40 * self.numSingleVesion, 50 * self.numSingleVesion);
    bottomBtn.backgroundColor = SMSColor(231, 61, 60);
    [bottomBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [bottomBtn setTintColor:[UIColor whiteColor]];
    [bottomBtn addTarget:self action:@selector(bottomBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
}
- (void)bottomBtnDown:(UIButton *)bottomBtn{
    //立即抢购
    NSString *url = [NSString stringWithFormat:GROUPPURCHASESPECIFICATION,self.model.cpid];
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl: url andFinishBlock:^(id getResult) {
        if ([getResult[@"code"] isEqual:@"000000"]) {
            GroupPurchasrItemListModel *itemModel = nil;
            for (id temp in getResult[@"datas"]) {
                itemModel = [[GroupPurchasrItemListModel alloc] initWithDictionary:temp];

            }
            [self createBgViewHeight:HEIGHT_CONTROLLER];
            GroupPurchaseItemView *itemView = [[GroupPurchaseItemView alloc] initWithFrame:CGRectMake(15 * self.numSingleVesion, (HEIGHT_CONTROLLER - 300 * self.numSingleVesion) / 2, WIDTH_CONTROLLER - 30 * self.numSingleVesion, 300 * self.numSingleVesion) andModle:itemModel andStoreCount:[NSString stringWithFormat:@"%ld",(self.model.topLimit.integerValue - self.model.nowCount.integerValue)] andPictureUrl:self.model.detailsDes];
            self.itemView = itemView;
            itemView.cpid = self.model.cpid;
            itemView.target = self;
            [self.view addSubview:itemView];
            //
        }else{
            [self.view makeToast:getResult[@"message"]];
        }
    }];
}
//1,为确定，0为取消
- (void)cancelOrNot:(NSInteger)cancelOrConfirm andArr:(NSArray *)infoArr{
    [self removeBgViewTouch];
    if (cancelOrConfirm == 0) {
        [self removeBgView];

    }else{
        [self makeHUd];
        AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
        //NSString *url3 = [NSString stringWithFormat:GROUPGAINORDERINFORMATION,[StoreageMessage getMessage][2],infoArr[0]];
        NSString *url3 = [NSString stringWithFormat:GROUPGAINORDERINFORMATION,[StoreageMessage getMessage][2],self.model.cpid];
        [twoPack getUrl:url3 andFinishBlock:^(id getResult) {
            [self hudWasHidden:self.hudProgress];
            if ([getResult[@"code"] isEqual:@"000000"]) {
                GroupOrderDeatilModel *detailModel = [[GroupOrderDeatilModel alloc] initWithDictionary:getResult[@"datas"]];
                GroupPurchaseOrderDetailViewController *orderDeatil = [[GroupPurchaseOrderDetailViewController alloc] initWithModel:detailModel];
                [self.navigationController pushViewController:orderDeatil animated:YES];
            }else{
                [self.view makeToast:getResult[@"message"]];
            }
        }];
    }
}
//触摸
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if ([touch.view isEqual:self.bgView]) {
        //
        [self removeBgViewTouch];
        }
}
- (void)removeBgViewTouch{
    [self.itemView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.itemView removeFromSuperview];
    self.itemView = nil;
    [self removeBgView];
}
//创建背景图
- (void)createBgViewHeight:(NSInteger)height{
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, height - 64)];
    self.bgView.backgroundColor = SMSColor(221, 221, 221);
    [self.view addSubview:self.bgView];
}
//移除背景图
- (void)removeBgView{
    [self.bgView removeFromSuperview];
    self.bgView = nil;
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
