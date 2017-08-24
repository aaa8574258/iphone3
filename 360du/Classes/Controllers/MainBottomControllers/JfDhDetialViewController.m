//
//  JfDhDetialViewController.m
//  360du
//
//  Created by 利美 on 17/3/14.
//  Copyright © 2017年 wangjian. All rights reserved.
//

#import "JfDhDetialViewController.h"
#import "StoreageMessage.h"
@interface JfDhDetialViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
@property (nonatomic, assign) NSInteger popTag;
@property (nonatomic ,strong) UIView *popView;
@property (nonatomic ,strong) UIScrollView *Scro;
@end

@implementation JfDhDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.popTag = 0;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 30);
    [leftBtn setImage:[UIImage imageNamed:@"叉号@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, 20)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    
    UIScrollView *Scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, HEIGHT_CONTENTVIEW)];
    Scro.contentSize = CGSizeMake(WIDTH_CONTENTVIEW, 1800);
    Scro.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.view addSubview:Scro];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, 20)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    self.Scro = Scro;
    self.Scro.delegate = self;
//    [self makeUI];
    [self getInfo];
}

-(void )getInfo{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:DETIALGOODS,self.pro_id,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        NSLog(@"%@----%@",getResult,self.pro_id);
//        for (NSDictionary *dic in getResult[@"datas"]) {
            NSLog(@"%@",getResult[@"datas"][@"proContent"]);
            [self makeUIWithJF:getResult[@"datas"][@"proIntegral"] AndImageUrl:getResult[@"datas"][@"picUrl"] andName:getResult[@"datas"][@"proName"] AndCostPrice:getResult[@"datas"][@"costPrice"] andNowPrice:getResult[@"datas"][@"currentPrice"] andFrom:getResult[@"datas"][@"proSource"]  andproInventory:getResult[@"datas"][@"proInventory"] andEndTime:getResult[@"datas"][@"endTime"] andOther:getResult[@"datas"][@"proContent"] andType:getResult[@"datas"][@"exchange_type"]];
//        }
    }];
}



