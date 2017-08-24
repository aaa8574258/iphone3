//
//  WaterTableViewCell.m
//  360du
//
//  Created by 利美 on 16/10/17.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "WaterTableViewCell.h"

@implementation WaterTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    
    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 50)];
    _label1.backgroundColor = [UIColor colorWithRed:236/255.0 green:82/255.0 blue:86/255.0 alpha:1];
//    _label1.text = @"饮用水";
    _label1.textAlignment = UITextAlignmentCenter;
    _label1.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_label1];
    
    
    self.txF1 = [[UITextField alloc] initWithFrame:CGRectMake(10, 70, WIDTH_CONTENTVIEW - 40, 30)];
//    _txF1.placeholder = @"在此输入饮用水吨数";
    _txF1.contentVerticalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.contentView addSubview:_txF1];
    
    self.lab3 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - 40, 70 , 30, 30)];
//    _lab3.text = @"吨";
    [self.contentView addSubview:_lab3];
    
    //    UILabel *labsj1 = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT_CONTENTVIEW / 4 + 20 , 30, 30)];
    //    labsj1.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:labsj1];
    
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn1 setTitle:@"确定" forState:UIControlStateNormal];
    [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btn1.frame = CGRectMake(WIDTH_CONTENTVIEW - 60, 110, 50, 30);
    
    _btn1.backgroundColor = [UIColor colorWithRed:236/255.0 green:82/255.0 blue:86/255.0 alpha:1];
    [self.contentView addSubview:_btn1];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
