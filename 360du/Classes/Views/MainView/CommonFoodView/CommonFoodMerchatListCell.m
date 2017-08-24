//
//  CommonFoodMerchatListCell.m
//  360du
//
//  Created by linghang on 15/5/16.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "CommonFoodMerchatListCell.h"
#import "UIImageView+WebCache.h"
#import "FoodMerchatListModel.h"
#import "CommonBusinessListCollectionViewCell.h"
#import "StoreageMessage.h"
#import "UIView+Toast.h"
@interface CommonFoodMerchatListCell()
@property(nonatomic,strong)UIImageView *leftImg;
@property(nonatomic,strong)UILabel *nameLable;
@property(nonatomic,strong)UILabel *sellNum;
@property(nonatomic,strong)UILabel *priceLable;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIButton *reduceBtn;
@property(nonatomic,strong)UILabel *selectBig;

@property (nonatomic,strong) FoodMerchatListItemModel *model;

@end
@implementation CommonFoodMerchatListCell
//-(id)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self makeUI];
//    }
//    return self;
//}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    //左边图片
    self.leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion, 16 * self.numSingleVersion, 70 * self.numSingleVersion, 60 * self.numSingleVersion)];
    [self.contentView addSubview:self.leftImg];
    //食物名称
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(90 * self.numSingleVersion, 20 * self.numSingleVersion, self.allWidth - 100 * self.numSingleVersion - 100 * self.numSingleVersion, 15 * self.numSingleVersion)];
    self.nameLable.font = [UIFont systemFontOfSize:15];
    self.nameLable.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.nameLable];
    //销售几份
    self.sellNum = [[UILabel alloc] initWithFrame:CGRectMake(90 * self.numSingleVersion, 40 * self.numSingleVersion, self.allWidth - 100 * self.numSingleVersion - 100 * self.numSingleVersion, 15 * self.numSingleVersion)];
    self.sellNum.textColor = SMSColor(160, 160, 160);
    [self.contentView addSubview:self.sellNum];
    self.sellNum.font = [UIFont systemFontOfSize:13];
    //价格
    self.priceLable = [[UILabel alloc] initWithFrame:CGRectMake(90 * self.numSingleVersion, 60 * self.numSingleVersion, 50 * self.numSingleVersion, 15 * self.numSingleVersion)];
    self.priceLable.textColor = [UIColor redColor];
    [self.contentView addSubview:self.priceLable];
    self.priceLable.font = [UIFont systemFontOfSize:13];
    
    //可选规格
    self.selectBig = [[UILabel alloc] initWithFrame:CGRectMake(self.allWidth - 100 * self.numSingleVersion - 30 * self.numSingleVersion - 10 * self.numSingleVersion - 20 * self.numSingleVersion, 50 * self.numSingleVersion, 53 * self.numSingleVersion, 20 * self.numSingleVersion)];
    self.selectBig.textColor = [UIColor redColor];
    [self.contentView addSubview:self.selectBig];
    self.selectBig.text = @"可选规格";
    self.selectBig.font = [UIFont systemFontOfSize:13];
    self.selectBig.layer.borderWidth = 1 * self.numSingleVersion;
    self.selectBig.layer.borderColor = [SMSColor(211, 211, 211) CGColor];
    self.selectBig.hidden = YES;
    //添加
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(self.allWidth - 105 * self.numSingleVersion - 25 * self.numSingleVersion, 60 * self.numSingleVersion, 25 * self.numSingleVersion, 25 * self.numSingleVersion);
    [self.addBtn setImage:[UIImage imageNamed:@"加.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.addBtn];
//    [self.addBtn addTarget:self action:@selector(addBtnDwon:) forControlEvents:UIControlEventTouchUpInside];
    self.addBtn.layer.cornerRadius = 7.5 * self.numSingleVersion;
    self.addBtn.layer.borderWidth = 1 * self.numSingleVersion;
    self.addBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//    self.addBtn.backgroundColor = [UIColor redColor];
    //减少
    self.reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reduceBtn.frame = CGRectMake(self.allWidth - 105 * self.numSingleVersion - 25 * self.numSingleVersion - 20 * self.numSingleVersion - 22 * self.numSingleVersion, 60 * self.numSingleVersion, 25 * self.numSingleVersion, 25 * self.numSingleVersion);
    [self.reduceBtn setImage:[UIImage imageNamed:@"减.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.reduceBtn];
//    [self.reduceBtn addTarget:self action:@selector(addBtnDwon:) forControlEvents:UIControlEventTouchUpInside];
    self.reduceBtn.layer.cornerRadius = 7.5 * self.numSingleVersion;
    self.reduceBtn.layer.borderWidth = 1 * self.numSingleVersion;
    self.reduceBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    //买几个
    self.buyCount = [[UILabel alloc] initWithFrame:CGRectMake(self.allWidth - 80 * self.numSingleVersion - 15 * self.numSingleVersion , 70 * self.numSingleVersion, 25 * self.numSingleVersion, 20 * self.numSingleVersion)];
    self.buyCount.font = [UIFont systemFontOfSize:13];
    self.buyCount.text = @"0";
    self.buyCount.textAlignment = UITextAlignmentCenter;
//    self.buyCount.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.buyCount];
    self.buyCount.textColor = [UIColor blackColor];
//    [self.buyCount sizeToFit];
    self.buyCount.center = CGPointMake(self.allWidth - 105 * self.numSingleVersion - 34 * self.numSingleVersion, 72 * self.numSingleVersion);
    
}




-(void)addBtnDwon:(UIButton *)addBtn{

    if ([self.target isKindOfClass:[CommonBusinessListCollectionViewCell class]]) {
        NSLog(@"%@",self.model.pid);
        if ([addBtn isEqual:self.addBtn]) {
            
//            NSLog(@"secion:%ld",addBtn.tag);
            NSInteger section = (addBtn.tag - 10000) / 1000;
            NSInteger number = (addBtn.tag - 10000) - section * 1000;
#warning message
            //    [self makeHUd];
            AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
            [twoPacking getUrl:[NSString stringWithFormat:JOINFOODCAR,[StoreageMessage getMessage][2],self.model.pid,self.mechIc,(long)1,@""] andFinishBlock:^(id getResult) {
                //        [self hudWasHidden:self.hudProgress];
                NSLog(@"%@",getResult);
                if (![getResult[@"code"] isEqualToString:@"000000"]) {
//                    self.buyCount.text = [NSString stringWithFormat:@"%ld",self.buyCount.text.integerValue + 1];
//;
                    [self.superview makeToast:getResult[@"message"]];
                }else{
                    self.buyCount.text = [NSString stringWithFormat:@"%ld",self.buyCount.text.integerValue + 1];
                    [self.target returnAddBtn:number andSection:section andAddAndReduce:@"1" andCount:self.buyCount.text];

                }
                
            }];
//            NSLog(@"secion:%ld number:%ld",section,number);
        }else{
            if (self.buyCount.text.integerValue != 0) {
                self.buyCount.text = [NSString stringWithFormat:@"%ld",self.buyCount.text.integerValue - 1];
                NSInteger section = (addBtn.tag - 20000) / 1000;
                NSInteger number = (addBtn.tag - 20000) - section * 1000;
                [self.target returnAddBtn:number andSection:section andAddAndReduce:@"-1" andCount:self.buyCount.text];
            }
        }
    }
}
/**
 *  商品列表cellmodel
 *
 *  @param model   <#model description#>
 *  @param num     <#num description#>
 *  @param section <#section description#>
 */

-(void)refeshModel:(FoodMerchatListItemModel *)model andNum:(NSInteger)num andSection:(NSInteger)section{
    
    [self.leftImg sd_setImageWithURL:[NSURL URLWithString:model.imgurl] placeholderImage:[UIImage imageNamed:@"商家底图"]];
    self.nameLable.text = model.name;
    self.sellNum.text = [NSString stringWithFormat:@"已售%@份     推荐%@份",model.sendCount,model.tuijianCount];
    self.priceLable.text = [NSString stringWithFormat:@"￥%@",model.price];

    if (model.rule.count != 0) {
        self.selectBig.hidden = NO;
        self.buyCount.hidden = YES;
        self.addBtn.hidden = YES;
        self.reduceBtn.hidden = YES;
        
    }else{
        self.selectBig.hidden = YES;
        self.buyCount.hidden = NO;
        self.addBtn.hidden = NO;
        self.reduceBtn.hidden = NO;
        if(!model.buyCount){
            self.buyCount.text = @"0";
        }else{
            self.buyCount.text = model.buyCount;
 
        }
    }
    self.addBtn.tag = 10000 + 1000 * section + num;
    self.reduceBtn.tag = 20000 + 1000 * section + num;
    self.model = model;
    [self.addBtn addTarget:self action:@selector(addBtnDwon:) forControlEvents:UIControlEventTouchUpInside];
    [self.reduceBtn addTarget:self action:@selector(addBtnDwon:) forControlEvents:UIControlEventTouchUpInside];


    
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
