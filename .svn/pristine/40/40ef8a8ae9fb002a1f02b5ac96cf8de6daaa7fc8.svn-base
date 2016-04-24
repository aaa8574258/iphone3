//
//  GainVideoImg.m
//  XiaomiIOs
//
//  Created by linghang on 15-3-31.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "GainVideoImg.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@implementation GainVideoImg
+(UIImage *)gainImg:(NSString *)url andWidth:(CGFloat)width andHeight:(CGFloat)height{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:url] options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(width, height);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(20, 10) actualTime:NULL error:&error];
   UIImage *image = [UIImage imageWithCGImage:img];
    if (error != nil)
    {
        image = [UIImage imageNamed:CFBridgingRelease(img)];
    }
    return image;
    
}
@end
