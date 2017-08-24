//
//  CleanerInfoTableViewCell.h
//  360du
//
//  Created by 利美 on 16/4/27.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CleanerListModel.h"
@interface CleanerInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameID;
@property (weak, nonatomic) IBOutlet UIImageView *nameImage;
@property (weak, nonatomic) IBOutlet UILabel *renZhengLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *StarIamge;
@property (weak, nonatomic) IBOutlet UIButton *telButton;
@property (weak, nonatomic) IBOutlet UILabel *juliLabel;




-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
