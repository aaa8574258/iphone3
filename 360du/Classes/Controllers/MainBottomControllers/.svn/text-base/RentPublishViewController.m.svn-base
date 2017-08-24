//
//  RentPublishViewController.m
//  360du
//
//  Created by 利美 on 16/6/14.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "RentPublishViewController.h"
#import "NSString+URLEncoding.h"
#import "RentSSModel.h"
#import "AddrFirstTableViewController.h"
#import "SendMessage.h"
#import "UITableView+Improve.h"
#import "StoreageMessage.h"
#import "UIImage+ReSize.h"
#import "HeaderContent.h"
#import "ImagePickerChooseView.h"
#import "AGImagePickerController.h"
#import "ShowImageViewController.h"
#import "NFPickerView.h"
#import "AFNETworking.h"
#import "UIView+Toast.h"
#import "LocationCommunityViewController.h"
#define SendImageFromFile @"rentImageAlreadyPushToSever/egf"
@interface RentPublishViewController ()<UIGestureRecognizerDelegate,NFPickerViewDelegete,UITextViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic ,strong) NSMutableArray *ssCodeArr;
@property (nonatomic ,copy) NSString *hzName,*hzCode;
@property (nonatomic ,copy) NSString *qyname;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoHeight;
@property (nonatomic, weak) UIViewController *fromController;

@property (nonatomic ,copy) NSString *qycode;
@property (nonatomic ,copy) NSString *xqCode,*location;
@property (nonatomic ,copy) NSString *yjCode;
@property (nonatomic ,copy) NSString *fwStyleCode;
@property (nonatomic ,copy) NSString *cxCode;
@property (nonatomic ,copy) NSString *hxCode,*hxname;
@property (nonatomic ,copy) NSString *lcCode;
@property (nonatomic ,weak) UILabel *pLabel;
@property (nonatomic ,weak) UIButton *addPictureButton;
@property (nonatomic ,weak) ImagePickerChooseView *IPCView;
@property (nonatomic ,strong) AGImagePickerController *imagePicker;
@property (nonatomic, strong) NSData *imagedata;
@property (nonatomic ,copy) NSString *houseId;
@property (nonatomic ,copy) NSString *houseCount;
@property (nonatomic ,copy) NSString *lcMaxCount;
@property (weak, nonatomic) IBOutlet UILabel *hzLab;
@property (nonatomic ,copy) NSMutableArray *facilities;
//imagePicker队列
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hzHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hzNextHeight;
@property (weak, nonatomic) IBOutlet UIView *hzSuperView;
@property (nonatomic ,strong) NSMutableArray *imagePickerArray;
@property (nonatomic ,copy) NSString *dzfpCode;
@property (nonatomic ,copy) NSString *dzzfCode;

@property (weak, nonatomic) IBOutlet UILabel *qwer;



@end

@implementation RentPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SendMessage shareInstance].singleValue = nil;
    [SendMessage shareInstance].singleCode = nil;

    if (self.imagePickerArray.count < 1) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"上传图片可以增加被访问量" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        
        [alert show];
    }
//    NSLog(@"%@",_tag);
    self.zjTextF.delegate = self;
    self.mjTextF.delegate = self;
    self.phoneTextF.delegate = self;
    self.dzyjTextF.delegate = self;
    self.dzzdzqTxetF.delegate =self;
    self.msTextView.delegate = self;
    // Do any additional setup after loading the view.
    [self makeHUd];
    [self giveInfo];
    [self thouchViews];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"landi.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 25 * self.numSingleVesion, 25 *self.numSingleVesion);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
//    [self getHZStyle];

}
-(NSMutableArray *)imagePickerArray
{
    if (!_imagePickerArray) {
        _imagePickerArray = [[NSMutableArray alloc]init];
    }
    return _imagePickerArray;
}
-(void)returndzzfWithName:(NSString *)name andcode:(NSString *)code{}

