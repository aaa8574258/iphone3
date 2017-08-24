//
//  PaiXTableViewController.h
//  360du
//
//  Created by 利美 on 16/4/29.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol sendLeiX <NSObject>

-(void) sendLeiX:(NSString *)string andCode:(NSString *)code;

@end

@interface PaiXTableViewController : UITableViewController

@property (nonatomic ,strong) NSArray *arr;
@property (nonatomic ,assign) id <sendLeiX> LeiXdelegate;

@end
