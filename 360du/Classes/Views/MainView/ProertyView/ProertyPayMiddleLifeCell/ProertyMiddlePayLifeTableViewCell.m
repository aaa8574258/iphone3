//
//  ProertyMiddlePayLifeTableViewCell.m
//  360du
//
//  Created by linghang on 15/11/27.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "ProertyMiddlePayLifeTableViewCell.h"
#import "ProertyMiddlePayAddressListModel.h"
#import "ProertyMiddlePayAddressListViewController.h"
#import "NSString+URLEncoding.h"
@interface ProertyMiddlePayLifeTableViewCell()
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *telLab;
@property(nonatomic,strong)UILabel *addressLab;
@property(nonatomic,strong)UIButton *mendAddressButton;
@end
@implementation ProertyMiddlePayLifeTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    //姓名
    self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.numSingleVersion, 5 * self.numSingleVersion, self.allWidth - 60 * self.numSingleVersion, 15 * self.numSingleVersion)];
    [self.contentView addSubview:self.nameLab];
    self.nameLab.font = [UIFont systemFontOfSize:14];
    self.nameLab.textColor = [UIColor lightGrayColor];
    //电话
    self.telLab = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.numSingleVersion, 20 * self.numSingleVersion, self.allWidth - 60 * self.numSingleVersion, 15 * self.numSingleVersion)];
    self.telLab.font = [UIFont systemFontOfSize:14];
    self.telLab.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.telLab];
    //地址
//    self.addressLab = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.numSingleVersion, 20 * self.numSingleVersion, self.allWidth - 30 * self.numSingleVersion, 30 * self.numSingleVersion)];
//    self.addressLab.font = [UIFont systemFontOfSize:14];
//    self.addressLab.numberOfLines = 2;
//    [self.contentView addSubview:self.addressLab];
    //修改按钮
    self.mendAddressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mendAddressButton.frame = CGRectMake(self.allWidth - 50 * self.numSingleVersion, 5 * self.numSingleVersion, 40 * self.numSingleVersion, 40 * self.numSingleVersion);
    [self.mendAddressButton setTitle:@"修改" forState:UIControlStateNormal];
    [self.mendAddressButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.mendAddressButton.font = [UIFont systemFontOfSize:12];
    [self.mendAddressButton addTarget:self action:@selector(mendBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    self.mendAddressButton.userInteractionEnabled = YES;
    [self.contentView addSubview:self.mendAddressButton];
}
-(void)mendBtnDown:(UIButton *)mendBtn{
    if([self.target isKindOfClass:[ProertyMiddlePayAddressListViewController class]]){
        [self.target returnRow:mendBtn.tag - 1450];
    }
}
-(void)refreshModel:(ProertyMiddlePayAddressListModel *)model andRow:(NSInteger)row{
    if ([model.isDefault isEqual:@"Y"]) {
        //[self.mendAddressButton setTitle:@"默认" forState:UIControlStateNormal];
        self.telLab.textColor = [UIColor redColor];
        self.nameLab.textColor = [UIColor redColor];
    }else{
        //[self.mendAddressButton setTitle:@"" forState:UIControlStateNormal];
        self.telLab.textColor = [UIColor lightGrayColor];
        self.nameLab.textColor = [UIColor lightGrayColor];
    }
    self.nameLab.text = [NSString stringWithFormat:@"%@ %@ %@",[model.nickName URLDecodedString],model.phone,model.wyName];
    //self.addressLab.text = model.address;
    NSMutableString *tempStr = [NSMutableString stringWithCapacity:0];
    NSArray *valueArr = @[model.UnitNo,model.builde,model.houseNo];
    NSArray *keyArr = @[@"栋",@"单元",@"号"];
    for (NSInteger i = 0; i < keyArr.count; i++) {
        [tempStr appendString:[NSString stringWithFormat:@"%ld",[valueArr[i] integerValue]]];
        [tempStr appendString:keyArr[i]];
    }
    self.telLab.text = [NSString stringWithFormat:@"%@ %@",model.xqName,tempStr];
    self.mendAddressButton.tag = 1450 + row;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
