//
//  StarView.m
//  360du
//
//  Created by 利美 on 16/4/28.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "StarView.h"

@implementation StarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@synthesize starSize = _starSize;
@synthesize maxStar = _maxStar;
@synthesize showStar = _showStar;
@synthesize emptyColor = _emptyColor;
@synthesize fullColor = _fullColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        //默认的星星的大小是 13.0f
        self.starSize = 13.0f;
        //未点亮时的颜色是 灰色的
        self.emptyColor = [UIColor colorWithRed:167.0f / 255.0f green:167.0f / 255.0f blue:167.0f / 255.0f alpha:1.0f];
        //点亮时的颜色是 亮黄色的
        self.fullColor = [UIColor colorWithRed:255.0f / 255.0f green:121.0f / 255.0f blue:22.0f / 255.0f alpha:1.0f];
        //默认的长度设置为100
        self.maxStar = 100;
    }
    
    return self;
}

//重绘视图
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSString* stars = @"★★★★★";
    
    
    
    
    
    rect = self.bounds;
    UIFont *font = [UIFont boldSystemFontOfSize:_starSize];
    CGSize starSize = [stars sizeWithFont:font];
    rect.size=starSize;
    [_emptyColor set];
    [stars drawInRect:rect withFont:font];
    
    CGRect clip = rect;
    clip.size.width = clip.size.width * _showStar / _maxStar;
    CGContextClipToRect(context,clip);
    [_fullColor set];
    [stars drawInRect:rect withFont:font];
}



@end