-(void)makeUIWithJF:(NSString *)jifen AndImageUrl:(NSString *)imageUrl andName:(NSString *)name AndCostPrice:(NSString *)costPrice andNowPrice:(NSString *)nowPrice andFrom:(NSString *)from andproInventory:(NSString *)proInventory andEndTime:(NSString *)endTime andOther:(NSString *)other andType:(NSString *)type{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 235 *self.numSingleVesion)];
//    imageV.backgroundColor = [UIColor cyanColor];
    [imageV sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    [self.Scro addSubview:imageV];
    
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, imageV.frame.origin.y + imageV.frame.size.height, self.view.frame.size.width, 55 *self.numSingleVesion)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.Scro addSubview:view1];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectZero];
    lab1.text = [NSString stringWithFormat:@"%@积分",jifen];
    lab1.textColor = [UIColor colorWithRed:354/255.0 green:139/255.0 blue:14/255.0 alpha:1];
    lab1.font = [UIFont systemFontOfSize:16];
    [lab1 sizeToFit];
    lab1.center = CGPointMake(60 * self.numSingleVesion, view1.frame.size.height/2);
    [view1 addSubview:lab1];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(self.view.frame.size.width - 20 *self.numSingleVesion - 145 *self.numSingleVesion, 10 *self.numSingleVesion, 145 *self.numSingleVesion, view1.frame.size.height - 20 *self.numSingleVesion);
    if (type.integerValue == 0  ) {
        [btn1 setImage:[UIImage imageNamed:@"立即兑换@2x.png"] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(dhAction:) forControlEvents:UIControlEventTouchUpInside];
    }else if (type.integerValue == 1){
        [btn1 setImage:[UIImage imageNamed:@"已兑换@2x.png"] forState:UIControlStateNormal];
    }else{
        [btn1 setImage:[UIImage imageNamed:@"立即兑换@2x.png"] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(dhAction1:) forControlEvents:UIControlEventTouchUpInside];

    }

    [view1 addSubview:btn1 ];
    
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, view1.frame.origin.y + view1.frame.size.height + 10 *self.numSingleVesion, self.view.frame.size.width, 1000 *self.numSingleVesion)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.Scro addSubview:view2];
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(15 *self.numSingleVesion, 15 *self.numSingleVesion, self.view.frame.size.width - 30 *self.numSingleVesion, 30 * self.numSingleVesion)];
    lab2.text = @"商品名称";
    lab2.font = [UIFont systemFontOfSize:17 * self.numSingleVesion];
    lab2.textColor  = SMSColor(51, 51, 51);
    [lab2 sizeToFit];
    [view2 addSubview:lab2];
    

    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(15 *self.numSingleVesion, lab2.frame.origin.y + lab2.frame.size.height + 10 *self.numSingleVesion, self.view.frame.size.width - 30 *self.numSingleVesion, 30 * self.numSingleVesion)];
    lab3.text = [NSString stringWithFormat:@"%@",name];
    lab3.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lab3.textColor  = SMSColor(102, 102, 102);
    [lab3 sizeToFit];
    [view2 addSubview:lab3];
    
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(15 *self.numSingleVesion, lab3.frame.origin.y + lab3.frame.size.height + 10 *self.numSingleVesion, self.view.frame.size.width - 30 *self.numSingleVesion, 30 * self.numSingleVesion)];
    lab4.text = [NSString stringWithFormat:@"原价: %@",costPrice];
    lab4.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lab4.textColor  = SMSColor(102, 102, 102);
    [lab4 sizeToFit];
    [view2 addSubview:lab4];
    
    UILabel *lab5 = [[UILabel alloc] initWithFrame:CGRectMake(15 *self.numSingleVesion, lab4.frame.origin.y + lab4.frame.size.height + 10 *self.numSingleVesion, self.view.frame.size.width - 30 *self.numSingleVesion, 30 * self.numSingleVesion)];
    lab5.text = [NSString stringWithFormat:@"现价: %@",nowPrice];
    lab5.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lab5.textColor  = SMSColor(102, 102, 102);
    [lab5 sizeToFit];
    [view2 addSubview:lab5];
    
    UILabel *lab21 = [[UILabel alloc] initWithFrame:CGRectMake(15 *self.numSingleVesion, lab5.frame.origin.y + lab5.frame.size.height + 20 *self.numSingleVesion, self.view.frame.size.width - 30 *self.numSingleVesion, 30 * self.numSingleVesion)];
    lab21.text = @"商品库存";
    lab21.font = [UIFont systemFontOfSize:17 * self.numSingleVesion];
    lab21.textColor  = SMSColor(51, 51, 51);
    [lab21 sizeToFit];
    [view2 addSubview:lab21];
    
    UILabel *lab51 = [[UILabel alloc] initWithFrame:CGRectMake(15 *self.numSingleVesion, lab21.frame.origin.y + lab21.frame.size.height + 10 *self.numSingleVesion, self.view.frame.size.width - 30 *self.numSingleVesion, 30 * self.numSingleVesion)];
    lab51.text = [NSString stringWithFormat:@"剩余: %@",proInventory];
    lab51.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lab51.textColor  = SMSColor(102, 102, 102);
    [lab51 sizeToFit];
    [view2 addSubview:lab51];
    
    UILabel *lab22 = [[UILabel alloc] initWithFrame:CGRectMake(15 *self.numSingleVesion, lab51.frame.origin.y + lab51.frame.size.height + 20 *self.numSingleVesion, self.view.frame.size.width - 30 *self.numSingleVesion, 30 * self.numSingleVesion)];
    lab22.text = @"使用有效期";
    lab22.font = [UIFont systemFontOfSize:17 * self.numSingleVesion];
    lab22.textColor  = SMSColor(51, 51, 51);
    [lab22 sizeToFit];
    [view2 addSubview:lab22];
    
    UILabel *lab52 = [[UILabel alloc] initWithFrame:CGRectMake(15 *self.numSingleVesion, lab22.frame.origin.y + lab22.frame.size.height + 10 *self.numSingleVesion, self.view.frame.size.width - 30 *self.numSingleVesion, 30 * self.numSingleVesion)];
    lab52.text = [NSString stringWithFormat:@"%@",endTime];
    lab52.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lab52.textColor  = SMSColor(102, 102, 102);
    [lab52 sizeToFit];
    [view2 addSubview:lab52];
    
