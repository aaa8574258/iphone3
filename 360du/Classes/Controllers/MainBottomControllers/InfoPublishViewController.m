//
//  InfoPublishViewController.m
//  360du
//
//  Created by 利美 on 16/12/27.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "InfoPublishViewController.h"
#import "UIImage+ReSize.h"
#import "HeaderContent.h"
#import "ImagePickerChooseView.h"
#import "AGImagePickerController.h"
#import "ShowImageViewController.h"
#import "NFPickerView.h"
#import "XYTextView.h"
#import "StoreageMessage.h"
#import "NSString+URLEncoding.h"
#import "UIView+Toast.h"
@interface InfoPublishViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic ,strong) NSMutableArray *imagePickerArray;
@property(strong, nonatomic)XYTextView * textView;
@property (strong ,nonatomic) UITextField *titleTextF;
@property (strong, nonatomic) UIView *photoView;
@property (nonatomic ,weak) UIButton *addPictureButton;
@property (nonatomic ,weak) ImagePickerChooseView *IPCView;
@property (nonatomic ,strong) AGImagePickerController *imagePicker;
@end

@implementation InfoPublishViewController

- (instancetype)initWithTag:(NSString *)tag
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];

        NSLog(@"%@",tag);
        self.tag = tag;
        [self makeNav];
    }
    return self;
}


-(NSMutableArray *)imagePickerArray
{
    if (!_imagePickerArray) {
        _imagePickerArray = [[NSMutableArray alloc]init];
    }
    return _imagePickerArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

//-(void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
//}
//
//-(void)viewDidDisappear:(BOOL)animated{
//    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
//}

-(void) makeNav{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 30);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(WIDTH_CONTROLLER + 30 , 0,50, 30);
    [searchBtn setTitle:@"发布" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:39/255.0 blue:77/255.0 alpha:1];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchBtn addTarget:self action:@selector(backDown:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.userInteractionEnabled = YES;
    searchBtn.tag = 10087;
    
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    
    
    //self.navigationItem.titleView = view;
    self.navigationItem.rightBarButtonItem = right2;
    if ([self.tag isEqualToString:@"1"]) {
        [self makeTextViewAndPhoto];
        
    }else if ([self.tag isEqualToString:@"2"]){
        [self makeTextViewAndPhoto1];
        
    }

}

-(void)backDown:(UIButton *)sender{
    if ([self.tag isEqualToString:@"2"]) {
        if (self.imagePickerArray.count == 0) {
            [self.view makeToast:@"请设置网址的图片"];
            return;
        }else if (self.textView.text.length == 0){
            [self.view makeToast:@"请输入网址"];
            return;
        }else if (self.titleTextF.text.length == 0){
            [self.view makeToast:@"请输入文字内容"];
            return;
        }
    }
    
    [self makeHUd];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    //    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
    //传入的参数  十八里店横街子
    NSDictionary *dic = [[NSDictionary alloc]init];
    NSLog(@"%@",self.titleTextF.text);
    
    
    
    
    dic = @{@"title":[self.titleTextF.text urlEncodeString],@"content":[self.textView.text urlEncodeString],@"memberId":[StoreageMessage getMessage][2],@"publishType":self.tag,@"xqid":[StoreageMessage getCommuntityId]};
    
    //你的接口地址
    NSString *url = [NSString stringWithFormat:PUBLISHINFOCONTENT];
    [manager POST:url parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [StoreageMessage getErrorMessage:@"NULL" fromUrl:url];

        if ([responseObject[@"code"] isEqualToString:@"000000"]) {
            [self sendImageDataToSeverAndID:responseObject[@"datas"][@"id"]];
        }
    
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
    


    
}

//图片上传
-(void)sendImageDataToSeverAndID:(NSString *)Id{
    
    NSMutableDictionary *dicmu = [[NSMutableDictionary alloc]initWithCapacity:0];
    NSMutableArray *arrayImage = [NSMutableArray arrayWithCapacity:0];
    NSLog(@"%lu",(unsigned long)self.imagePickerArray.count);
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
    [self PostImagesToServer:PUBLISHINFOIMAGE dicPostParams:@{@"id":Id} dicImages:dicmu];
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
        return;
    }
    res = [[NSString alloc] initWithData:mResponseData encoding:NSUTF8StringEncoding];
    //    resid = mResponseData;
    NSLog(@"服务器返回：%@", res);
    //    if (![resid[@"code"] isEqualToString:@"000000"]) {
    //        [self.view makeToast:@"上传失败请重新上传"];
    //    }
    //    NSLog(@"%@",res);
    [self hudWasHidden:self.hudProgress];
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)makeTextViewAndPhoto{
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];

    NSInteger height1 = 64;
    UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(8 * self.numSingleVesion, 8 * self.numSingleVesion + height1, WIDTH_CONTENTVIEW - 16 * self.numSingleVesion, 20 * self.numSingleVesion)];
