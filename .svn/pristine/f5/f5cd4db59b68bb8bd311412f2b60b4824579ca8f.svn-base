//
//  BaseView.m
//  XiaomiIOs
//
//  Created by linghang on 15-3-12.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseView.h"


@implementation BaseView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.numSingleVesion = [VersionTranlate returnVersionRateAnyIphone:WIDTH_VIEW];
        
    }
    return self;
}
#pragma mark hud的代理
//加载图片
-(void)makeHUd{
    self.hudProgress = [[MBProgressHUD alloc] initWithView:self];
    self.hudProgress.delegate = self;
    //self.hudProgress.color = [UIColor clearColor];
    self.hudProgress.labelText = @"loading";
    self.hudProgress.dimBackground = YES;
    //self.hudProgress.margin = 80.f;
    //self.hudProgress.yOffset = 150.f;
    [self addSubview:self.hudProgress];
    [self.hudProgress showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}

#pragma mark HUD的代理方法,关闭HUD时执行
-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}
-(void) myProgressTask{
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        self.hudProgress.progress = progress;
        usleep(50000);
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
