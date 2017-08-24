//
//  ProertyWaterReaderViewController.m
//  360du
//
//  Created by linghang on 16/3/29.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ProertyWaterReaderViewController.h"
#import "WJDropdownMenu.h"
#import "StoreageMessage.h"
#import "waterModel.h"
#import "WaterTableViewCell.h"
#import "UIView+Toast.h"

@interface ProertyWaterReaderViewController ()<WJMenuDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,weak)WJDropdownMenu *menu;
@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,strong) NSArray *arr1;
@property (nonatomic,strong) NSArray *arr2;
@property (nonatomic,strong) NSArray *arr3;
@property (nonatomic ,strong) NSArray *arr4;
@property (nonatomic ,strong) NSArray *allHouseIdArr;
@property (nonatomic ,strong) NSArray *houseArr;
@property (nonatomic ,assign) NSInteger i;

@property (nonatomic,weak) UITableView *tableView;

@property (nonatomic ,copy) NSString *lastHouse;
@property (nonatomic ,copy) NSString *lastId;

@property (nonatomic ,copy) NSString *s;
@property (nonatomic ,copy) NSString *d;
@property (nonatomic ,copy) NSString *q;


@property (nonatomic ,copy) NSString *firstStr;
@property (nonatomic ,copy) NSString *sectionStr;
@property (nonatomic ,assign) NSInteger supIndex;
@end

@implementation ProertyWaterReaderViewController

//-(void)viewWillAppear:(BOOL)animated{
////    [self setNavBarImage:@"0.png"];
////    self.view.backgroundColor = [UIColor whiteColor];
////    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
////    view1.backgroundColor = [UIColor whiteColor];
////    [self.view addSubview:view1];
////    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//    [self makeNav];
//}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self makeNav];
    }
    return self;
}

-(void)makeNav{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"抄表员";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor blackColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//        //[self setBackgroud:@"lantiao x.png"];
//    [self setBackImageStateName:@"fanhuijian2222.png" AndHighlightedName:@""];
//    self.title = @"抄表员";
    [self makeTableView];

//    self.automaticallyAdjustsScrollViewInsets = NO;

    // Do any additional setup after loading the view.
//    [self makeOtherWithCount:2];

    
    

#warning 此处有两种方法导入数据 1.第一种是直接导入菜单一级子菜单二级子菜单三级子菜单的所有数据  2.第二种是根据每次点击index的请求数据后返回下一菜单的数据时导入数据一级一级联动的网络请求数据所有的方法都是以net开头
    // 第一种方法一次性导入所有菜单数据
    
    
    // 第二中方法net网络请求一级一级导入数据，先在此导入菜单数据，然后分别再后面的net开头的代理方法中导入一级一级子菜单的数据
//    [menu netCreateMenuTitleArray:threeMenuTitleArray];
    
    // 设置rightItem点击收缩menu
//    [self createRightNav];
    [self loadData];
    [self loadListData];
}

-(void) createMenuWithI:(NSInteger )i{
    
    if (self.firstStr.length == 0) {
        self.firstStr = @"选择小区和房间号";
    }
    if (self.sectionStr.length == 0) {
        self.sectionStr = @"选择房间号";
    }
    
    NSArray *arr = @[self.firstStr,self.sectionStr];
    WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    menu.backgroundColor = [UIColor whiteColor];
    menu.delegate = self;         //  设置代理
    [self.view addSubview:menu];
    
    // 设置属性(可不设置)
    menu.caverAnimationTime = 0.2;             //  增加了遮盖层动画时间设置   不设置默认是  0.15
    menu.menuTitleFont = 12;                   //  设置menuTitle字体大小    不设置默认是  11
    menu.tableTitleFont = 11;                  //  设置tableTitle字体大小   不设置默认是  10
    menu.cellHeight = 38;                      //  设置tableViewcell高度   不设置默认是  40
    menu.menuArrowStyle = menuArrowStyleSolid; //  旋转箭头的样式(空心箭头 or 实心箭头)
    menu.tableViewMaxHeight = 200;             //  tableView的最大高度(超过此高度就可以滑动显示)
    menu.menuButtonTag = 100;                  //  menu定义了一个tag值如果与本页面的其他button的值有冲突重合可以自定义设置
    menu.CarverViewColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];//设置遮罩层颜色
    self.menu = menu;
    NSLog(@"%ld",(long)i);
    NSArray *firstMenu = [NSArray arrayWithObject:self.arr2[i]];
    NSArray *secondMenu = [NSArray arrayWithObjects:self.arr1,self.arr3,self.arr2, nil];
    NSLog(@"12121212121%@---%@---%@",self.arr1,self.arr3,self.arr2);
    [self.menu createTwoMenuTitleArray:arr FirstArr:secondMenu SecondArr:firstMenu];