//    UILabel *labLast = [[UILabel alloc] initWithFrame:CGRectMake(15 *self.numSingleVesion, lab52.frame.origin.y + lab52.frame.size.height + 20 *self.numSingleVesion, self.view.frame.size.width - 30 *self.numSingleVesion, 1000 * self.numSingleVesion)];
//    NSLog(@"%@",other);
//    labLast.text = [NSString stringWithFormat:@"%@",other];
//    labLast.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
//    labLast.textColor  = SMSColor(102, 102, 102);
//    [labLast sizeToFit];
//    [view2 addSubview:labLast];
    NSLog(@"%f",lab52.frame.origin.y + lab52.frame.size.height + 20 *self.numSingleVesion);
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(5 *self.numSingleVesion, lab52.frame.origin.y + lab52.frame.size.height + 20 *self.numSingleVesion, self.view.frame.size.width - 10 *self.numSingleVesion, 1000 * self.numSingleVesion)];
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.bouncesZoom = NO;
    webView.scalesPageToFit = NO;//自动对页面进行缩放以适应屏幕
    webView.delegate=self;
    webView.autoresizesSubviews = NO; //自动调整大小
    webView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    webView.scrollView.scrollEnabled=NO;
    //    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",FIRSTSTRING,self.detial,LASTSTRING]]]];
    [webView loadHTMLString:[NSString stringWithFormat:@"%@",other] baseURL:nil];
//    NSLog(@"%@",[NSString stringWithFormat:@"%@%@%@",FIRSTSTRING,self.detial,LASTSTRING]);
    [view2 addSubview:webView];

    
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{

    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    CGRect newFrame = webView.frame;
    newFrame.size.height = actualSize.height;
    webView.frame = newFrame;
    self.Scro.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, webView.frame.origin.y+webView.frame.size.height );
    
}
-(void)dhAction1:(UIButton *)sender {
    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前积分不足!"   delegate:self     cancelButtonTitle:@"知道了" otherButtonTitles: nil ];
    //                alert.delegate = self;
                    [alert show];
}

-(void)dhAction:(UIButton *)sender {
    if (_popTag == 1) {
        _popTag = 0;
        [self.popView removeFromSuperview];
    }else{
        _popTag = 1;
        UIView *v1 = [[UIView alloc] initWithFrame:self.view.frame];
        v1.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:0.5];
        [self.view addSubview:v1];
        UIView *popView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290 *self.numSingleVesion, 253 * self.numSingleVesion)];
        popView.backgroundColor = [UIColor whiteColor];
        popView.layer.masksToBounds = YES;
        popView.layer.cornerRadius = 7.0 * self.numSingleVesion;

        popView.center = CGPointMake(self.view.frame.size.width/2, 321.5 * self.numSingleVesion);
        
        [v1 addSubview:popView];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65 * self.numSingleVesion, 65 * self.numSingleVesion)];
        imageV.center = CGPointMake(popView.frame.size.width/2, 67.5 * self.numSingleVesion);
//        imageV.backgroundColor = [UIColor cyanColor];
        [popView addSubview:imageV];
        
        UILabel *labName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, popView.frame.size.width - 50 * self.numSingleVesion, 50 * self.numSingleVesion)];
        labName.textColor = SMSColor(102, 102, 102);
        labName.text = [NSString stringWithFormat:@"使用%@兑换%@积分",@"1",@"100dsfasfffaasf"];
        labName.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
        labName.numberOfLines = 2;
        labName.center = CGPointMake(popView.frame.size.width/2, 148 * self.numSingleVesion);
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:labName.text];
        //设置字号