-(void)viewWillAppear:(BOOL)animated{
    
    [self initHeaderView];

    if ([SendMessage shareInstance].singleValue) {
        //    if (!self.chooseName) {
        self.qyname = [SendMessage shareInstance].singleValue;
        self.qycode = [SendMessage shareInstance].singleCode;
        self.quyuLabel.text = [NSString stringWithFormat:@"  %@",self.qyname] ;
        self.quyuLabel.textColor = [UIColor blackColor];
    }
    if (self.quyuLabel.text == nil) {
        self.quyuLabel.text = @"  请选择区域";
    }
    if ([self.tag isEqualToString:@"3"]) {
        self.qwer.text = @"元/天";
        [self.yjLab.superview removeFromSuperview];
        [self.cxLab.superview removeFromSuperview];
        [self.hxLab.superview removeFromSuperview];
        [self.hzLab.superview removeFromSuperview];
        [self.lcLab.superview removeFromSuperview];
        [self.mjTextF.superview removeFromSuperview];
        [self.ptssSuperView removeFromSuperview];
        self.hzTozzHeight.constant = 41*6+8;
        self.fwStyleToZjHeight.constant = 1;
        self.titleToXqHeight.constant = 41*4 + 131+41;
    }else {
        [self.dzfplab.superview removeFromSuperview];
        [self.dzjdTextF.superview removeFromSuperview];
        [self.dzrzTexF.superview removeFromSuperview];
        [self.dztfTextF.superview removeFromSuperview];
        [self.dzyjTextF.superview removeFromSuperview];
        [self.dzzdzqTxetF.superview removeFromSuperview];
        self.hzTozzHeight.constant = 8;
        self.titleToXqHeight.constant = 8*40 + 7  + 8*2  +self.ptssSuperHeight.constant;
    if ([self.tag isEqualToString:@"1"]) {
        self.hzNextHeight.constant = 1;
        [self.hzSuperView removeFromSuperview];
    }
    if ([self.tag isEqualToString:@"2"]) {
        

    }
    }
}

/**
 *  租房图片选择
 *
 *  @param padding <#padding description#>
 *
 *  @return <#return value description#>
 */
#define pictureHW (screenWidth - 5*padding)/4
#define MaxImageCount 8
#define deleImageWH 25 // 删除按钮的宽高
-(void)initHeaderView
{
    [self.photoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    UIView *headView = [[UIView alloc]initWithFrame:CGRectZero];
    NSInteger imageCount = [self.imagePickerArray count];
    for (NSInteger i = 0; i < imageCount; i++) {
        UIImageView *pictureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(padding + (i%4)*(pictureHW+padding),padding +(i/4)*(pictureHW+padding), pictureHW, pictureHW)];
        //用作放大图片
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [pictureImageView addGestureRecognizer:tap];
        
        //添加删除按钮
        UIButton *dele = [UIButton buttonWithType:UIButtonTypeCustom];
        dele.frame = CGRectMake(pictureHW - deleImageWH + 5 * self.numSingleVesion, -10 * self.numSingleVesion, deleImageWH, deleImageWH);
        [dele setImage:[UIImage imageNamed:@"deletePhoto"] forState:UIControlStateNormal];
        [dele addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
        [pictureImageView addSubview:dele];
        pictureImageView.tag = imageTag + i;
        pictureImageView.userInteractionEnabled = YES;
        if ([self.imagePickerArray[i] isKindOfClass:[ALAsset class]]) {
        pictureImageView.image = [UIImage imageWithCGImage:((ALAsset *)[self.imagePickerArray objectAtIndex:i]).thumbnail];
        }else{
        pictureImageView.image = self.imagePickerArray[i];
        }
        [self.photoView addSubview:pictureImageView];
    }
    if (imageCount < MaxImageCount) {
        UIButton *addPictureButton = [[UIButton alloc]initWithFrame:CGRectMake(padding + (imageCount%4)*(pictureHW+padding), padding +(imageCount/4)*(pictureHW+padding), pictureHW, pictureHW)];
        [addPictureButton setBackgroundImage:[UIImage imageNamed:@"add_photo.png"] forState:UIControlStateNormal];
        [addPictureButton addTarget:self action:@selector(addPicture) forControlEvents:UIControlEventTouchUpInside];
        [self.photoView addSubview:addPictureButton];
        self.addPictureButton = addPictureButton;
    }

   self.photoHeight.constant = 10+ (10 + pictureHW)*([self.imagePickerArray count]/4 + 1 );

}


-(void)addPicture{
    
    [self initImagePickerChooseView];
}

#pragma mark - gesture method
-(void)tapImageView:(UITapGestureRecognizer *)tap
{
    ShowImageViewController *vc = [[ShowImageViewController alloc] init];
    vc.clickTag = tap.view.tag;
    vc.imageViews = self.imagePickerArray;
    [self.navigationController pushViewController:vc animated:YES];
}



// 删除图片
-(void)deletePic:(UIButton *)btn
{
    if ([(UIButton *)btn.superview isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)btn.superview;
        
        [self.imagePickerArray removeObjectAtIndex:(imageView.tag - imageTag)];
        [imageView removeFromSuperview];
    }
    [self initHeaderView];
}

#define IPCViewHeight 120
-(void)initImagePickerChooseView
{
    ImagePickerChooseView *IPCView = [[ImagePickerChooseView alloc]initWithFrame:CGRectMake(0, screenHeight, screenWidth, IPCViewHeight) andAboveView:self.view];
    [IPCView setImagePickerBlock:^{
        self.imagePicker = [[AGImagePickerController alloc] initWithFailureBlock:^(NSError *error) {
            
            if (error == nil)
            {
                [self dismissViewControllerAnimated:YES completion:^{}];
                [self.IPCView disappear];
            } else
            {
//                NSLog(@"Error: %@", error);
                
                // Wait for the view controller to show first and hide it after that
                double delayInSeconds = 0.5;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self dismissViewControllerAnimated:YES completion:^{}];
                });
            }
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            
        } andSuccessBlock:^(NSArray *info) {
            [self.imagePickerArray addObjectsFromArray:info];
            [self dismissViewControllerAnimated:YES completion:^{}];
            [self.IPCView disappear];
            [self initHeaderView];
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        }];
        
        self.imagePicker.maximumNumberOfPhotosToBeSelected = 9 - [self.imagePickerArray count];
        [self presentViewController:self.imagePicker animated:YES completion:^{}];
    }];
    
    [IPCView setImagePickerblock1:^{
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:^{}];

    }];

    
    
    
    
    
    [UIView animateWithDuration:0.25f animations:^{
        IPCView.frame = CGRectMake(0, screenHeight - IPCViewHeight-64, screenWidth, IPCViewHeight);
    } completion:^(BOOL finished) {
    }];
    [self.view addSubview:IPCView];
    self.IPCView = IPCView;
    [self.IPCView addImagePickerChooseView];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self saveImage:image withName:@"currentImage.png"];

    

    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];


    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
