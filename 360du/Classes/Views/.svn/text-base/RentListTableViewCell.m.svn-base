//
//  RentListTableViewCell.m
//  360du
//
//  Created by 利美 on 16/6/21.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "RentListTableViewCell.h"

@implementation RentListTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}

-(void)makeUI{
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 140, 100)];
//    self.image.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.image];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, self.contentView.frame.size.width - 125, 40)];
//    self.titleLab.backgroundColor = [UIColor cyanColor];
    self.titleLab.numberOfLines = 0;
    self.titleLab.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleLab];
    
    self.addLab = [[UILabel alloc] initWithFrame:CGRectMake(160, 52, self.contentView.frame.size.width - 20 , 25)];
//    [self.addLab sizeToFit];
//    self.addLab.backgroundColor = [UIColor cyanColor];
    self.addLab.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.addLab];
    
//    self.styLab = [[UILabel alloc] initWithFrame:CGRectMake(160, 52, self.contentView.frame.size.width - 150 , 25)];
//    [self.styLab sizeToFit];
//    //    self.addLab.backgroundColor = [UIColor cyanColor];
//    self.styLab.font = [UIFont systemFontOfSize:10];
//    [self.contentView addSubview:self.styLab];
//    
//    self.mjLab = [[UILabel alloc] initWithFrame:CGRectMake(160, 52, self.contentView.frame.size.width - 150 , 25)];
//    [self.mjLab sizeToFit];
    
    //    self.addLab.backgroundColor = [UIColor cyanColor];
    self.mjLab.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.mjLab];
    
    
    self.moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(160, 80, self.contentView.frame.size.width - 150 , 30)];
//    self.moneyLab.backgroundColor = [UIColor cyanColor];
    self.moneyLab.font = [UIFont systemFontOfSize:16];
    self.moneyLab.textColor = [UIColor orangeColor];
    
    self.jlLab = [[UILabel alloc] initWithFrame:CGRectMake(260, 80, self.contentView.frame.size.width - 150 , 30)];
    //    self.moneyLab.backgroundColor = [UIColor cyanColor];
    self.jlLab.font = [UIFont systemFontOfSize:10];
//    self.jlLab.textColor = [UIColor orangeColor];
    [self.contentView addSubview:self.jlLab];
    
    [self.contentView addSubview:self.moneyLab];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