//    [self.menu createThreeMenuTitleArray:arr FirstArr:secondMenu SecondArr:threeMenu2 threeArr:firstMenu];
    
}





-(void) loadListData{
    [self makeHUd];
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:QUERYBUIDNOBYMEMBERID,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];

        NSMutableArray *marr1 = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *marr23 = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *marr24 = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *marr25 = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *allmarr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in getResult[@"datas"]) {
            [marr1 addObject:dic[@"buidNo"]];
            self.arr1 = marr1.mutableCopy;

            AFNetworkTwoPackaging *twoPacking1 = [[AFNetworkTwoPackaging alloc] init];

            [twoPacking1 getUrl:[NSString stringWithFormat:QUERYUNIT,[StoreageMessage getMessage][2],dic[@"buidNo"]] andFinishBlock:^(id getResult) {
                [self hudWasHidden:self.hudProgress];

                NSMutableArray *marr4 = [NSMutableArray arrayWithCapacity:0];
                self.houseArr = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *dic  in getResult[@"datas"]) {
                    NSMutableArray *marr2 = [NSMutableArray arrayWithCapacity:0];
                    NSMutableArray *marr3 = [NSMutableArray arrayWithCapacity:0];
                    [marr4 addObject:dic[@"unitNo"]];
                    for (NSDictionary *dic1 in dic[@"houseNos"]) {
                        [marr2 addObject:dic1[@"houseNo"]];
                        [marr3 addObject:dic1[@"xhid"]];
                    }
                    [marr23 addObject:marr2];
                    self.arr2 = marr23.mutableCopy;
                    [marr25 addObject:marr3];
                    self.houseArr = marr25.mutableCopy;
                }
                [marr24 addObject:marr4];
                self.arr3 = marr24.mutableCopy;
                
                if (self.arr3.count == self.arr1.count) {
                    [self createMenuWithI:0];
                }
            }];
        }
    }];
}



