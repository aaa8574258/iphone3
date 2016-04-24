//
//  BuyFoodCarCell.m
//  360du
//
//  Created by linghang on 15/7/6.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BuyFoodCarCell.h"
@interface BuyFoodCarCell()
@property(nonatomic,strong)UILabel *nameLable;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UILabel *hintText;
@property(nonatomic,strong)UILabel *priceLable;
@property(nonatomic,strong)UILabel *countLable;
@end
@implementation BuyFoodCarCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return  self;
}
-(void)makeUI{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
