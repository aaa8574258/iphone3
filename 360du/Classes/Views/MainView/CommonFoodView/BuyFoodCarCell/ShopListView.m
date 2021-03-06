//
//  ShopListView.m
//  360du
//
//  Created by linghang on 15/7/6.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "ShopListView.h"
#import "ShoppingCarViewController.h"
#import "FoodMerchatListModel.h"
#import "ShoplistModel.h"
#import "FoodBussinessListCollectionViewController.h"
#import "StoreageMessage.h"
@interface ShopListView()
@property(nonatomic,strong)NSMutableArray *priceArr;
@property(nonatomic,strong)NSMutableArray *priceCountArr;
@property(nonatomic,strong)UILabel *nameLable;
@property(nonatomic,strong)UILabel *priceLable;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIButton *reduceBtn;
@property(nonatomic,strong)UILabel *buyCount;
@property(nonatomic,strong)UILabel *specification;//规格
@end
@implementation ShopListView
-(id)initWithFrame:(CGRect)frame andArr:(NSArray *)priceArr{
    self = [super initWithFrame:frame];
    if (self) {
        self.priceCountArr = [priceArr mutableCopy];
        self.priceArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *temp in priceArr) {
            ShoplistModel *mdoel = [[ShoplistModel alloc] initWithDictionary:temp];
            [self.priceArr addObject:mdoel];
        }
        [self makeHeadView];
        [self makeUI];
    }
    return self;
}
-(void)makeHeadView{
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    UILabel *leftLable = [[UILabel alloc] initWithFrame:CGRectZero];
    leftLable.textColor = [UIColor lightGrayColor];
    leftLable.font = [UIFont systemFontOfSize:13];
    leftLable.text = @"购物车";
    [view addSubview:leftLable];
    [leftLable sizeToFit];
    leftLable.center = CGPointMake(2 * self.numSingleVesion + leftLable.frame.size.width, 15 * self.numSingleVesion);
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [clearButton setTitle:@"清空全部" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearAll) forControlEvents:UIControlEventTouchUpInside];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [clearButton sizeToFit];
    clearButton.frame = CGRectMake(WIDTH_VIEW - 2 * self.numSingleVesion - clearButton.frame.size.width, 5 * self.numSingleVesion, clearButton.frame.size.width, 20 * self.numSingleVesion);
    clearButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:clearButton];
    [self addSubview:view];
}
-(void)clearAll{
    if ([self.target isKindOfClass:[FoodBussinessListCollectionViewController class]]) {
        [self.target clearAllBuyCar];
    }
}
-(void)makeUI{
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,40 * self.numSingleVesion, WIDTH_VIEW, self.frame.size.height - 40 * self.numSingleVesion)];
    [self addSubview:scrollView];
    //scrollView.backgroundColor = [UIColor redColor];
    //scrollView.showsVerticalScrollIndicator = NO;
    //scrollView.contentSize = CGSizeMake(WIDTH_VIEW, [self.priceArr count] * 100 * self.numSingleVesion);
    scrollView.contentSize = CGSizeMake(WIDTH_VIEW, 30 * self.numSingleVesion * self.priceArr.count);
    
    for (NSInteger i = 0; i < self.priceArr.count; i++) {
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.numSingleVesion, 10 * self.numSingleVesion + 30 * self.numSingleVesion * i, 100 * self.numSingleVesion, 15 * self.numSingleVesion)];
        self.nameLable.font = [UIFont systemFontOfSize:14];
        [scrollView addSubview:self.nameLable];
        
        
        //添加
        self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addBtn.frame = CGRectMake(WIDTH_VIEW  - 25 * self.numSingleVesion, 4 * self.numSingleVesion + 30 * self.numSingleVesion * i, 24 * self.numSingleVesion, 24 * self.numSingleVesion);
        [self.addBtn setImage:[UIImage imageNamed:@"加.png"] forState:UIControlStateNormal];
        [scrollView addSubview:self.addBtn];
        [self.addBtn addTarget:self action:@selector(addBtnDwon:) forControlEvents:UIControlEventTouchUpInside];
        self.addBtn.layer.cornerRadius = 12 * self.numSingleVesion;
        self.addBtn.layer.borderWidth = 1 * self.numSingleVesion;
        self.addBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.addBtn.tag = 10000 + i;
        
        //减少
        self.reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.reduceBtn.frame = CGRectMake(WIDTH_VIEW  - 30 * self.numSingleVesion - 10 * self.numSingleVesion - 30 * self.numSingleVesion, 4 * self.numSingleVesion + 30 * self.numSingleVesion * i, 24 * self.numSingleVesion, 24 * self.numSingleVesion);
        [self.reduceBtn setImage:[UIImage imageNamed:@"减.png"] forState:UIControlStateNormal];
        [scrollView addSubview:self.reduceBtn];
        [self.reduceBtn addTarget:self action:@selector(addBtnDwon:) forControlEvents:UIControlEventTouchUpInside];
        self.reduceBtn.layer.cornerRadius = 12 * self.numSingleVesion;
        self.reduceBtn.layer.borderWidth = 1 * self.numSingleVesion;
        self.reduceBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.reduceBtn.tag = 20000 + i;
        
        //买几个
        self.buyCount = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_VIEW  - 30 * self.numSingleVesion - 20 * self.numSingleVesion, 10 * self.numSingleVesion + 30 * self.numSingleVesion * i, 20 * self.numSingleVesion, 12 * self.numSingleVesion)];
        self.buyCount.font = [UIFont systemFontOfSize:12];
        self.buyCount.text = @"0";
        [scrollView addSubview:self.buyCount];
        self.buyCount.textColor = [UIColor blackColor];