//    NSLog(@"%@",savedImage);
    UIImage *newImage = [self image:savedImage byScalingToSize:CGSizeMake(savedImage.size.width/4, savedImage.size.height/4)];
    [self.imagePickerArray addObject:newImage];
    [self dismissViewControllerAnimated:YES completion:^{}];
    [self.IPCView disappear];
    [self initHeaderView];
    
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];

}

- (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}


//取到的图片保存到沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{

    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);

    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];

    [imageData writeToFile:fullPath atomically:YES];
}












-(void)giveInfo{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    NSString *url = [NSString stringWithFormat:RENTPUBLISHSS,@"Facilities"];
    [twoPacking getUrl:url andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        self.ssCodeArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *tagsArr = [NSMutableArray arrayWithCapacity:0];
//        NSLog(@"%@",getResult);
        if ([getResult[@"code"] isEqualToString:@"000000"]) {
            for (NSDictionary *dic in getResult[@"datas"]) {
                RentSSModel *model = [[RentSSModel alloc] initWithDictionary:dic];
                [self.ssCodeArr addObject:model.CodeValue];
                [tagsArr addObject:model.CodeName];
//                NSLog(@"%@",model.CodeName);
            }
//            NSLog(@"%@",tagsArr);
            [self addVOtags:tagsArr];
        }
    }];
}

/**
 *  租房设施选择
 *
 *  @param _tags <#_tags description#>
 */
-(void)addVOtags:(NSMutableArray *)_tags{
    VOTagList *tagList = [[VOTagList alloc] initWithTags:_tags];
    tagList.frame = CGRectMake(0, 0, self.ssView.frame.size.width, 230);
    tagList.multiLine = YES;
    tagList.multiSelect = YES;
    tagList.allowNoSelection = YES;
    tagList.vertSpacing = 10;
    tagList.horiSpacing = 10;
    tagList.selectedTextColor = [UIColor whiteColor];
    tagList.tagBackgroundColor = [UIColor whiteColor];
    tagList.selectedTagBackgroundColor = [UIColor redColor];
    tagList.tagCornerRadius = 3;
    tagList.tagEdge = UIEdgeInsetsMake(8, 8, 8, 8);
    _ptssSuperHeight.constant = tagList.frame.size.height;
//    NSLog(@"%f",tagList.frame.size.height);
    if (![self.tag isEqualToString:@"3"]) {
        self.titleToXqHeight.constant = 8*40 + 7 + 8*2 +self.ptssSuperHeight.constant;
    }
    [tagList addTarget:self action:@selector(selectedTagsChanged:) forControlEvents:UIControlEventValueChanged];
    [self.ssView addSubview:tagList];

}
- (void)selectedTagsChanged: (VOTagList *)tagList{

    self.facilities = [NSMutableArray arrayWithArray:[self.ssCodeArr objectsAtIndexes:tagList.selectedIndexSet]];
//    BOOL isbool = [_ssCodeArr containsObject:@"1"];

//    if (isbool) {
//        NSMutableIndexSet *sett = [NSMutableIndexSet new];
//
//        for (NSInteger i = 0; i< _ssCodeArr.count; i++) {
//            [sett addIndex:i];
//        }
//        tagList.selectedIndexSet == [sett mutableCopy];
//    }
//    NSLog(@"selected: %@",tagList.selectedIndexSet );

}

