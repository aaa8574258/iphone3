//
//  MakeHUdProView.h
//  360du
//
//  Created by linghang on 15/7/4.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface MakeHUdProView : UIView<MBProgressHUDDelegate>
@property(nonatomic,strong)MBProgressHUD *mbpHUD;
-(id)init;
-(void)makeHud:(UIView *)view;
//-(void)
@end
