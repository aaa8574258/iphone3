//
//  CommonFoodViewController.m
//  360du
//
//  Created by linghang on 15-4-18.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "CommonFoodViewController.h"
#import "CommomFoodModel.h"
@interface CommonFoodViewController ()
@property(nonatomic,strong)UIImageView *leftImg;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UIImageView *logoImg;
@property(nonatomic,strong)UILabel *priceUsualLable;
@property(nonatomic,strong)UILabel *priceOtherLable;
@end

@implementation CommonFoodViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    self.leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(5 * self.numSingleVesion, 5 * self.numSingleVesion, 40 * self.numSingleVesion, 40 * self.numSingleVesion)];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)refreshUI:(CommomFoodModel *)model{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
