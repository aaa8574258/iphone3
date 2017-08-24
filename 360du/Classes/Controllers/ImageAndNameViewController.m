//
//  ImageAndNameViewController.m
//  360du
//
//  Created by 利美 on 16/12/27.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ImageAndNameViewController.h"
#import "ImagePickerChooseView.h"
#import "AGImagePickerController.h"
#import "ShowImageViewController.h"
#import "NFPickerView.h"
#import "ALAsset+AGIPC.h"
#import "HeaderContent.h"
#import "StoreageMessage.h"
#import "UIView+Toast.h"
#import "NSString+URLEncoding.h"

@interface ImageAndNameViewController ()
@property (nonatomic ,strong) NSMutableArray *imagePickerArray;
@property (weak, nonatomic)UIView *photoView;
@property (nonatomic ,weak) UIButton *addPictureButton;
@property (nonatomic ,strong) AGImagePickerController *imagePicker;
@property (nonatomic ,weak) ImagePickerChooseView *IPCView;
@property (nonatomic, strong) UIButton *BtnN;
@property (nonatomic ,strong) UIButton *BtnNv;
@property (nonatomic ,copy) NSString *sexNumber;
@property (nonatomic ,strong) UITextField *NameTextF;
@end

@implementation ImageAndNameViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self makeOtherUI];

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];


    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self makeNav];
    [self initHeaderView];

}


-(void) makeNav{
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    View.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:View];
    self.title = @"个人信息";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 30);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(WIDTH_CONTROLLER + 30 *self.numSingleVesion , 0,60 * self.numSingleVesion, 30 * self.numSingleVesion);
    [searchBtn setTitle:@"保存" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:39/255.0 blue:77/255.0 alpha:1] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14 *self.numSingleVesion];
    [searchBtn addTarget:self action:@selector(backDown:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.userInteractionEnabled = YES;
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = right1;
    
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
}


-(void)backDown:(UIButton *)sender{
    NSLog(@"%@--%@--%@",self.sexNumber,self.imagePickerArray,self.NameTextF);
    if (self.sexNumber.length == 0) {
        [self.view makeToast:@"请选择性别"];
    }else if (self.imagePickerArray.count == 0){
        [self.view makeToast:@"请选择你的头像"];
    }else if (self.NameTextF.text.length == 0){
        [self.view makeToast:@"请输入你的昵称"];
    }else{
        [self sendImageDataToSever];
    }
}



-(void) makeOtherUI{
    UIView *sexView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 5 *self.numSingleVesion, self.view.frame.size.width, 40 *self.numSingleVesion)];
    sexView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sexView];
    UILabel *labN = [[UILabel alloc] initWithFrame:CGRectMake(100 *self.numSingleVesion, 10 *self.numSingleVesion, 20 * self.numSingleVesion, 20 *self.numSingleVesion)];
    labN.text = @"男";
    labN.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    labN.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
    [sexView addSubview:labN];
    UILabel *labNv = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width- 120 *self.numSingleVesion , 10 *self.numSingleVesion, 20 * self.numSingleVesion, 20 *self.numSingleVesion)];
    labNv.text = @"女";
    labNv.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    labNv.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
    [sexView addSubview:labNv];
    UIButton *btnN = [UIButton buttonWithType:UIButtonTypeCustom];
    btnN.frame = CGRectMake(120 *self.numSingleVesion, 10 *self.numSingleVesion, 20 * self.numSingleVesion, 20 *self.numSingleVesion);
    [btnN setImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
    btnN.tag = 12345;
    [btnN addTarget:self action:@selector(sexBtn:) forControlEvents:UIControlEventTouchUpInside];
    [sexView addSubview:btnN];
    UIButton *btnNv = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNv.frame = CGRectMake(self.view.frame.size.width- 100 *self.numSingleVesion , 10 *self.numSingleVesion, 20 * self.numSingleVesion, 20 *self.numSingleVesion);
    [btnNv setImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
    btnNv.tag = 12346;
    [btnNv addTarget:self action:@selector(sexBtn:) forControlEvents:UIControlEventTouchUpInside];
    [sexView addSubview:btnNv];
    self.BtnN = btnN;
    self.BtnNv = btnNv;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 5 *self.numSingleVesion + 41 *self.numSingleVesion, self.view.frame.size.width, 56 * self.numSingleVesion)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectZero];
    lab.text = @"头像";
    lab.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
    [lab sizeToFit];
    lab.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    lab.center = CGPointMake(43 *self.numSingleVesion, view.frame.size.height/2);
    [view addSubview:lab];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15 *self.numSingleVesion, 15 * self.numSingleVesion)];
    [img setImage:[UIImage imageNamed:@"p向右.png"]];
    img.center = CGPointMake(self.view.frame.size.width - 22.5 *self.numSingleVesion, view.frame.size.height/2);
    [view addSubview:img];
    
    
    
    UIView *view11 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50 *self.numSingleVesion , 50 *self.numSingleVesion)];
    view11.center = CGPointMake(self.view.frame.size.width -75*self.numSingleVesion , view.frame.size.height/2);
