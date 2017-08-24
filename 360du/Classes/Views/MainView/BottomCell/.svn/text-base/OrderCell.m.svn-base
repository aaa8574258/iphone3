//
//  OrderCell.m
//  360du
//
//  Created by linghang on 15/8/1.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "OrderCell.h"
#import "OrderModel.h"
#import "UIImageView+WebCache.h"
@interface OrderCell()
@property(nonatomic,strong)UIImageView *leftImg;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *price;
@property(nonatomic,strong)UILabel *time;
@property(nonatomic,strong)UILabel *state;
@end
@implementation OrderCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    CGFloat width = 70 * self.numSingleVersion + 10 * self.numSingleVersion,heght = 70 * self.numSingleVersion;
    //图片
    self.leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(5 * self.numSingleVersion, 5 * self.numSingleVersion, width, heght)];
    [self.contentView addSubview:self.leftImg];
    width += 10 * self.numSingleVersion;
    //标题
    self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(width, 5 * self.numSingleVersion, 300, 15 * self.numSingleVersion)];
    self.titleLable.font = [UIFont systemFontOfSize:16 * self.numSingleVersion];
    [self addSubview:self.titleLable];
    
    
    //价格
    self.time = [[UILabel alloc] initWithFrame:CGRectMake(width, 44 * self.numSingleVersion + 10 * self.numSingleVersion, 300, 15 * self.numSingleVersion)];
    self.time.font = [UIFont systemFontOfSize:13 * self.numSingleVersion];
    [self.contentView addSubview:self.time];
    self.time.textColor = [UIColor lightGrayColor];
    
    
    //销售数量
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(width, (80 - 15) / 2 * self.numSingleVersion, 200 * self.numSingleVersion, 15 * self.numSingleVersion)];
    self.price.font = [UIFont systemFontOfSize:13 * self.numSingleVersion];
    self.price.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.price];
    
    //配送
    self.state = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.state];
    
    //时间
    self.time = [[UILabel alloc] initWithFrame:CGRectMake(width, 60 * self.numSingleVersion, WIDTH_CONTENTVIEW - 60 * self.numSingleVersion - 30 * self.numSingleVersion, 15 * self.numSingleVersion)];
    self.time.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.time];
    self.time.textColor = SMSColor(151, 151, 151);
}
-(void)refreshModel:(OrderModel *)orderModel{
    [self.leftImg sd_setImageWithURL:[NSURL URLWithString:orderModel.shoptubiao] placeholderImage:[UIImage imageNamed:@"001"]];
    self.titleLable.text = orderModel.shopname;
    self.price.text = [NSString stringWithFormat:@"消费金额  ￥%@",orderModel.OrderAmount];
    self.state.text = orderModel.zwOrderStatus;
    [self.state sizeToFit];
    self.state.center = CGPointMake(self.allWidth - 10 * self.numSingleVersion - self.state.frame.size.width / 2, self.frame.size.height / 2);
    //时间
    self.time.text = orderModel.AddTime;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