-(void)thouchViews{
    NSArray *viewsArr = @[_quyuLabel,_xqLabel,_yjLab,_fwStyleLab,_cxLab,_hxLab,_lcLab,_hzLab,_dzfplab];
    for (UILabel *lab in viewsArr) {
        UITapGestureRecognizer *tap=[[ UITapGestureRecognizer alloc ] initWithTarget : self action : @selector (randomColor:)];
        [lab addGestureRecognizer :tap];
        lab. userInteractionEnabled = YES ;
    }
    
}




-(void) returnAddrAndnumber:(NSString *)code andName:(NSString *)name andLocation:(NSString *)location{
    self.xqLabel.text = [NSString stringWithFormat:@"  %@",name];
    self.xqLabel.textColor = [UIColor blackColor];
    self.xqCode = code;
    self.location = location;
}

-(void) returnyjfsWithName:(NSString *)name andcode:(NSString *)code{
    self.yjLab.text = [NSString stringWithFormat:@"  %@",name];
    self.yjLab.textColor = [UIColor blackColor];

    self.yjCode = code;
}

-(void) returnfwlxWithName:(NSString *)name andcode:(NSString *)code{
    self.fwStyleLab.text = [NSString stringWithFormat:@"  %@",name];
    self.fwStyleLab.textColor = [UIColor blackColor];

    self.fwStyleCode = code;
}


-(void) returnfaceWithName:(NSString *)name andcode:(NSString *)code{
    self.cxLab.text = [NSString stringWithFormat:@"  %@",name];
    self.cxLab.textColor = [UIColor blackColor];

    self.cxCode = code;
}

-(void) returnhzWithName:(NSString *)name andcode:(NSString *)code{
    self.hzLab.text = [NSString stringWithFormat:@"  %@",name];
    self.hzLab.textColor = [UIColor blackColor];

    self.hzCode = code;
}

-(void) returndzfpWithName:(NSString *)name andcode:(NSString *)code{
    self.dzfplab.text = [NSString stringWithFormat:@"  %@",name];
    self.dzfplab.textColor = [UIColor blackColor];

    self.dzfpCode = code;
}


//-(void) returnhxWithName:(NSString *)name andcode:(NSString *)code{
//    self.hxLab.text = [NSString stringWithFormat:@"  %@",name];
//    self.hxCode = code;
//}






