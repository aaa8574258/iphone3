//
//  PartBuildNextViewController.m
//  360du
//
//  Created by 利美 on 17/7/17.
//  Copyright © 2017年 wangjian. All rights reserved.
//

#import "PartBuildNextViewController.h"
#import "SDCycleScrollView.h"
#import "StoreageMessage.h"
#import "PartyBuildQZTableViewController.h"
#import "UIView+Toast.h"
@interface PartBuildNextViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>
@property (nonatomic ,copy) NSArray *titles;
@property (nonatomic ,copy) NSArray *icons;
@property (nonatomic ,copy) NSArray *images;
@end

@implementation PartBuildNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor = [UIColor whiteColor];
//    [self makeLB];
    [self getInfo];
    


}

-(void) getInfo{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:PARTYBUILDLIST,[StoreageMessage getCommuntityId],@"1"] andFinishBlock:^(id getResult) {
        NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr3 = [NSMutableArray arrayWithCapacity:0];
        NSLog(@"%@",[NSString stringWithFormat:PARTYBUILDLIST,[StoreageMessage getCommuntityId],@"1"]);
        for (NSDictionary *dic in getResult[@"datas"]) {
            [arr1 addObject:dic[@"Name"]];
            [arr2 addObject:dic[@"ID"]];
            [arr3 addObject:dic[@"imgUrl"]];
        }
        
        if ([getResult[@"datas"] count]==0) {
            [self.view makeToast:@"暂无内容"];

        }else{
        self.titles = arr1.mutableCopy;
        self.icons = arr2.mutableCopy;
        self.images = arr3.mutableCopy;
        [self makeCollection];
        }
    }];

}








-(void)makeLB{

    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 20, WIDTH_CONTENTVIEW, 220 *self.numSingleVesion) imageURLStringsGroup:nil];
//    cycleScrollView2.backgroundColor = [UIColor redColor];
    [self.view addSubview:cycleScrollView2];
    cycleScrollView2.delegate = self;
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    //    cycleScrollView2.delegate = self;
    cycleScrollView2.dotColor = [UIColor clearColor];
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    //       [self.LBSuperView addSubview:cycleScrollView2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //       cycleScrollView2.imageURLStringsGroup = timeArr[@"picturePath"];
        NSArray *arr1 = @[@"http://img.bimg.126.net/photo/bsn4EnuIKJjx862_Omgicg==/1762877779140534408.jpg",@"http://pic.58pic.com/58pic/17/60/97/556d5b64628d4_1024.jpg",@"http://pic.58pic.com/58pic/12/75/56/158PICI58PICYab.jpg",@"http://img2.imgtn.bdimg.com/it/u=499454004,762140138&fm=200&gp=0.jpg"];
        NSArray *arr2 = @[@"五星红旗",@"红旗飘扬",@"红旗飞扬",@"红旗招展"];
        
        
        
        
        cycleScrollView2.imageURLStringsGroup = arr1;
        cycleScrollView2.titlesGroup = arr2;
    });
}

-(void)makeCollection{
    //创建布局文件
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置Item的大小
    layout.itemSize = CGSizeMake(125 *self.numSingleVesion , 125 *self.numSingleVesion);
    //设置边距大小
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //设置滑动的方向  默认是竖向的滑动
    //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置最小行间距
    layout.minimumLineSpacing = 0;
    //设置最小列间距  不好用
    //这里的行和列的意义是和滚动方向相关的 滚动方向不同 行与列代表的意义不同
    layout.minimumInteritemSpacing = 0;
    
    self.CollectionView.dataSource =self;
    self.CollectionView.delegate = self;
    //指定代理
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0,64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 ) collectionViewLayout:layout];
    collection.dataSource = self;
    collection.delegate = self;
    
    //注册UICollectionViewCell
    //    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell_id"];
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell_id"];
    collection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collection];
    self.CollectionView = collection;
//    self.CollectionView.backgroundColor = SMSColor(235, 235, 235);
    self.CollectionView.backgroundColor = [UIColor whiteColor];

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}



//制定有多少个section
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 2;
//}

//初始化cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_id" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(30 * self.numSingleVesion, 20 * self.numSingleVesion, 65 * self.numSingleVesion, 65 * self.numSingleVesion)];
    NSLog(@"%@",self.images);
    [imagev sd_setImageWithURL:[NSURL URLWithString:self.images[indexPath.row]]];
    [cell.contentView addSubview:imagev];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.numSingleVesion, 100 * self.numSingleVesion , 115 * self.numSingleVesion, 20)];
    lab.text = self.titles[indexPath.row];
    lab.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:lab];
    
    
    return cell;
}

//指定每一个Item的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //    if (indexPath.row%2) {
    return CGSizeMake(125 * self.numSingleVesion, 130 *self.numSingleVesion);
    //    }else
    //        return CGSizeMake(120, 120);
    
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PartyBuildQZTableViewController *qz = [[PartyBuildQZTableViewController alloc] init];
    qz.catalogId = self.icons[indexPath.row];
    [self.navigationController pushViewController:qz animated:YES];
   
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
