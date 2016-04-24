//
//  BaseTableViewCell.m
//  XiaomiIOs
//
//  Created by linghang on 15-3-27.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "VersionTranlate.h"
#import "UIFontShareInstance.h"
@implementation BaseTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         self.numSingleVersion = [VersionTranlate returnVersionRateAnyIphone:WIDTH_CONTENTVIEW];
         UIFontShareInstance *shareInstance = [UIFontShareInstance shareInstance];
        self.allWidth = shareInstance.width;
    }
    return  self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
