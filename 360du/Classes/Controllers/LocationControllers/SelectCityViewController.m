//
//  SelectCityViewController.m
//  360du
//
//  Created by linghang on 15-4-18.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "SelectCityViewController.h"
#import "SelectCityModel.h"
#import "AlphabetSort.h"
#import "StoreageMessage.h"
#import "LocationCommunityViewController.h"
#define CHANGECITYCELL @"changeCityCell"
#define CHANGESEARCHCITYCELL @"searchCityCell"
@interface SelectCityViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *tempAlapter;
@property(nonatomic,strong)NSMutableArray *alapterArr;
@property(nonatomic,assign)CGFloat allHieght;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UITableView *searchTableView;
@property(nonatomic,strong)NSArray *searchArr;
@end

@implementation SelectCityViewController
-(id)init{
    self = [super init];
    if (self) {
        [self makeInit];
        [self loadData];
        [self makeNav];
        [self makeUI];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Do any additional setup after loading the view.
}
-(void)makeInit{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.tempAlapter = [NSMutableArray arrayWithCapacity:0];
    self.alapterArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 'A'; i <= 'Z' ; i++) {
        [self.alapterArr addObject:[NSString stringWithFormat:@"%c",i]];
    }
    self.tempAlapter = [self.alapterArr mutableCopy];
}
-(void)loadData{
    AFNetworkTwoPackaging *netWork = [[AFNetworkTwoPackaging alloc] init];
    [netWork getUrl:GAINCITY andFinishBlock:^(id getResult) {
        NSMutableArray *tempCom = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *temp in getResult) {
            SelectCityModel *model = [[SelectCityModel alloc] initWithDictionary:temp];
            [tempCom addObject:model];
        }
        
        self.dataArr =  [[AlphabetSort returnCitySortArr:tempCom] mutableCopy];
        
        
        
        for (NSInteger i = 0; i < self.dataArr.count; i++) {
            if ([self.dataArr[i] count] == 0) {
                [self.dataArr removeObjectAtIndex:i];
                [self.tempAlapter removeObjectAtIndex:i];
                i--;
            }
        }
        [self.tableView reloadData];
    }];
}
-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    //[UIImage imageNamed:@"alert_error_icon"]
    [self setBackImageStateName:@"alert_error_icon.png" AndHighlightedName:@""];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"更换城市";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
}
-(void)makeUI{
    [self makeTextfield];
    [self makeTableView];
}
-(void)makeTextfield{
    CGFloat height = [VersionTranlate returnImageHeightImgname:@"searchkuang.png" andWidth:WIDTH_CONTROLLER - 30 * self.numSingleVesion];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 10 * self.numSingleVesion, WIDTH_CONTROLLER, height)];
    [self.view addSubview:view];
    view.tag = 10000;
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(15 * self.numSingleVesion, 0, WIDTH_CONTROLLER - 30 * self.numSingleVesion, height)];
    textView.layer.cornerRadius = height / 2;
    [view addSubview:textView];
    textView.layer.borderColor = [SMSColor(191, 191, 191) CGColor];
    textView.layer.borderWidth = 1 * self.numSingleVesion;
    UIImageView *textImg = [[UIImageView alloc] initWithFrame:CGRectMake(textView.frame.size.width - 15 * self.numSingleVesion - 25 * self.numSingleVesion,(height - 25 * self.numSingleVesion ) / 2 , 25 * self.numSingleVesion, 25 * self.numSingleVesion)];
    textImg.image = [UIImage imageNamed:@"xiaoqu_search.png"];
    textImg.userInteractionEnabled = YES;
    [textView addSubview:textImg];
    
    //    //输入框
    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(25 * self.numSingleVesion, 0, textView.frame.size.width - 25 * self.numSingleVesion, textView.frame.size.height)];
    text.placeholder = @"请输入城市名称";
    text.clearButtonMode = UITextFieldViewModeAlways;
    text.borderStyle = UITextBorderStyleNone;
    text.delegate = self;
    text.returnKeyType = UIReturnKeyGoogle;
    [textView addSubview:text];
    //目前高度
    self.allHieght = 64  + 10 * self.numSingleVesion + height + 5 * self.numSingleVesion;
