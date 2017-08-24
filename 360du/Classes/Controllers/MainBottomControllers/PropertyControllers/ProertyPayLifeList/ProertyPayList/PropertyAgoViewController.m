//
//  PropertyAgoViewController.m
//  360du
//
//  Created by 利美 on 16/6/12.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "PropertyAgoViewController.h"
#import "AgoTableViewCell.h"
#import "StoreageMessage.h"
#import "NSString+URLEncoding.h"
#import "DetialInfoPropertyModel.h"
#import "ProertyMiddlePayAddressListViewController.h"
@interface PropertyAgoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *data;
@property (nonatomic ,strong) NSMutableArray *addressData;
@property (nonatomic,strong) UIView *f;
@property (nonatomic ,strong) UILabel *addressLab;
@property (nonatomic ,copy) NSString *hmid;
@property (nonatomic,strong) UIButton *button1;
@property (nonatomic,strong) UIButton *button2;
@end

@implementation PropertyAgoViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self someInfo];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    
    
    
    
    // Do any additional setup after loading the view.
}

-(void)someInfo{
//    NSLog(@"%f",self.numSingleVesion);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80*self.numSingleVesion, self.view.frame.size.width, self.view.frame.size.height - 80*self.numSingleVesion)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.tableView];
    [self loadData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"count::%lu",(unsigned long)self.data.count);
    return self.data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 396 *self.numSingleVesion;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AgoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_1222"];
    if (!cell) {
        cell = [[AgoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell_1222"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DetialInfoPropertyModel *model = self.data[indexPath.row];
    [cell haveModel:model];
//    cell.textLabel.text = @"1212";
    
    return cell;
}

- (void)loadData{
    [self makeHUd];
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:PROERTYMIDLLEPAYADDRESSLIST,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        if (![getResult[@"code"] isEqual:@"000000"]) {
            return ;
        }
        self.addressData = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = 0; i < [getResult[@"datas"] count]; i++) {
            ProertyMiddlePayAddressListModel *model = [[ProertyMiddlePayAddressListModel alloc] initWithDictionary:getResult[@"datas"][i]];
//            NSLog(@"%@",model.hmid);
            [self.addressData addObject:model];
            if ([model.isDefault isEqual:@"Y"]) {
                NSMutableString *tempStr = [NSMutableString stringWithCapacity:0];
                NSArray *valueArr = @[model.UnitNo,model.builde,model.houseNo];
                NSArray *keyArr = @[@"栋",@"单元",@"号"];
                for (NSInteger i = 0; i < keyArr.count; i++) {
                    [tempStr appendString:[NSString stringWithFormat:@"%ld",[valueArr[i] integerValue]]];
                    [tempStr appendString:keyArr[i]];
                }
                self.addressLab = [[UILabel alloc] init];
                self.hmid = model.hmid;
                self.addressLab.font = [UIFont systemFontOfSize:15*self.numSingleVesion];
                self.addressLab.text = [NSString stringWithFormat:@"%@  %@ %@\n%@  %@",[model.nickName URLDecodedString],model.phone,model.wyName,model.xqName,tempStr];
            }

            _button1 = [UIButton buttonWithType:UIButtonTypeSystem];
            _button1.frame = CGRectMake(0, 64, self.view.frame.size.width/2, 40*self.numSingleVesion);
            _button1.layer.borderWidth = 2;
            _button1.layer.borderColor = [[UIColor lightGrayColor] CGColor];

            [_button1 setTitle:@"已交费用" forState:UIControlStateNormal];
            [_button1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

            _button1.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:_button1];
            _button2 = [UIButton buttonWithType:UIButtonTypeSystem];
            _button2.frame = CGRectMake(self.view.frame.size.width/2, 64, self.view.frame.size.width/2, 40*self.numSingleVesion);
            _button2.layer.borderWidth = 2;
            _button2.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            [_button2 setTitle:@"欠费记录" forState:UIControlStateNormal];
            [_button2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _button2.backgroundColor = [UIColor whiteColor];

            [self.view addSubview:_button2];
        }
        
        self.f = [[UIView alloc] initWithFrame:CGRectMake(0*self.numSingleVesion, 64+40 * self.numSingleVesion, WIDTH_CONTROLLER, 45 * self.numSingleVesion)];
        [self.view addSubview:self.f];
        self.addressLab.frame = CGRectMake(10*self.numSingleVesion, 64+40 * self.numSingleVesion, WIDTH_CONTROLLER-50*self.numSingleVesion , 45 * self.numSingleVesion);
        self.addressLab.numberOfLines = 2;
    
        UIImageView *arroeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER - 100 * self.numSingleVesion - 18 * self.numSingleVesion, (60 * self.numSingleVesion - 20 * self.numSingleVesion) / 2, 18 * self.numSingleVesion, 20 * self.numSingleVesion)];
        arroeImgView.image = [UIImage imageNamed:@"下一步.png"];
        arroeImgView.center = CGPointMake(WIDTH_CONTROLLER - 20 * self.numSingleVesion - 9 * self.numSingleVesion, 24 * self.numSingleVesion);
//        self.addressLab.backgroundColor = [UIColor whiteColor];
        self.f.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:self.addressLab];
        [self.f addSubview:arroeImgView];
        UIButton *buttom = [UIButton buttonWithType:UIButtonTypeCustom];
        buttom.frame = _f.bounds;
        [_f addSubview:buttom];
        [buttom setTitle:@"" forState:UIControlStateNormal];
        [buttom addTarget:self action:@selector(nextBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [self reloadNextDataWithHmid:self.hmid AndNumber:@"1"];

    }];
}

