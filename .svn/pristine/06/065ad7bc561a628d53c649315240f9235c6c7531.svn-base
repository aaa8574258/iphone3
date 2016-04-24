//
//  ShoplistCarCell.m
//  360du
//
//  Created by linghang on 15/7/6.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "ShoplistCarCell.h"
#import "FoodMerchatListModel.h"
#import "ShoplistModel.h"
#import "ShoppingCarViewController.h"
@interface ShoplistCarCell ()
@property(nonatomic,strong)UILabel *nameLable;
@property(nonatomic,strong)UILabel *priceLable;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIButton *reduceBtn;
@property(nonatomic,strong)UILabel *buyCount;
@end

@implementation ShoplistCarCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.numSingleVersion, 10 * self.numSingleVersion, 100 * self.numSingleVersion, 15 * self.numSingleVersion)];
    self.nameLable.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.nameLable];
    
    
    //添加
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(self.allWidth  - 30 * self.numSingleVersion, 5 * self.numSingleVersion, 20 * self.numSingleVersion, 20 * self.numSingleVersion);
    [self.addBtn setImage:[UIImage imageNamed:@"加.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.addBtn];
    [self.addBtn addTarget:self action:@selector(addBtnDwon:) forControlEvents:UIControlEventTouchUpInside];
    self.addBtn.layer.cornerRadius = 10 * self.numSingleVersion;
    self.addBtn.layer.borderWidth = 1 * self.numSingleVersion;
    self.addBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    //减少
    self.reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reduceBtn.frame = CGRectMake(self.allWidth  - 30 * self.numSingleVersion - 10 * self.numSingleVersion - 20 * self.numSingleVersion, 5 * self.numSingleVersion, 20 * self.numSingleVersion, 20 * self.numSingleVersion);
    [self.reduceBtn setImage:[UIImage imageNamed:@"减.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.reduceBtn];
    [self.reduceBtn addTarget:self action:@selector(addBtnDwon:) forControlEvents:UIControlEventTouchUpInside];
    self.reduceBtn.layer.cornerRadius = 10 * self.numSingleVersion;
    self.reduceBtn.layer.borderWidth = 1 * self.numSingleVersion;
    self.reduceBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    //买几个
    self.buyCount = [[UILabel alloc] initWithFrame:CGRectMake(self.allWidth  - 30 * self.numSingleVersion - 10 * self.numSingleVersion, 10 * self.numSingleVersion, 10 * self.numSingleVersion, 10 * self.numSingleVersion)];
    self.buyCount.font = [UIFont systemFontOfSize:13];
    self.buyCount.text = @"0";
    [self.contentView addSubview:self.buyCount];
    self.buyCount.textColor = [UIColor blackColor];
    [self.buyCount sizeToFit];
    self.buyCount.center = CGPointMake(self.allWidth  - 30 * self.numSingleVersion - 5 * self.numSingleVersion, 15 * self.numSingleVersion);
    //价格
    self.priceLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.priceLable.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.priceLable];
    
}
-(void)addBtnDwon:(UIButton *)addBtn{
    if ([self.target isKindOfClass:[[ShoppingCarViewController copy] class]]) {
        if ([addBtn isEqual:self.addBtn]) {
            [self.target returnAddBtn:addBtn.tag - 10000 andAddAndReduce:1];
        }else{
            [self.target returnAddBtn:addBtn.tag - 20000 andAddAndReduce:-1];
        }
    }
}
-(void)refreshModel:(ShoplistModel *)mode andRow:(NSInteger)row{
    //名字
    FoodMerchatListItemModel *model = mode.model;
    self.nameLable.text = model.name;
    [self.nameLable sizeToFit];
    self.nameLable.center = CGPointMake(5 * self.numSingleVersion + self.nameLable.frame.size.width / 2, 15 * self.numSingleVersion);
    //价格
    self.priceLable.text = [NSString stringWithFormat:@"￥%@",model.price];
    [self.priceLable sizeToFit];
    self.priceLable.center = CGPointMake(self.allWidth - 30 * self.numSingleVersion - 10 * self.numSingleVersion - 20 * self.numSingleVersion - 5 * self.numSingleVersion - self.priceLable.frame.size.width / 2, 15 * self.numSingleVersion);
    //数量
    self.buyCount.text = mode.count;
    
    self.addBtn.tag = 10000 + row;
    self.reduceBtn.tag = 20000 + row;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