//    textF.placeholder = @" 请输入标题";
    [textF setValue:[UIFont boldSystemFontOfSize:12]forKeyPath:@"_placeholderLabel.font"];
    textF.font = [UIFont systemFontOfSize:13];
    textF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textF];
    textF.hidden = YES;
    self.titleTextF = textF;
    _textView = [[XYTextView alloc]initWithFrame:CGRectMake(8 * self.numSingleVesion, 18 * self.numSingleVesion + height1 + 20, WIDTH_CONTENTVIEW - 16 * self.numSingleVesion, 100 * self.numSingleVesion)];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:13];
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    [_textView setPlaceholderColor:[UIColor colorWithRed:205/255.0 green:205/255.0 blue:210/255.0 alpha:1]];
    [self.view addSubview:_textView];
    [self.textView setPlaceholder:@" 请输入内容"];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(8 * self.numSingleVesion, (20 + 20 + 100) * self.numSingleVesion + height1, WIDTH_CONTENTVIEW - 16 * self.numSingleVesion, 20 * self.numSingleVesion)];
    lab1.text = @" 添加照片:";
    lab1.font = [UIFont systemFontOfSize:13];
    lab1.textColor = [UIColor lightGrayColor];
    [self.view addSubview:lab1];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0 * self.numSingleVesion, (18 + 40 + 100) * self.numSingleVesion + height1, WIDTH_CONTENTVIEW, 260 * self.numSingleVesion)];
    [self.view addSubview:view];
    self.photoView = view;
    self.photoView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [self initHeaderView];

}



-(void)makeTextViewAndPhoto1{
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    
    NSInteger height1 = 64;
    UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(8 * self.numSingleVesion, 8 * self.numSingleVesion + height1, WIDTH_CONTENTVIEW - 16 * self.numSingleVesion, 20 * self.numSingleVesion)];
//    textF.placeholder = @" 请输入标题";
    [textF setValue:[UIFont boldSystemFontOfSize:12]forKeyPath:@"_placeholderLabel.font"];
    textF.font = [UIFont systemFontOfSize:13];
    textF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textF];
    self.titleTextF = textF;
    _textView = [[XYTextView alloc]initWithFrame:CGRectMake(8 * self.numSingleVesion, 18 * self.numSingleVesion + height1 + 20, WIDTH_CONTENTVIEW - 16 * self.numSingleVesion, 100 * self.numSingleVesion)];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:13];
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    [_textView setPlaceholderColor:[UIColor colorWithRed:205/255.0 green:205/255.0 blue:210/255.0 alpha:1]];
    [self.view addSubview:_textView];
    [self.textView setPlaceholder:@" 请输入将要跳转的网址 例如:https://www.baidu.com/"];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(8 * self.numSingleVesion, (20 + 20 + 100) * self.numSingleVesion + height1, WIDTH_CONTENTVIEW - 16 * self.numSingleVesion, 20 * self.numSingleVesion)];
    lab1.text = @" 给网址添加一个图片:";
    lab1.font = [UIFont systemFontOfSize:13];
    lab1.textColor = [UIColor lightGrayColor];
    [self.view addSubview:lab1];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, (18 + 40 + 100) * self.numSingleVesion + height1, (screenWidth - 5*padding)/4, (screenWidth - 5*padding)/4)];
    [self.view addSubview:view];
    self.photoView = view;
    self.photoView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    
    [self initHeaderView1];
    
}

//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    if(textView.text.length < 1){
//        textView.text = @"我是placeholder";
//        textView.textColor = [UIColor grayColor];
//    }
//}
//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    if([textView.text isEqualToString:@"我是placeholder"]){
//        textView.text=@"";
//        textView.textColor=[UIColor blackColor];
//    }
//}


#define pictureHW (screenWidth - 5*padding)/4
#define MaxImageCount 9
#define deleImageWH 25 // 删除按钮的宽高
-(void)initHeaderView
{
    [self.photoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //    UIView *headView = [[UIView alloc]initWithFrame:CGRectZero];
    NSLog(@"%lu",(unsigned long)self.imagePickerArray.count);
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
    
//    self.photoHeight.constant = 10+ (10 + pictureHW)*([self.imagePickerArray count]/4 + 1 );
    
}


-(void)initHeaderView1
{
    [self.photoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //    UIView *headView = [[UIView alloc]initWithFrame:CGRectZero];
    UIButton *addPictureButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, pictureHW, pictureHW)];
    [addPictureButton setBackgroundImage:[UIImage imageNamed:@"add_photo.png"] forState:UIControlStateNormal];
    [addPictureButton addTarget:self action:@selector(addPicture) forControlEvents:UIControlEventTouchUpInside];
    [self.photoView addSubview:addPictureButton];
    self.addPictureButton = addPictureButton;
    NSInteger imageCount = [self.imagePickerArray count];
    for (NSInteger i = 0; i < imageCount; i++) {
        UIImageView *pictureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0 + (i%4)*(pictureHW+0),0 +(i/4)*(pictureHW+0), pictureHW, pictureHW)];
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
    //    if (imageCount < MaxImageCount) {

    //    }
    
    //    self.photoHeight.constant = 10+ (10 + pictureHW)*([self.imagePickerArray count]/4 + 1 );
    
}

-(void)addPicture{
         [self.titleTextF resignFirstResponder];
    [self.textView resignFirstResponder];
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
    if ([self.tag isEqualToString:@"1"]) {
        [self initHeaderView];

    }else if ([self.tag isEqualToString:@"2"]){
        [self initHeaderView1];

    }
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
            if ([self.tag isEqualToString:@"1"]) {
                [self initHeaderView];
                
            }else if ([self.tag isEqualToString:@"2"]){
                [self initHeaderView1];
                
            }
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        }];
        if ([self.tag isEqualToString:@"1"]) {
            self.imagePicker.maximumNumberOfPhotosToBeSelected = 9 - [self.imagePickerArray count];
        }else if ([self.tag isEqualToString:@"2"]){
            self.imagePicker.maximumNumberOfPhotosToBeSelected = 1 - [self.imagePickerArray count];
        }
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
    if ([self.tag isEqualToString:@"1"]) {
        [self initHeaderView];
        
    }else if ([self.tag isEqualToString:@"2"]){
        [self initHeaderView1];
        
    }
    
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
