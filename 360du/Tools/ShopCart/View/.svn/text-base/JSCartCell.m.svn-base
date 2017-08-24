//
//  JSCartCell.m
//  JSShopCartModule
//
//  Created by 乔同新 on 16/6/9.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import "JSCartCell.h"
#import "JSNummberCount.h"
#import "JSCartModel.h"

@interface JSCartCell ()

@property (weak, nonatomic) IBOutlet UILabel        *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *GoodsPricesLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *goodsImageView;

@end

@implementation JSCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setModel:(JSCartModel *)model{
    
    self.goodsNameLabel.text             = model.proName;
    self.GoodsPricesLabel.text           = [NSString stringWithFormat:@"￥%0.2f",model.unitPrice];
    self.nummberCount.totalNum           = 9999;
    self.nummberCount.currentCountNumber = model.count;
    self.selectShopGoodsButton.selected  = model.isSelect;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
}

+ (CGFloat)getCartCellHeight{
    
    return 100;
}

@end