-( void )randomColor:( UITapGestureRecognizer *)gestureRecognizer{
    UILabel *lab=( UILabel *)gestureRecognizer.view;
    
    if (lab.tag == 10086) {
        NSLog(@"%@",[StoreageMessage getCity]);
        AddrFirstTableViewController *controller = [[AddrFirstTableViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (lab.tag == 10087) {
        LocationCommunityViewController *controller = [[LocationCommunityViewController alloc] init];
        controller.target = self;
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (lab.tag == 10088) {
        UniversalViewController *controller = [[UniversalViewController alloc] initWithUrl:@"yjfs"];
        controller.target = self;
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (lab.tag == 10089) {
        if ([self.tag isEqualToString:@"3"]) {
            UniversalViewController *controller = [[UniversalViewController alloc] initWithUrl:RENTDZHOMETYPE];
            controller.target = self;
            [self.navigationController pushViewController:controller animated:YES];
        }else{
        
        
        UniversalViewController *controller = [[UniversalViewController alloc] initWithUrl:[NSString stringWithFormat:RENTPUBLISHSS,@"ZHHouseType"]];
        controller.target = self;
        [self.navigationController pushViewController:controller animated:YES];
        }
    }
    if (lab.tag == 10090) {
        UniversalViewController *controller = [[UniversalViewController alloc] initWithUrl:[NSString stringWithFormat:RENTPUBLISHSS,@"face"]];
        controller.target = self;
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (lab.tag == 10091) {
        NFPickerView *pickerView1 = [[NFPickerView alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(self.view.frame)/2-110, CGRectGetWidth(self.view.frame)-40, 220)];
        
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr1= [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:0];

        for (NSInteger i = 0; i < 100; i ++) {
//            [arr addObject:[NSString stringWithFormat:@"%ld室",i]];
            
//            pickerView1.province = [arr mutableCopy];
            if (i>0) {
            NSString *str = [NSString stringWithFormat:@"%ld室",i];
            [arr addObject:str];
            pickerView1.province = [arr mutableCopy];
            }
            [arr1 addObject:[NSString stringWithFormat:@"%ld厅",i]];
            
            pickerView1.city = [arr1 mutableCopy];
            [arr2 addObject:[NSString stringWithFormat:@"%ld卫",i]];
            pickerView1.country = [arr2 mutableCopy];
        }
        
        pickerView1.tag = 23333;
        pickerView1.delegate = self;
        [pickerView1 show];
    }
    if (lab.tag == 10092) {
        NFPickerView *pickerView2 = [[NFPickerView alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(self.view.frame)/2-110, CGRectGetWidth(self.view.frame)-40, 220)];
        NSMutableArray *arr1= [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        
        for (NSInteger i = 1; i < 100; i ++) {
            //            [arr addObject:[NSString stringWithFormat:@"%ld室",i]];
            
            //            pickerView1.province = [arr mutableCopy];
            
                NSString *str = [NSString stringWithFormat:@"第%ld层",i];
                [arr addObject:str];
                pickerView2.province = [arr mutableCopy];
            [arr1 addObject:[NSString stringWithFormat:@"共%ld层",i]];
            pickerView2.city = [arr1 mutableCopy];
            
        }
        pickerView2.country = nil;
        pickerView2.tag = 23334;
        pickerView2.delegate = self;
        [pickerView2 show];
    }
    if (lab.tag == 10093) {
        UniversalViewController *controller = [[UniversalViewController alloc] initWithUrl:[NSString stringWithFormat:RENTPUBLISHSS,@"RoommateType"]];
        controller.target = self;
        [self.navigationController pushViewController:controller animated:YES];
    
    }
    //短租发票
    if (lab.tag == 10094) {
        UniversalViewController *controller = [[UniversalViewController alloc] initWithUrl:@"dzfp"];
        controller.target = self;
        [self.navigationController pushViewController:controller animated:YES];
    //短租能否做饭
    }
    
    
    
}

-(void)pickerDidSelectWithSelfView:(UIView *)view ProvinceName:(NSString *)provinceName cityName:(NSString *)cityName countrys:(NSString *)countrys{
    if (view.tag == 23333) {
//        NSLog(@"2333%@--%@--%@",provinceName,cityName,countrys);
        self.hxLab.text = [NSString stringWithFormat:@"  %@%@%@",provinceName,cityName,countrys];
        self.hxLab.textColor = [UIColor blackColor];
        self.hxname = [NSString stringWithFormat:@"%@%@%@",provinceName,cityName,countrys];
        self.houseCount = [provinceName substringToIndex:1];
    }
    if (view.tag == 23334) {
//        NSLog(@"2444%@-%@",provinceName,cityName);
        self.lcLab.text = [NSString stringWithFormat:@"  %@-%@",provinceName,cityName];
        self.lcLab.textColor = [UIColor blackColor];

        self.lcCode = [provinceName substringWithRange:NSMakeRange(1,1)];
        self.lcMaxCount = [cityName substringWithRange:NSMakeRange(1,1)];
    }
}

//上传按钮
- (IBAction)publishYes:(UIButton *)sender {
    /**
     *  创建租房主键
     */
//    NSLog(@"%@",RENTGETHOUSEID);
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:RENTGETHOUSEID andFinishBlock:^(id getResult) {
//        NSLog(@"%@",getResult);
        self.houseId = getResult[@"datas"];
//        NSLog(@"%@",self.imagePickerArray);
//        if (self.imagePickerArray != nil) {
        [self sendImageDataToSever];
//        }
        [self sendOtherData];
    }];
   
}
//租房发布图片上传
-(void)sendImageDataToSever{
    NSMutableDictionary *dicmu = [[NSMutableDictionary alloc]initWithCapacity:0];
    NSMutableArray *arrayImage = [NSMutableArray arrayWithCapacity:0];
    
    for (NSInteger i = 0; i < self.imagePickerArray.count; i ++) {
        if ([self.imagePickerArray[i] isKindOfClass:[UIImage class]]) {
            [arrayImage addObject:self.imagePickerArray[i]];
            [dicmu setObject:self.imagePickerArray[i] forKey:[NSString stringWithFormat:@"%@",self.imagePickerArray[i]]];
        }
        if ([self.imagePickerArray[i] isKindOfClass:[ALAsset class]]){
            
            ALAssetRepresentation *assetRep = [self.imagePickerArray[i] defaultRepresentation];
            CGImageRef imgRef = [assetRep fullResolutionImage];
            UIImage *img = [UIImage imageWithCGImage:imgRef
                                               scale:assetRep.scale
                                         orientation:(UIImageOrientation)assetRep.orientation];
//            NSLog(@"%@",img);
            [arrayImage addObject:img];
            //        [arrayImage writeToFile:SendImageFromFile atomically:YES];
                    [dicmu setObject:img forKey:[NSString stringWithFormat:@"%@",self.imagePickerArray[i]]];
        }
    }
    
    NSLog(@"%@--%@",self.houseId,dicmu);
    [self PostImagesToServer:RENTGETIMAGE dicPostParams:@{@"houseId":_houseId,@"flag":@"0"} dicImages:dicmu];
    
    
}


// 限制发布时租金 面积 电话必须为数字



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            [self.view makeToast:@"请输入数字"];
            break;
        }
        i++;
    }
    return res;
}

/**
 *  租房数据上传
 */
-(void)sendOtherData{
    _zjTextF.keyboardType =  UIKeyboardTypeNumberPad;
    _mjTextF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextF.keyboardType = UIKeyboardTypePhonePad;
    if (!self.qycode.length) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择区域!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
    }else if (!self.houseId) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网速不给力,请重新尝试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
    }else if (!self.xqCode) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择小区!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
    }else if (!self.zjTextF.text.length) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入租金" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
    }else if (!self.titleTextF.text) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写标题!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
    }else if (!self.lxrTextF.text) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入联系人姓名!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
    }else if (!self.phoneTextF.text) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写您的联系方式!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
    }else if (!self.location) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无法获取到小区地址!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
    }else{
        if ([self.tag isEqualToString:@"1"] || [self.tag isEqualToString:@"2"]){
            if (!self.mjTextF.text.length) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写房屋面积!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertView show];
            }else if (!self.lcCode) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请   选择楼层!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertView show];
            }else if (!self.lcMaxCount) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择楼层!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertView show];
            }else if (!self.facilities) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择配套设施!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertView show];
            }else if (!self.fwStyleCode) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择房屋类型!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertView show];
            }else if (!self.cxCode) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择房屋朝向!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertView show];
            }else if (!self.fwStyleCode) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择付款方式!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertView show];
            }else if (!self.hxname) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择户型!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertView show];
            }else if (!self.houseCount) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择户型!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertView show];
            }else{
            
                NSString *mstext = self.msTextView.text;
//                NSLog(@"asasasas%@",mstext);
                
                NSString *ssCodeStr = nil;
                
                if (_facilities.count == 0) {
                    ssCodeStr = nil;
                }
                
                if (_facilities.count == 1) {
                    ssCodeStr = [NSString stringWithFormat:@"%@",_facilities.firstObject];
                }
                ssCodeStr =  [_facilities componentsJoinedByString:@","];
                
                //    [self makeTure];
                
//                NSLog(@"%@",self.lcLab.text);
                
                NSDictionary *dic = [NSDictionary new];
                if ([self.tag isEqualToString:@"1"]) {
                    dic = @{@"houseId":self.houseId,
                            @"houseTypeId":self.tag,
                            @"qyCode":self.qycode,
                            @"xqId":self.xqCode,
                            @"rent":[self.zjTextF.text urlEncodeString],
                            @"apartment":[self.hxname urlEncodeString],
                            @"roomCount":[self.houseCount urlEncodeString],
                            @"houseArea":[self.mjTextF.text urlEncodeString],
                            @"floor":[self.lcLab.text urlEncodeString],
                            @"floorCount":self.lcMaxCount,
                            @"facilities":ssCodeStr,
                            @"houseName":[self.titleTextF.text urlEncodeString],
                            @"houseDes":[self.msTextView.text urlEncodeString],
                            @"person":[self.lxrTextF.text urlEncodeString],
                            @"tel":[self.phoneTextF.text urlEncodeString],
                            @"source":[NSString stringWithFormat:@"%ld",self.lySegment.selectedSegmentIndex+1],
                            @"homeType":self.fwStyleCode,
                            @"face":self.cxCode,
                            @"payType":self.yjCode,
                            @"location":self.location,
                            @"roommateType":@"0",
                            @"memberId":[StoreageMessage getMessage][2]
                            };
                }
                if ([self.tag isEqualToString:@"2"]) {
                    dic = @{@"houseId":self.houseId,
                            @"houseTypeId":self.tag,
                            @"qyCode":self.qycode,
                            @"xqId":self.xqCode,
                            @"rent":[self.zjTextF.text urlEncodeString],
                            @"apartment":[self.hxname urlEncodeString],
                            @"roomCount":[self.houseCount urlEncodeString],
                            @"houseArea":[self.mjTextF.text urlEncodeString],
                            @"floor":[self.lcLab.text urlEncodeString],
                            @"roommateType":self.hzCode,
                            @"floorCount":self.lcMaxCount,
                            @"facilities":ssCodeStr,
                            @"houseName":[self.titleTextF.text urlEncodeString],
                            @"houseDes":[self.msTextView.text urlEncodeString],
                            @"person":[self.lxrTextF.text urlEncodeString],
                            @"tel":[self.phoneTextF.text urlEncodeString],
                            @"source":[NSString stringWithFormat:@"%ld",self.lySegment.selectedSegmentIndex+1],
                            @"homeType":self.fwStyleCode,
                            @"face":self.cxCode,
                            @"payType":self.yjCode,
                            @"location":self.location,
                            @"memberId":[StoreageMessage getMessage][2]

                            };
                }
                
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
                [manager POST:RENTPUBLISHMIN parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@"rerere%@",responseObject);
                    //        if ([responseObject[@"code"] isEqualToString:@"000000"]) {
//                    [self.view makeToast:responseObject[@"message"]];
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"发布成功，等待物业审核" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
                    alert.tag = 123456;
                    [alert show];
//                    [self.navigationController popViewControllerAnimated:YES];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                    NSLog(@"Error: %@", error);
                    [self.view makeToast:@"发布失败，请核实发布信息后重新发布"];
                }];
            }
        }
        if ([self.tag isEqualToString:@"3"]){
            if (!self.dzyjTextF.text.length) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写押金!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertView show];
            }else if (!self.dzzdzqTxetF.text.length) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写最短租期!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertView show];
            }else if (!self.dzrzTexF.text.length) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写入住时间!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertView show];
            }else if (!self.dzjdTextF.text.length) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写接待时间！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertView show];
            }else{
                NSDictionary *dic = @{@"houseId":self.houseId,
                              @"houseTypeId":self.tag,
                              @"qyCode":self.qycode,
                              @"xqId":self.xqCode,
                              @"deposit":[self.dzyjTextF.text urlEncodeString],
                              @"invoice":self.dzfpCode,
                              @"minrental":[self.dzzdzqTxetF.text urlEncodeString],
                              @"checkOutTime":[self.dztfTextF.text urlEncodeString],
                              @"stayTime":[self.dzrzTexF.text urlEncodeString],
                              @"receptionTime":[self.dzjdTextF.text urlEncodeString],
                              @"rent":[self.zjTextF.text urlEncodeString],
                              @"houseName":[self.titleTextF.text urlEncodeString],
                              @"houseDes":[self.msTextView.text urlEncodeString],
                              @"person":[self.lxrTextF.text urlEncodeString],
                              @"tel":[self.phoneTextF.text urlEncodeString],
                              @"source":[NSString stringWithFormat:@"%ld",self.lySegment.selectedSegmentIndex+1],
                              @"homeType":self.fwStyleCode,
                              @"location":self.location,
                              @"memberId":[StoreageMessage getMessage][2]
                                      };
//        NSLog(@"%@--%@",RENTPUBLISHSHOT,dic);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //申明返回的结果是json类型
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //如果报接受类型不一致请替换一致text/html或别的
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
        //传入的参数  十八里店横街子
        
        [manager POST:RENTPUBLISHSHOT parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"rerere%@",responseObject);
            //        if ([responseObject[@"code"] isEqualToString:@"000000"]) {
//            [self.view makeToast:responseObject[@"message"]];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"发布成功，等待物业审核" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            alert.tag = 123457;
            [alert show];
//            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"Error: %@", error);
            [self.view makeToast:@"发布失败，请核实发布信息后重新发布"];
        }];

            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 123456 || alertView.tag == 123457) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (buttonIndex == 1) {
        
        
    }else{
    
    
    
    }

}

