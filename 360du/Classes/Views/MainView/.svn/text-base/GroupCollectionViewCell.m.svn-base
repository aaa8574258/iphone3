//
//  GroupCollectionViewCell.m
//  360du
//
//  Created by 利美 on 16/9/13.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "GroupCollectionViewCell.h"
#import "VersionTranlate.h"
@implementation GroupCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"%f",self.window.bounds.size.width);
        self.numSingleVesion = [VersionTranlate returnVersionRateAnyIphone:self.window.bounds.size.width];

        [self setupView];
    }
    return self;
}

//初始化视图
-(void)setupView{

    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width , 213 * self.numSingleVesion)];
//    self.imageView.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.imageView];
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(10 * self.numSingleVesion, 220 * self.numSingleVesion, self.contentView.frame.size.width -20 * self.numSingleVesion , 30 *self.numSingleVesion)];
    self.label.numberOfLines = 1;
    self.label.font = [UIFont systemFontOfSize:15* self.numSingleVesion];
//        self.label.center = self.contentView.center;
    //    self.label = [[UILabel alloc]initWithFrame:self.contentView.frame];
//    self.label.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.label];
    self.money1Lab = [[UILabel alloc]initWithFrame:CGRectMake(10* self.numSingleVesion, self.contentView.frame.size.height - 30* self.numSingleVesion, 66* self.numSingleVesion , 30* self.numSingleVesion)];
    //        self.label.center = self.contentView.center;
    //    self.label = [[UILabel alloc]initWithFrame:self.contentView.frame];
//    self.money1Lab.backgroundColor = [UIColor yellowColor];
    self.money1Lab.font = [UIFont systemFontOfSize:15];
    self.money1Lab.textColor = [UIColor blackColor];
    [self.money1Lab sizeToFit];
    [self.contentView addSubview:self.money1Lab];
    self.money2Lab = [[UILabel alloc]initWithFrame:CGRectMake(70 * self.numSingleVesion, self.contentView.frame.size.height - 26* self.numSingleVesion, 66 * self.numSingleVesion, 30* self.numSingleVesion)];
    //        self.label.center = self.contentView.center;
    //    self.label = [[UILabel alloc]initWithFrame:self.contentView.frame];
//    self.money2Lab.backgroundColor = [UIColor yellowColor];
    self.money2Lab.font = [UIFont systemFontOfSize:10* self.numSingleVesion];
    self.money2Lab.textColor =[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [self.contentView addSubview:self.money2Lab];
    
    self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width - 30 , self.contentView.frame.size.height - 30* self.numSingleVesion, 20 * self.numSingleVesion, 20* self.numSingleVesion)];
    [self.imageView1 setImage:[UIImage imageNamed:@"4040.png"]];
    [self.contentView addSubview:self.imageView1];

}

//当这个cell的bounds发生改变的时候 会自动调用这个方法
//-(void)layoutSubviews{
//    //在这里对cell的frame重新进行设置
//    //1 拿到image的frame
//    CGRect frame1 = self.imageView.frame;
//    //2 拿到cell的frame
//    CGRect frame2 = self.frame;
//    //将cell的新的宽和高赋值到ImageView的frame上
//    frame1.size.width = frame2.size.width;
//    frame1.size.height = frame2.size.height;
//    //3 将修改后的frame设置到imageview上
//    self.imageView.frame = frame1;
//}

@end