//        [self.buyCount sizeToFit];
        self.buyCount.center = CGPointMake(self.frame.size.width  - 30 * self.numSingleVesion - 3 * self.numSingleVesion, 15 * self.numSingleVesion + 30 * self.numSingleVesion * i);
        self.buyCount.tag = 30000 + i;
        //价格
        self.priceLable = [[UILabel alloc] initWithFrame:CGRectZero];
        self.priceLable.font = [UIFont systemFontOfSize:14];
        [scrollView addSubview:self.priceLable];
        //刷新数据
        ShoplistModel *mode = self.priceArr[i];
        //名字
        FoodMerchatListItemModel *model = mode.model;
        self.nameLable.text = model.name;
        [self.nameLable sizeToFit];
        self.nameLable.center = CGPointMake(5 * self.numSingleVesion + self.nameLable.frame.size.width / 2, 15 * self.numSingleVesion + 30 * self.numSingleVesion * i);
        //价格
        self.priceLable.text = [NSString stringWithFormat:@"￥%@",model.unitPrice];
        [self.priceLable sizeToFit];
        self.priceLable.center = CGPointMake(WIDTH_VIEW - 30 * self.numSingleVesion - 10 * self.numSingleVesion - 30 * self.numSingleVesion - 5 * self.numSingleVesion - self.priceLable.frame.size.width / 2, 15 * self.numSingleVesion + 30 * self.numSingleVesion * i);
        //数量
        self.buyCount.text = mode.count;
    }
}
-(void)addBtnDwon:(UIButton *)addBtn{
    if ([self.target isKindOfClass:[FoodBussinessListCollectionViewController class]]) {
        if (addBtn.tag < 20000) {
            UILabel  *buyCount = (UILabel *)[self viewWithTag:30000 + addBtn.tag - 10000];
            buyCount.text = [NSString stringWithFormat:@"%ld",buyCount.text.integerValue + 1];
            //刷新数据
            ShoplistModel *mode = self.priceArr[addBtn.tag - 10000];
            //名字
            FoodMerchatListItemModel *model = mode.model;
            [self.target returnBuyCar:model andAddAndReduce:@"2" andBuyCount:buyCount.text];

             
        }else{
            
            UILabel  *buyCount = (UILabel *)[self viewWithTag:30000 + addBtn.tag - 20000];
            if (buyCount.text.integerValue == 0) {
                return;
            }

            if (buyCount.text.integerValue != 0) {
                buyCount.text = [NSString stringWithFormat:@"%ld",buyCount.text.integerValue - 1];
            }
            //刷新数据
            ShoplistModel *mode = self.priceArr[addBtn.tag - 20000];
            //名字
            FoodMerchatListItemModel *model = mode.model;
            [self.target returnBuyCar:model andAddAndReduce:@"-1" andBuyCount:buyCount.text];
            
        }
    }
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
