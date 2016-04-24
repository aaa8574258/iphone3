//
//  ProertyMendAndServiecListCell.m
//  360du
//
//  Created by linghang on 15/7/19.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "ProertyMendAndServiecListCell.h"
#import "PropertyMendAndServiceListModel.h"
#import "UIImageView+WebCache.h"
@interface ProertyMendAndServiecListCell()
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *contentLable;
@property(nonatomic,strong)UIButton *videoBtn;
@property(nonatomic,strong)UIButton *audioBtn;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,assign)CGFloat allheight;
@end
@implementation ProertyMendAndServiecListCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
-(void)makeUI:(PropertyMendAndServiceListModel *)model andImageAndVoiceAndVideo:(NSArray *)imageAndVoiceAndVideoArr{
    CGFloat width = 320;
    width = self.allWidth;
    //标题
    self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(35 * self.numSingleVersion, 15 * self.numSingleVersion + self.allheight, width - 45 * self.numSingleVersion, [imageAndVoiceAndVideoArr[0] integerValue] + 20 * self.numSingleVersion)];
    self.titleLable.font = [UIFont systemFontOfSize:14 * self.numSingleVersion];
    self.titleLable.numberOfLines = 0;
    self.titleLable.textColor = [UIColor colorWithRed:(CGFloat)102 / 255.0 green:(CGFloat)102 / 255.0 blue:(CGFloat)102 / 255.0 alpha:1];
    [self.contentView addSubview:self.titleLable];
    self.titleLable.text = model.RepairContent;
    
    self.titleLable.font = [UIFont boldSystemFontOfSize:15 * self.numSingleVersion];
    //高度
    self.allheight += 15 * self.numSingleVersion;
    self.allheight += [imageAndVoiceAndVideoArr[0] integerValue];
    //图片
    if ([imageAndVoiceAndVideoArr[1] count] != 0) {
        CGFloat everWidth = 100 * self.numSingleVersion;
        self.allheight += 15 * self.numSingleVersion;
        for (NSInteger i = 0; i < [imageAndVoiceAndVideoArr[1] count]; i++) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15 * self.numSingleVersion + (everWidth + 15 * self.numSingleVersion) * i, self.allheight, everWidth, 72 * self.numSingleVersion)];
            [imgView sd_setImageWithURL:[NSURL URLWithString:imageAndVoiceAndVideoArr[1][i]] placeholderImage:[UIImage imageNamed:@"default1.png"]];
            imgView.tag = 4000 + i;
            [self.contentView addSubview:imgView];
        }
        self.allheight += 72 * self.numSingleVersion;
    }
    //录音
    if([imageAndVoiceAndVideoArr[2] count] != 0){
        self.allheight += 15 * self.numSingleVersion;
        for (NSInteger i = 0; i < [imageAndVoiceAndVideoArr[2] count]; i++) {
            if (i == 0) {
                UIView *videoView = [[UIView alloc] initWithFrame:CGRectMake(15 * self.numSingleVersion, self.allheight, 250 * self.numSingleVersion, 34 * self.numSingleVersion)];
                videoView.backgroundColor = [UIColor colorWithRed:(CGFloat)255 / 255.0 green:(CGFloat)255 / 255.0 blue:(CGFloat)255 / 255.0 alpha:1];
                videoView.layer.borderWidth = 1 * self.numSingleVersion;
                videoView.layer.borderColor = [[UIColor colorWithRed:(CGFloat)232 / 255.0 green:(CGFloat)232 / 255.0 blue:(CGFloat)232 / 255.0 alpha:1] CGColor];
                [self.contentView addSubview:videoView];
                
                self.audioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                self.audioBtn.frame = CGRectMake(15 * self.numSingleVersion, (34 - 22) / 2 * self.numSingleVersion, 22 * self.numSingleVersion, 22 * self.numSingleVersion);
                [self.audioBtn addTarget:self action:@selector(playVideoAndAudio:) forControlEvents:UIControlEventTouchUpInside];
                [videoView addSubview:self.audioBtn];
                [self.audioBtn setImage:[UIImage imageNamed:@"tone---music@2x.png"] forState:UIControlStateNormal];
                
                
                UILabel *audioLable = [[UILabel alloc] initWithFrame:CGRectMake(35 * self.numSingleVersion, self.allheight + 5 * self.numSingleVersion, width - 35 * self.numSingleVersion, 22 * self.numSingleVersion)];
                
               // audioLable.text = [self compenstate:self.notesModel.note_files[@"audio"]];
                audioLable.text = imageAndVoiceAndVideoArr[2][0];
                audioLable.font = [UIFont systemFontOfSize:12 * self.numSingleVersion];
                [audioLable sizeToFit];
                [videoView addSubview:audioLable];
                audioLable.textColor = [UIColor lightGrayColor];
                audioLable.center = CGPointMake((15 + 22 + 15) * self.numSingleVersion + audioLable.frame.size.width / 2, 17 * self.numSingleVersion);
                
                self.allheight += 34 * self.numSingleVersion;
            }
        }
    }
    //录像
    if ([imageAndVoiceAndVideoArr[3] count] != 0) {
        self.allheight += 15 * self.numSingleVersion;
        for (NSInteger i = 0; i < [imageAndVoiceAndVideoArr[3] count]; i++) {
            if (i == 0) {
                UIView *videoView = [[UIView alloc] initWithFrame:CGRectMake(15 * self.numSingleVersion, self.allheight, 250 * self.numSingleVersion, 34 * self.numSingleVersion)];
                videoView.backgroundColor = [UIColor colorWithRed:(CGFloat)255 / 255.0 green:(CGFloat)255 / 255.0 blue:(CGFloat)255 / 255.0 alpha:1];
                videoView.layer.borderWidth = 1 * self.numSingleVersion;
                videoView.layer.borderColor = [[UIColor colorWithRed:(CGFloat)232 / 255.0 green:(CGFloat)232 / 255.0 blue:(CGFloat)232 / 255.0 alpha:1] CGColor];
                [self.contentView addSubview:videoView];
                
                self.videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                self.videoBtn.frame = CGRectMake(15 * self.numSingleVersion, (34 - 22) / 2 * self.numSingleVersion, 22 * self.numSingleVersion, 22 * self.numSingleVersion);
                [self.videoBtn addTarget:self action:@selector(playVideoAndAudio:) forControlEvents:UIControlEventTouchUpInside];
                [videoView addSubview:self.videoBtn];
                [self.videoBtn setImage:[UIImage imageNamed:@"play-movie@2x.png"] forState:UIControlStateNormal];
                
                UILabel *videoLable = [[UILabel alloc] initWithFrame:CGRectMake(35 * self.numSingleVersion, self.allheight + 5 * self.numSingleVersion, width - 35 * self.numSingleVersion, 22 * self.numSingleVersion)];
                
                //videoLable.text = [self compenstate:self.notesModel.note_files[@"video"]];
                videoLable.text = imageAndVoiceAndVideoArr[3][0];
                videoLable.font = [UIFont systemFontOfSize:12 * self.numSingleVersion];
                [videoView addSubview:videoLable];
                [videoLable sizeToFit];
                videoLable.textColor = [UIColor lightGrayColor];
                videoLable.center = CGPointMake((15 + 22 + 15) * self.numSingleVersion + videoLable.frame.size.width / 2, 17 * self.numSingleVersion);
                
                self.allheight += 34 * self.numSingleVersion;
            }
        }
    }
}
#pragma mark 音频，视频播放
-(void)playVideoAndAudio:(UIButton *)videoBtn{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