//-(void)makeTure{
//    NSLog(@"%@%@%@%@%@%@%@",self.qycode,self.houseId,self.xqCode,self.zjTextF.text,self.hxname,self.houseCount,self.mjTextF.text);
// 
//
//}






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
-(void)PostImagesToServer:(NSString *) strUrl dicPostParams:(NSMutableDictionary *)params dicImages:(NSMutableDictionary *) dicImages{
    NSString * res;
    
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //根据url初始化request
    //NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //要上传的图片
    UIImage *image;//=[params objectForKey:@"pic"];
    //得到图片的data
    //NSData* data = UIImagePNGRepresentation(image);
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    NSArray *keys= [params allKeys];
    
    //遍历keys
    for(int i=0;i<[keys count];i++) {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //如果key不是pic，说明value是字符类型，比如name：Boris
        //if(![key isEqualToString:@"pic"]) {
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=%@\r\n\r\n",key];
        //[body appendString:@"Content-Transfer-Encoding: 8bit"];
        //添加字段的值
        [body appendFormat:@"%@\r\n",[params objectForKey:key]];
        //}
    }
    ////添加分界线，换行
    //[body appendFormat:@"%@\r\n",MPboundary];
    
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    //循环加入上传图片
    keys = [dicImages allKeys];
    for(int i = 0; i< [keys count] ; i++){
        //要上传的图片
        image = [dicImages objectForKey:[keys objectAtIndex:i ]];
        //得到图片的data
        NSData* data =  UIImageJPEGRepresentation(image, 0.0);
        NSMutableString *imgbody = [[NSMutableString alloc] init];
        //此处循环添加图片文件
        //添加图片信息字段
        //声明pic字段，文件名为boris.png

        
        ////添加分界线，换行
        [imgbody appendFormat:@"%@\r\n",MPboundary];
        [imgbody appendFormat:@"Content-Disposition: form-data; name=File%d; filename=%@.jpg\r\n", i, [keys objectAtIndex:i]];
        //声明上传文件的格式
        [imgbody appendFormat:@"Content-Type: application/octet-stream; charset=utf-8\r\n\r\n"];
        
//        NSLog(@"上传的图片：%d  %@", i, [keys objectAtIndex:i]);
        
        //将body字符串转化为UTF8格式的二进制
        //[myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData appendData:[imgbody dataUsingEncoding:NSUTF8StringEncoding]];
        //将image的data加入
        [myRequestData appendData:data];
        [myRequestData appendData:[ @"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"%@\r\n",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
//    NSLog(@"%@",request);
    //建立连接，设置代理
    //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //设置接受response的data
    NSData *mResponseData;
    NSError *err = nil;
    mResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
    
    if(mResponseData == nil){
//        NSLog(@"err code : %@", [err localizedDescription]);
        [self.view makeToast:@"服务器上传图片失败"];
    }
    res = [[NSString alloc] initWithData:mResponseData encoding:NSUTF8StringEncoding];
//    resid = mResponseData;
//    NSLog(@"服务器返回：%@", res);
//    if (![resid[@"code"] isEqualToString:@"000000"]) {
//        [self.view makeToast:@"上传失败请重新上传"];
//    }
//    NSLog(@"%@",res);
   
}

//-(void)getHZStyle{
//    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
//    [twoPacking getUrl:[NSString stringWithFormat:RENTPUBLISHSS,@"RoommateType"] andFinishBlock:^(id getResult) {
//        NSLog(@"%@",getResult);
//        [self hudWasHidden:self.hudProgress];
//        self.hzName = [NSMutableArray arrayWithCapacity:0];
//        self.hzCode = [NSMutableArray arrayWithCapacity:0];
//        NSLog(@"%@",getResult);
//        if ([getResult[@"code"] isEqualToString:@"000000"]) {
//            for (NSDictionary *dic in getResult[@"datas"]) {
//                RentSSModel *model = [[RentSSModel alloc] initWithDictionary:dic];
//                [self.hzCode addObject:model.CodeValue];
//                [self.hzName addObject:model.CodeName];
//                NSLog(@"%@",model.CodeName);
//            }
//        }
//
//    }];
//    
//    
//    
//    
//    
//}






@end