-(void)nextBtnDown:(UIButton *)sender{
        ProertyMiddlePayAddressListViewController *middlePayAddressList = [[ProertyMiddlePayAddressListViewController alloc] initWithAddressListArr:self.addressData];
        middlePayAddressList.target = self;
        [self.navigationController pushViewController:middlePayAddressList animated:YES];
}


-(void)btnAction:(UIButton *)sender{
    NSString *num = @"1";
    if ([sender.titleLabel.text isEqualToString:@"已交费用"]) {
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        num = @"1";
    }else{
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        num = @"2";
    }
//    NSLog(@"%@",self.hmid);
    [self reloadNextDataWithHmid:self.hmid AndNumber:num];
    
}


-(void)reloadNextDataWithHmid:(NSString *)hmid AndNumber:(NSString *)num {
    self.data = [NSMutableArray arrayWithCapacity:0];

    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    NSString *url = [NSString stringWithFormat:PROERTYPAYQUERYHISTORY,hmid,num];
//    NSLog(@"%@",url);
    [twoPack getUrl:url andFinishBlock:^(id getResult) {
//        NSLog(@"%@",getResult[@"datas"]);
        for (NSDictionary *dic in getResult[@"datas"]) {
            DetialInfoPropertyModel *model = [[DetialInfoPropertyModel alloc] initWithDictionary:dic];
//            NSLog(@"%@",model.userName);
            [self.data addObject:model];
//            NSLog(@"%lu",(unsigned long)self.data.count);
        }
        [self.tableView reloadData];
    }];
}



- (void)gainDefaultAddress:(ProertyMiddlePayAddressListModel *)model{
    self.model = model;
    NSMutableString *tempStr = [NSMutableString stringWithCapacity:0];
    NSArray *valueArr = @[model.UnitNo,model.builde,model.houseNo];
    NSArray *keyArr = @[@"栋",@"单元",@"号"];
    for (NSInteger i = 0; i < keyArr.count; i++) {
        [tempStr appendString:[NSString stringWithFormat:@"%ld",[valueArr[i] integerValue]]];
        [tempStr appendString:keyArr[i]];
    }
    self.addressLab.text = [NSString stringWithFormat:@"%@  %@ %@\n%@  %@",[model.nickName URLDecodedString],model.phone,model.wyName,model.xqName,tempStr];
    self.hmid = model.hmid;
    [self reloadNextDataWithHmid:model.hmid AndNumber:@"1"];
    
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