//        [str addAttribute:NSFontAttributeName value:font range:range];
        //设置文字颜色

        NSRange beginRange = [labName.text rangeOfString:@"使用"];
        NSRange beginRange1 = [labName.text rangeOfString:@"兑换"];
        NSRange lastRange = NSMakeRange(labName.text.length, 0);
        NSRange rangeB = NSMakeRange(beginRange.location + beginRange.length, beginRange1.location - beginRange.location - beginRange.length);
        NSRange rangeB1 = NSMakeRange(beginRange1.location + beginRange1.length, lastRange.location - beginRange1.location - beginRange1.length);
        
        
        
        [str addAttribute:NSForegroundColorAttributeName value:SMSColor(254, 150, 37) range:rangeB];
        [str addAttribute:NSForegroundColorAttributeName value:SMSColor(254, 150, 37) range:rangeB1];
        labName.attributedText = str;
        
        
        
        [popView addSubview:labName];
        
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, popView.frame.size.height - 45 * self.numSingleVesion, popView.frame.size.width, 1 * self.numSingleVesion)];
        lineV.backgroundColor = [UIColor lightGrayColor];
        [popView addSubview:lineV];
        UIView*lineV2 = [[UIView alloc] initWithFrame:CGRectMake(popView.frame.size.width/2 - 0.5 *self.numSingleVesion, popView.frame.size.height - 45 * self.numSingleVesion, 1 * self.numSingleVesion, 45 * self.numSingleVesion)];
        lineV2.backgroundColor = [UIColor lightGrayColor];
        [popView addSubview:lineV2];
        
        UILabel *qxLab = [[UILabel alloc] initWithFrame:CGRectZero];
        qxLab.textColor = SMSColor(254, 150, 37);
        qxLab.text = @"取消";
        qxLab.font = [UIFont systemFontOfSize:17 * self.numSingleVesion];
        qxLab.center = CGPointMake(55 * self.numSingleVesion, lineV.frame.origin.y + 12.5 * self.numSingleVesion);
        [qxLab sizeToFit];
        [popView addSubview:qxLab];
        
        UILabel *qdLab = [[UILabel alloc] initWithFrame:CGRectZero];
        qdLab.textColor = SMSColor(254, 150, 37);
        qdLab.text = @"确定";
        qdLab.font = [UIFont systemFontOfSize:17 * self.numSingleVesion];
        qdLab.center = CGPointMake(popView.frame.size.width - 90 * self.numSingleVesion, lineV.frame.origin.y + 12.5 * self.numSingleVesion);
        [qdLab sizeToFit];
        [popView addSubview:qdLab];
        
        
        self.popView = v1;
        
        UITapGestureRecognizer *tap1=[[ UITapGestureRecognizer alloc ] initWithTarget : self action : @selector (randomColor1:)];
        [qxLab addGestureRecognizer :tap1];
        qxLab. userInteractionEnabled = YES ;
        
        UITapGestureRecognizer *tap2=[[ UITapGestureRecognizer alloc ] initWithTarget : self action : @selector (randomColor2:)];
        [qdLab addGestureRecognizer :tap2];
        qdLab. userInteractionEnabled = YES ;
        
        
    }

    
}

-(void)randomColor1:( UITapGestureRecognizer *)gestureRecognizer{
    _popTag = 0;
    [self.popView removeFromSuperview];
}

-(void)randomColor2:( UITapGestureRecognizer *)gestureRecognizer{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:EXCHANGEGOODS,[StoreageMessage getMessage][2],self.pro_id] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"提示" message:getResult[@"message"]   delegate:self     cancelButtonTitle:@"确定" otherButtonTitles: nil ];
        //                alert.delegate = self;
        [alert show];
        
    }];
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
