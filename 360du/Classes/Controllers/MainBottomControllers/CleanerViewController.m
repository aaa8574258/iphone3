//
//  CleanerViewController.m
//  360du
//
//  Created by 利美 on 16/4/21.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "CleanerViewController.h"
#import "CleanerPublishViewController.h"
#import "ViewController.h"
#import "JSDropDownMenu.h"
#import "ChooseViewController.h"
#import "VersionTranlate.h"

@interface CleanerViewController ()<JSDropDownMenuDataSource,JSDropDownMenuDelegate>{
    
    NSMutableArray *_data1;
    NSMutableArray *_data2;
    NSMutableArray *_data3;
    
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;
}
@property (weak, nonatomic) IBOutlet UIView *sView;

@property (weak, nonatomic) IBOutlet UIView *dropDownView;
@property (weak, nonatomic) IBOutlet UITableView *informationTabelView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation CleanerViewController
//-(void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBarHidden = YES;
//
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBarHidden = YES;
    [self makeNv];
    [self DorpDownMenu];
}

-(void)DorpDownMenu{
    NSArray *food = @[@"全部美食", @"火锅", @"川菜", @"西餐", @"自助餐"];
    NSArray *travel = @[@"全部旅游", @"周边游", @"景点门票", @"国内游", @"境外游"];
    
    _data1 = [NSMutableArray arrayWithObjects:@{@"title":@"美食", @"data":food}, @{@"title":@"旅游", @"data":travel}, nil];
    _data2 = [NSMutableArray arrayWithObjects:@"智能排序", @"离我最近", @"评价最高", @"最新发布", @"人气最高", @"价格最低", @"价格最高", nil];
    _data3 = [NSMutableArray arrayWithObjects:@"不限人数", @"单人餐", @"双人餐", @"3~4人餐", nil];
    
    JSDropDownMenu *menu = [[JSDropDownMenu alloc] initWithOrigin2:CGPointMake(0,64) andHeight:self.dropDownView.frame.size.height andWidth:self.dropDownView.frame.size.width];
//    JSDropDownMenu *menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0,64) andHeight:40];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    
//    [self.view addSubview:menu];
    [self.view addSubview:menu];
}

- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 3;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    if (column==2) {
        
        return YES;
    }
    
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    if (column==0) {
        return YES;
    }
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    if (column==0) {
        return 0.3;
    }
    
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==0) {
        
        return _currentData1Index;
        
    }
    if (column==1) {
        
        return _currentData2Index;
    }
    
    return 0;
}
//制作下拉tableView
- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column==0) {
        if (leftOrRight==0) {
            
            return _data1.count;
        } else{
            
            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] count];
        }
    } else if (column==1){
        
        return _data2.count;
        
    } else if (column==2){
        
        return _data3.count;
    }
    
    return 0;
}
//显示数据
- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0: return [[_data1[0] objectForKey:@"data"] objectAtIndex:0];
            break;
        case 1: return _data2[0];
            break;
        case 2: return _data3[0];
            break;
        default:
            return nil;
            break;
    }
}
//点击后显示
- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column==0) {
        if (indexPath.leftOrRight==0) {
            NSDictionary *menuDic = [_data1 objectAtIndex:indexPath.row];
            return [menuDic objectForKey:@"title"];
        } else{
            NSInteger leftRow = indexPath.leftRow;
            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
        }
    } else if (indexPath.column==1) {
        
        return _data2[indexPath.row];
        
    } else {
        
        return _data3[indexPath.row];
    }
}
//点击
- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        
        if(indexPath.leftOrRight==0){
            
            _currentData1Index = indexPath.row;
            
            return;
        }
        
    } else if(indexPath.column == 1){
        
        _currentData2Index = indexPath.row;
        
    } else{
        
        _currentData3Index = indexPath.row;
    }
}



-(void)makeNv{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"landi.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 40);
    [leftBtn setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 60, 40);
    [rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(publishButton) forControlEvents:UIControlEventTouchUpInside];
    //    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *rightSecondItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightSecondItem;
    self.searchTextField.placeholder = @"请输入保洁信息";

}


-(void)setBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)publishButton{
//    CleanerPublishViewController *CPVC = [[CleanerPublishViewController alloc]init];
//    [self.navigationController showViewController:CPVC sender:nil];
    UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
    
    CleanerPublishViewController *CPVC = [cleanerSB instantiateViewControllerWithIdentifier:@"cleanerPublish"];
    
    [self.navigationController showViewController:CPVC sender:nil];
}

- (IBAction)chooseButton:(UIButton *)sender {
    UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
    
    ChooseViewController *CPVC = [cleanerSB instantiateViewControllerWithIdentifier:@"cleanerChoose"];
    
    [self.navigationController showViewController:CPVC sender:nil];
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