//    view11.backgroundColor = [UIColor cyanColor];
    self.photoView = view11;
    
    [view addSubview:view11];
    UITapGestureRecognizer *tapPay1 =[[ UITapGestureRecognizer alloc ] initWithTarget : self action : @selector (addPicture)];
    [view addGestureRecognizer :tapPay1];
    self.view. userInteractionEnabled = YES ;

    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 62 *self.numSingleVesion+ 41 *self.numSingleVesion, self.view.frame.size.width, 40 * self.numSingleVesion)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectZero];
    lab2.text = @"昵称";
    lab2.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
    lab2.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    [lab2 sizeToFit];
    lab2.center = CGPointMake(43 *self.numSingleVesion, view2.frame.size.height/2);
    [view2 addSubview:lab2];
    UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 180 *self.numSingleVesion, 10 *self.numSingleVesion, 165 *self.numSingleVesion, 25)];
    textF.placeholder = @"输入你的昵称";
    [textF setValue:[UIFont boldSystemFontOfSize:13]forKeyPath:@"_placeholderLabel.font"];
    [textF setValue:@"NSTextAlignmentRight" forKeyPath:@"_placeholderLabel.textAlignment"];
    textF.textAlignment = NSTextAlignmentRight;
    textF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [view2 addSubview:textF];
    self.NameTextF = textF;
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 107 *self.numSingleVesion+ 41 *self.numSingleVesion, self.view.frame.size.width, 40 * self.numSingleVesion)];
    view3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view3];
    UILabel * lab3 = [[UILabel alloc] initWithFrame:CGRectZero];
    lab3.text = @"手机号";
    lab3.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
    lab3.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    [lab3 sizeToFit];
    lab3.center = CGPointMake(50 *self.numSingleVesion, view3.frame.size.height/2);
    [view3 addSubview:lab3];
    UILabel *lab33 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 180 *self.numSingleVesion, 10 *self.numSingleVesion, 165 *self.numSingleVesion, 25)];
    lab33.text = [StoreageMessage getMessage][0];
    lab33.font = [UIFont systemFontOfSize:13 *self.numSingleVesion];
    lab33.textAlignment = NSTextAlignmentRight;
    [view3 addSubview:lab33];
}


-(void)sexBtn:(UIButton *)btn{
    if (btn.tag == 12345) {
        [self.BtnN setImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateNormal];
        [self.BtnNv setImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        self.sexNumber = @"1";
    }else if (btn.tag == 12346){
        [self.BtnN setImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [self.BtnNv setImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateNormal];
        self.sexNumber = @"2";    
    }
}




-(NSMutableArray *)imagePickerArray
{
    if (!_imagePickerArray) {
        _imagePickerArray = [[NSMutableArray alloc]init];
    }
    return _imagePickerArray;
}

#define pictureHW 50 *self.numSingleVesion
#define MaxImageCount 1
#define deleImageWH 25 // 删除按钮的宽高
-(void)initHeaderView
{
    [self.photoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //    UIView *headView = [[UIView alloc]initWithFrame:CGRectZero];
    NSInteger imageCount = [self.imagePickerArray count];
    for (NSInteger i = 0; i < imageCount; i++) {
        UIImageView *pictureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0 + (i%4)*(pictureHW+0),0 +(i/4)*(pictureHW+0), pictureHW, pictureHW)];
        //用作放大图片
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [pictureImageView addGestureRecognizer:tap];
        pictureImageView.tag = imageTag + i;
        pictureImageView.userInteractionEnabled = YES;
        if ([self.imagePickerArray[i] isKindOfClass:[ALAsset class]]) {
            pictureImageView.image = [UIImage imageWithCGImage:((ALAsset *)[self.imagePickerArray objectAtIndex:i]).thumbnail];
        }else{
            pictureImageView.image = self.imagePickerArray[i];
        }
        [self.photoView addSubview:pictureImageView];
    }
//    if (imageCount < MaxImageCount) {
        UIButton *addPictureButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50 *self.numSingleVesion , 50 *self.numSingleVesion)];
//        [addPictureButton setBackgroundImage:[UIImage imageNamed:@"add_photo.png"] forState:UIControlStateNormal];
        [addPictureButton addTarget:self action:@selector(addPicture) forControlEvents:UIControlEventTouchUpInside];
        [self.photoView addSubview:addPictureButton];
        self.addPictureButton = addPictureButton;
//    }
    
//    self.photoHeight.constant = 10+ (10 + pictureHW)*([self.imagePickerArray count]/4 + 1 );
    
}


-(void)addPicture{
    [self.NameTextF resignFirstResponder];
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
        
        self.imagePicker.maximumNumberOfPhotosToBeSelected = 1 - [self.imagePickerArray count];
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




//图片上传
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
            [arrayImage addObject:img];
            [dicmu setObject:img forKey:[NSString stringWithFormat:@"%@",self.imagePickerArray[i]]];
        }
    }
//    NSString *timeStr = [TranlateTime gainTimeStamp];
//    self.uuid = timeStr;
    [self PostImagesToServer:LOADUSERHEADER dicPostParams:@{@"memberId":[StoreageMessage getMessage][2]} dicImages:dicmu];
    //    [self PostImagesToServer:RENTGETIMAGE dicPostParams:@{@"houseId":@"777",@"flag":@"0"} dicImages:dicmu];
    
}

-(void)PostImagesToServer:(NSString *) strUrl dicPostParams:(NSMutableDictionary *)params dicImages:(NSMutableDictionary *) dicImages{
    NSLog(@"%@",dicImages);
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
        
        NSLog(@"上传的图片：%d  %@", i, [keys objectAtIndex:i]);
        
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
    //    NSLog(@"%@",myRequestData);
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
    NSLog(@"%@",request);
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
    NSLog(@"服务器返回：%@", res);
    //    if (![resid[@"code"] isEqualToString:@"000000"]) {
    //        [self.view makeToast:@"上传失败请重新上传"];
    //    }
    //    NSLog(@"%@",res);
    [self loadNameSex];
    
}

-(void) loadNameSex{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:LOADUSERNAMEANDSEX,[StoreageMessage getMessage][2],[[self.NameTextF.text urlEncodeString] urlEncodeString],self.sexNumber] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        if ([getResult[@"code"] isEqualToString:@"000000"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self.view makeToast:getResult[@"message"]];
        }
    }];
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