//    UIImageView *textImg = [[UIImageView alloc] initWithFrame:CGRectMake(15 * self.numSingleVesion, 64 + 10 * self.numSingleVesion, WIDTH_CONTROLLER - 30 * self.numSingleVesion, height)];
//    textImg.image = [UIImage imageNamed:@"searchkuang.png"];
//    textImg.userInteractionEnabled = YES;
//    [self.view addSubview:textImg];
//    
//    //    //输入框
//    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(25 * self.numSingleVesion, 0, textImg.frame.size.width - 25 * self.numSingleVesion, textImg.frame.size.height)];
//    text.placeholder = @"请输入城市名称";
//    text.clearButtonMode = UITextFieldViewModeAlways;
//    text.borderStyle = UITextBorderStyleNone;
//    text.delegate = self;
//    text.returnKeyType = UIReturnKeyGoogle;
//    [textImg addSubview:text];
//    
//    //目前高度
//    self.allHieght = 64  + 10 + height + 5 * self.numSingleVesion;
}
-(void)makeTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.allHieght, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - self.allHieght) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CHANGECITYCELL];
    self.tableView = tableView;
    
    
    UITableView *searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.allHieght, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - self.allHieght) style:UITableViewStylePlain];
    searchTableView.showsVerticalScrollIndicator = NO;
    searchTableView.dataSource = self;
    searchTableView.delegate = self;
    [self.view addSubview:searchTableView];
    [searchTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CHANGESEARCHCITYCELL];
    searchTableView.hidden = YES;
    self.searchTableView = searchTableView;
}
#pragma mark tableview的协议代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
#warning message dataArr
    NSLog(@"%@",self.dataArr);
    if (tableView == self.tableView) {
        if (section == 0) {
            return 1;
        }
        return [self.dataArr[section - 1] count];
    }else{
        return self.searchArr.count;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tableView) {
        return self.dataArr.count + 1;
    }
    else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.tableView == tableView) {
        if (section == 1) {
            return 80 * self.numSingleVesion;
        }
        return  40 * self.numSingleVesion;
    }
    return 0;
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        
        if (section == 1) {
            view.frame = CGRectMake(0, 0, WIDTH_CONTROLLER, 80 * self.numSingleVesion);
        }else{
            view.frame = CGRectMake(0, 0, WIDTH_CONTROLLER, 40 * self.numSingleVesion);
            
        }
        view.backgroundColor = SMSColor(246, 246, 246);
        
        NSArray *imgArr = @[@"drawable_to_place",@"city_selcity.png"];
        NSArray *titleArr = @[@"定位城市",@"热门城市"];
        if (section < 2) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 10 * self.numSingleVesion, 20 * self.numSingleVesion, 20 * self.numSingleVesion)];
            imgView.image = [UIImage imageNamed:imgArr[section]];
            [view addSubview:imgView];
            
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
            lable.font = [UIFont systemFontOfSize:24];
            lable.textColor = SMSColor(51, 51, 51);
            lable.text = titleArr[section];

            [lable sizeToFit];
            lable.center = CGPointMake(40 * self.numSingleVesion + lable.frame.size.width / 2, 20 * self.numSingleVesion);
            [view addSubview:lable];
            if (section == 1) {
                UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 39.5 * self.numSingleVesion, WIDTH_CONTROLLER, 1 * self.numSingleVesion)];
                line.backgroundColor = SMSColor(211, 211, 211);
                [view addSubview:line];
                
                UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectZero];
                lable1.font = [UIFont systemFontOfSize:24];
                lable1.textColor = SMSColor(51, 51, 51);
                lable1.text = self.tempAlapter[section - 1];

                [lable1 sizeToFit];
                lable1.center = CGPointMake(20 * self.numSingleVesion + lable1.frame.size.width / 2, 60 * self.numSingleVesion);
                //  lable.text = self.tempAlapter[section - 1];
                [view addSubview:lable1];
            }
            
        }else{
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
            lable.font = [UIFont systemFontOfSize:24];
            lable.textColor = SMSColor(51, 51, 51);
            lable.text = self.tempAlapter[section - 1];

            [lable sizeToFit];
            lable.center = CGPointMake(20 * self.numSingleVesion + lable.frame.size.width / 2, 20 * self.numSingleVesion);
            [view addSubview:lable];
            
        }
        if (section == 1) {
            view.frame = CGRectMake(0, 0, WIDTH_CONTROLLER, 80 * self.numSingleVesion);
        }else{
            view.frame = CGRectMake(0, 0, WIDTH_CONTROLLER, 40 * self.numSingleVesion);
            
        }
        return view;
        
    }
    return nil;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectCityModel *model = nil;
    UITableViewCell *cell = nil;
    if (tableView == self.tableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:CHANGECITYCELL forIndexPath:indexPath];
        if (indexPath.section == 0) {
            
        }else{
            model = self.dataArr[indexPath.section - 1][indexPath.row];
        }
        for(UIView *view in [tableView subviews]) {
            if([view respondsToSelector:@selector(setIndexColor:)]) {
                [view performSelector:@selector(setIndexColor:) withObject:[UIColor blackColor]];
            }
        }
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:CHANGESEARCHCITYCELL forIndexPath:indexPath];
        
        model = self.searchArr[indexPath.row];
    }
    if (indexPath.section == 0 && self.tableView == tableView) {
        cell.textLabel.text = [StoreageMessage getCity];
    }
    else{
        cell.textLabel.text = model.name;
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectCityModel *model = nil;
    if (tableView == self.tableView) {
        
        if (indexPath.section == 0) {
            
        }else{
            model = self.dataArr[indexPath.section - 1][indexPath.row];
        }
    }
    else{
        
        model = self.searchArr[indexPath.row];
    }
    if (indexPath.section == 0 && self.tableView == tableView) {
       
    }
    else{
        if ([self.target isKindOfClass:[LocationCommunityViewController class]]) {
            [self.target returnCityName:model];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark 数组索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
    if (self.tableView == tableView) {
        for (int i = 'A'; i <= 'Z' ; i++) {
            [temp addObject:[NSString stringWithFormat:@"%c",i]];
        }
        return temp;
    }
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    if (self.tableView == tableView) {
        return index;
    }
    return 0;
}

#pragma mark textField的代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if(textField.text.length == 0){
        self.tableView.hidden = NO;
        self.searchTableView.hidden = YES;
        [self.tableView reloadData];
        return YES;
    }
    NSMutableArray *searchArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        for (NSInteger j = 0; j < [self.dataArr[i] count]; j++) {
            SelectCityModel *model = self.dataArr[i][j];
            if (model.name.length >= textField.text.length && model.pyname.length >= textField.text.length) {
                if ([[model.name substringToIndex:textField.text.length] containsString:textField.text] || [[model.pyname substringToIndex:textField.text.length]containsString:[textField.text uppercaseString]] || [[model.pyname substringToIndex:textField.text.length]containsString:[textField.text lowercaseString]]) {
                    [searchArr addObject:model];
                }
            }
            
        }
        
        
        
    }
    self.searchArr = searchArr;
    self.tableView.hidden = YES;
    self.searchTableView.hidden = NO;
    [self.searchTableView reloadData];
    
    
    return YES;
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
