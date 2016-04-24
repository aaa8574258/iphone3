//
//  BottomPersonScrollview.h
//  360du
//
//  Created by linghang on 15/8/13.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomPersonScrollview : UIScrollView
@property(nonatomic,assign)id target;
-(id)initWithFrame:(CGRect)frame andNameArr:(NSArray *)nameArr andImageArr:(NSArray *)imageArr;
@end