-(void) makeTableView{
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64 + 40 *self.numSingleVesion)];
//    view1.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:view1];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 40 *self.numSingleVesion, self.view.frame.size.width, self.view.frame.size.height - 64 - 40 * self.numSingleVesion)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)self.data.count);
    return self.data.count;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150 * self.numSingleVesion;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WaterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"waterCell"];
    cell = [[WaterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"waterCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  
    waterModel *model = self.data[indexPath.row];
    cell.label1.text = model.cbtypeName;
    cell.lab3.text = model.unit;
    cell.txF1.placeholder = [NSString stringWithFormat:@"请在此处输入%@的%@数",model.cbtypeName,model.unit];
    cell.txF1.tag = 10000 + indexPath.row;
    [cell.txF1 addTarget:self action:@selector(txtF:) forControlEvents:UIControlEventEditingChanged];
    [cell.btn1 addTarget:self action:@selector(OKAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn1.tag = 10086 + indexPath.row;
    cell.txF1.delegate = self;
    return cell;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (void)menuCellDidSelected:(NSInteger)MenuTitleIndex firstIndex:(NSInteger)firstIndex secondIndex:(NSInteger)secondIndex thirdIndex:(NSInteger)thirdIndex{
    NSLog(@"%ld",self.supIndex);
    NSLog(@"菜单数:%ld      一级菜单数:%ld      二级子菜单数:%ld  三级子菜单:%ld",MenuTitleIndex,firstIndex,secondIndex,thirdIndex);
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0 ; i < self.arr3.count; i++) {
        for (NSInteger j = 0; j < [self.arr3[i] count] ; j++) {
            [arr addObject:self.arr3[i][j]];
        }
    }
    NSInteger a = 0;
    for (NSInteger i = 0; i < self.supIndex; i++) {
        a += [self.arr3[i] count];
    }
    NSLog(@"%ld",a+secondIndex);
    [self.menu removeFromSuperview];
    if (MenuTitleIndex != 0) {
////        [self createMenuWithI:0];
//
//        self.supIndex = 0;
        self.lastId = self.houseArr[self.supIndex][firstIndex];
        self.lastHouse = self.arr2[self.supIndex][firstIndex];
        
        self.firstStr = [NSString stringWithFormat:@"单元号:%@",self.arr1[self.supIndex]];
        self.sectionStr = [NSString stringWithFormat:@"房间号:%@",self.arr2[self.supIndex][firstIndex]];
    }else{
        self.supIndex = a + secondIndex;
        self.lastId = self.houseArr[self.supIndex][thirdIndex];
        self.lastHouse = self.arr2[self.supIndex][thirdIndex];
        
        self.firstStr = [NSString stringWithFormat:@"单元号:%@",self.arr1[self.supIndex]];
        self.sectionStr = [NSString stringWithFormat:@"房间号:%@",self.arr2[self.supIndex][thirdIndex]];
    }
    NSLog(@"%ld",self.supIndex);

    [self createMenuWithI:self.supIndex];
//    NSLog(@"%@----%@",self.arr1[firstIndex],self.arr2[a + secondIndex][thirdIndex]);

};







-(void) loadData{
//    [self makeHUd];

    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    NSLog(@"%@",[StoreageMessage getMessage][2]);
    [twoPacking getUrl:[NSString stringWithFormat:QUERYCBYTABLETYPE,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        NSLog(@"%@",getResult);
        self.data = [NSMutableArray arrayWithCapacity:0];

        for (NSDictionary *dic in getResult[@"datas"]) {

            waterModel *water = [[waterModel alloc] initWithDictionary:dic];
            [self.data addObject:water];
        }
        [self.tableView reloadData];

    }];
    
//    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
//    NSDictionary *dic1 = @{@"cbtype":@"1",@"cbtypeName":@"饮用水",@"ctid":@"1",@"unit":@"吨"};
//    NSDictionary *dic2 = @{@"cbtype":@"2",@"cbtypeName":@"电",@"ctid":@"2",@"unit":@"度"};
//    NSDictionary *dic3 = @{@"cbtype":@"3",@"cbtypeName":@"燃气",@"ctid":@"2",@"unit":@"元"};
//    [arr addObject:dic1];
//    [arr addObject:dic2];
//    [arr addObject:dic3];
//    NSLog(@"%@",arr);
//    for (NSDictionary *dic in arr) {
//        waterModel *water = [[waterModel alloc] initWithDictionary:dic];
//        [self.data addObject:water];
//    }
//    [self.tableView reloadData];

}

-(void) txtF:(UITextField *)center{
    if (center.tag == 10000) {
        self.s = center.text;
        
    }else if (center.tag == 10001) {
        self.d = center.text;
        
    }else if (center.tag == 10002){
        self.q = center.text;
        
    }
}


-(void) OKAction:(UIButton *)center{
    NSLog(@"%ld",center.tag);
    if (self.lastId.length == 0) {
        [self.view makeToast:@"请选择房间号"];
    
    }else{
    
        NSLog(@"%@ -- %@",self.lastId,self.s);
    
    
    if (center.tag == 10086) {
    if (self.s.length == 0 ){
        [self.view makeToast:@"请在输入框中输入内容"];
    }else{
        AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
        [twoPacking getUrl:[NSString stringWithFormat:CHECKCBYVALUE,[StoreageMessage getMessage][2],self.lastId,@"1"] andFinishBlock:^(id getResult) {
            NSLog(@"%@",getResult);
            if ([getResult[@"code"] isEqualToString:@"000000"]) {
                AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
                [twoPacking getUrl:[NSString stringWithFormat:SAVECBYVALUES,[StoreageMessage getMessage][2],self.lastId,@"1",self.s] andFinishBlock:^(id getResult) {
                    NSLog(@"%@",getResult);
                    if ([getResult[@"code"] isEqualToString:@"000000"]) {
                        [self.view makeToast:@"成功"];
                    }
                }];
            }else{
                UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"该房间这个表数值10天内提交过了，是否重复提交"   delegate:self     cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil ];
                alert.delegate = self;
                alert.tag = 1;
                [alert show];
            }
            
        }];
        
        
        
    }
    }else if (center.tag == 10087) {
        if (self.d.length == 0 ){
            [self.view makeToast:@"请在输入框中输入内容"];
        }else{
            AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
            [twoPacking getUrl:[NSString stringWithFormat:CHECKCBYVALUE,[StoreageMessage getMessage][2],self.lastId,@"2"] andFinishBlock:^(id getResult) {
                NSLog(@"%@",getResult);
                if ([getResult[@"code"] isEqualToString:@"000000"]) {
                    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
                    [twoPacking getUrl:[NSString stringWithFormat:SAVECBYVALUES,[StoreageMessage getMessage][2],self.lastId,@"2",self.d] andFinishBlock:^(id getResult) {
                        NSLog(@"%@",getResult);
                        if ([getResult[@"code"] isEqualToString:@"000000"]) {
                            [self.view makeToast:@"成功"];
                        }
                    }];
                }else{
                    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"该房间这个表数值10天内提交过了，是否重复提交"   delegate:self     cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil ];
                    alert.delegate = self;
                    alert.tag = 2;
                    [alert show];
                }
                
            }];

        }
    
    }else if (center.tag == 10088){
        if (self.q.length == 0 ){
            [self.view makeToast:@"请在输入框中输入内容"];
        }else{
            AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
            [twoPacking getUrl:[NSString stringWithFormat:CHECKCBYVALUE,[StoreageMessage getMessage][2],self.lastId,@"3"] andFinishBlock:^(id getResult) {
                NSLog(@"%@",getResult);
                if ([getResult[@"code"] isEqualToString:@"000000"]) {
                    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
                    [twoPacking getUrl:[NSString stringWithFormat:SAVECBYVALUES,[StoreageMessage getMessage][2],self.lastId,@"3",self.q] andFinishBlock:^(id getResult) {
                        NSLog(@"%@",getResult);
                        if ([getResult[@"code"] isEqualToString:@"000000"]) {
                            [self.view makeToast:@"成功"];
                        }
                    }];
                }else{
                    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"该房间这个表数值10天内提交过了，是否重复提交"   delegate:self     cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil ];
                    alert.delegate = self;
                    alert.tag = 3;
                    [alert show];
                }
                
            }];

        }
    
    }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            
        AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
        [twoPacking getUrl:[NSString stringWithFormat:SAVECBYVALUES,[StoreageMessage getMessage][2],self.lastId,@"1",self.s] andFinishBlock:^(id getResult) {
            NSLog(@"%@",getResult);
            if ([getResult[@"code"] isEqualToString:@"000000"]) {
                [self.view makeToast:@"成功"];
            }

        }];
        }

    }else if (alertView.tag == 2){
        if (buttonIndex == 1) {

        AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
        [twoPacking getUrl:[NSString stringWithFormat:SAVECBYVALUES,[StoreageMessage getMessage][2],self.lastId,@"2",self.d] andFinishBlock:^(id getResult) {
            NSLog(@"%@",getResult);
            if ([getResult[@"code"] isEqualToString:@"000000"]) {
                [self.view makeToast:@"成功"];
            }
        }];
        }
    }else if (alertView.tag == 3){
        if (buttonIndex == 1) {

        AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
        [twoPacking getUrl:[NSString stringWithFormat:SAVECBYVALUES,[StoreageMessage getMessage][2],self.lastId,@"3",self.q] andFinishBlock:^(id getResult) {
            NSLog(@"%@",getResult);
            if ([getResult[@"code"] isEqualToString:@"000000"]) {
                [self.view makeToast:@"成功"];
            }
        }];
        }
    }

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
