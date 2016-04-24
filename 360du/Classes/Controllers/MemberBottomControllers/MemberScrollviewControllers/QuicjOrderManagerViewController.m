//
//  QuicjOrderManagerViewController.m
//  360du
//
//  Created by linghang on 15/8/15.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "QuicjOrderManagerViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/NSAttributedString.h>
#import <UIKit/UIKitDefines.h>
#import "AFHTTPRequestOperationManager.h"
#import "TranlateTime.h"
#import "StoreageMessage.h"
#import "FileOperation.h"
#import "UIView+Toast.h"
@interface QuicjOrderManagerViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>{
    AFHTTPRequestOperationManager *_rom;
}
@property(nonatomic,weak)UITextField *textField;
@property(nonatomic,weak)UIView *photoView;
@property(nonatomic,copy)UIImage *image;
@property(nonatomic,strong)UIImageView *photoImgView;
@property(nonatomic,copy)NSString *fileNamePath;
@property(nonatomic,copy)NSString *fileImgName;
@end

@implementation QuicjOrderManagerViewController
- (id)init{
    self = [super init];
    if (self) {
        [self makeNav];
        [self makeUI];
    }
    return self;
}
- (void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:@"申请成为快递员"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)makeUI{
    [self writeIdentificationCard];
    [self takePhoto];
    [self applyCommit];
}
//身份证
- (void)writeIdentificationCard{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20 * self.numSingleVesion, 20 * self.numSingleVesion + 64, WIDTH_CONTROLLER - 40 * self.numSingleVesion, 30 * self.numSingleVesion)];
    textField.placeholder = @"身份证号:";
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textField];
    self.textField = textField;
    textField.keyboardType = UIKeyboardTypeNumberPad;
}
//照片
-(void)takePhoto{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20 * self.numSingleVesion, 70 * self.numSingleVesion + 64 , WIDTH_CONTROLLER - 40 * self.numSingleVesion, 160 * self.numSingleVesion)];
    [self.view addSubview:view];
    self.photoView = view;
    view.layer.borderColor = [SMSColor(151, 151, 151) CGColor];
    view.layer.borderWidth = 1 * self.numSingleVesion;
    
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.font = [UIFont systemFontOfSize:16];
    lable.textColor = [UIColor redColor];
    [view addSubview:lable];
    lable.text = @"个人正面手持身份证照片";
    [lable sizeToFit];
    lable.center = CGPointMake(WIDTH_CONTROLLER / 2, view.frame.size.height / 2);
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBtn.frame = view.bounds;
    [photoBtn setTitle:@"" forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(photoBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:photoBtn];
}
- (void)photoBtn{
    [self.textField resignFirstResponder];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机", nil];
    [actionSheet showInView:self.view];
}
//提交申请
- (void)applyCommit{
    UIButton *applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    applyBtn.frame = CGRectMake(20 * self.numSingleVesion, 250 * self.numSingleVesion + 64, WIDTH_CONTROLLER - 40 * self.numSingleVesion, 30 * self.numSingleVesion);
    [applyBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [applyBtn setBackgroundColor:[UIColor redColor]];
    applyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:applyBtn];
    [applyBtn addTarget:self action:@selector(applyBtnDown:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)applyBtnDown:(UIButton *)applyBtn{

    if(![self validateIdentityCard:self.textField.text]){
        [self.view makeToast:@"请输入正确的身份证号"];
        return;
    }
        [self makeHUd];
    if (self.image == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请上传身份证照片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
        return;
      
    }
    //申请快厨
    [self requestApplyInterface];
}
#pragma mark actionSheet
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //相机：1
    //相册：0
    if(buttonIndex != 2){
        UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
        imagePicker.delegate=self;
        if (buttonIndex == 0) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        else{
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        
        
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
    }
}
#pragma mark 相机的代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        self.image = image;
        NSMutableString *fileNameImg = [NSMutableString stringWithCapacity:0] ;
        [fileNameImg appendString:@"temp"];
        
        //效果
        
        //判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(image)) {
            [fileNameImg appendString:@".png"];
        }else {
            [fileNameImg appendString:@".jpg"];
        }
#warning message cachePath
        //NSLog(@"%@",self.cachePath);
        self.fileImgName = fileNameImg;
        NSString *fileNameImgPth = [NSString stringWithFormat:@"%@%@",  NSTemporaryDirectory(),fileNameImg];
        self.fileNamePath = fileNameImgPth;
        //        NSFileManager *manager = [NSFileManager defaultManager];
        //        BOOL fileExits = [manager createFileAtPath:[NSString stringWithFormat:@"%@/%@",self.cachePath,fileNameImg] contents:nil attributes:nil];
        //        if (!fileExits) {
        //            NSLog(@"failer");
        //        }
        //        else{
        //            fileNameImgPth = [NSString stringWithFormat:@"%@/%@",self.cachePath,fileNameImg];
        //            NSLog(@"successs");
        //        }
        //        [UIImagePNGRepresentation(<#UIImage *image#>)]
        //        [UIImageJPEGRepresentation(image, 0.4)]
        if (UIImagePNGRepresentation(image)) {
            //            HEIGHT_CONTROLLER / WIDTH_CONTROLLER *
            //缩小
            UIImage *pngImg = [self imageWithImageSimple:image scaledToSize:CGSizeMake(200 * self.numSingleVesion,  300 * self.numSingleVesion)];
            
            [UIImagePNGRepresentation(pngImg) writeToFile:fileNameImgPth atomically:YES];
//            [UIImagePNGRepresentation(image) writeToFile:fileNameImgPth atomically:YES];
        }else{
            [UIImageJPEGRepresentation(image, 0.1) writeToFile:fileNameImgPth atomically:YES];
        }
    }
    [self dismissViewControllerAnimated:YES completion:^{
        [self clearPhotoImage];
        [self makePhotoIamge];
    }];
    //[self dismissViewControllerAnimated:YES completion:nil];
}
//压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
#pragma mark iamge
- (void)makePhotoIamge{
    //[self OriginImage:self.image scaleToSize:self.photoView.frame.size]
    self.photoImgView = [[UIImageView alloc] initWithFrame:[self OriginImage:self.image scaleToSize:self.photoView.frame.size]];
    self.photoImgView.image = self.image;
    /**
     *  <#Description#>
     *
     *  @param self.numSingleVesion <#self.numSingleVesion description#>
     *  @param self.numSingleVesion <#self.numSingleVesion description#>
     *
     *  @return <#return value description#>
     */
    //self.photoImgView.clipsToBounds = YES;
//    self.image.size = CGSizeMake(WIDTH_CONTROLLER - 40 * self.numSingleVesion, 50 * self.numSingleVesion);
    [self.photoView addSubview:self.photoImgView];
}
- (void)clearPhotoImage{
    [self.photoImgView removeFromSuperview];
    self.photoImgView = nil;
}
- (UIImage *)normalizedImage {
    //if (self.imageOrientation == UIImageOrientationUp) return self;
    
//    UIGraphicsBeginImageContextWithOptions(self.image.size, NO, self.image.scale);
//    [self drawInRect:(CGRect){0, 0, self.image.size}];
//    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return normalizedImage;
    return nil;
}
//身份证验证
- (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
//快递掌柜申请接口
- (void)requestApplyInterface{
   // [self makeHUd];

    _rom = [AFHTTPRequestOperationManager manager];
    _rom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",nil];
    _rom.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    _rom.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    NSString *imageName = nil;
    NSData *imageData = nil;
    NSString *typeStr = nil;
    if (UIImagePNGRepresentation(self.image)) {
        imageName = [NSString stringWithFormat:@"%@.png",[TranlateTime gainTimeStamp]];
        imageData = UIImagePNGRepresentation(self.image);
        typeStr = @"type/png";
    }else {
        imageName = [NSString stringWithFormat:@"%@.jpg",[TranlateTime gainTimeStamp]];
        imageData = UIImageJPEGRepresentation(self.image, 1);
        typeStr = @"type/jpg";
    }
    //NSData *data = [NSData ]
    NSDictionary *dict = @{@"memberId":[StoreageMessage getMessage][2],@"sfzCode":self.textField.text,@"name":@"file"};
    [_rom POST:ORDERMANGERAPPLYINTERFACE parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        /**
         *  appendPartWithFileURL   //  指定上传的文件
         *  name                    //  指定在服务器中获取对应文件或文本时的key
         *  fileName                //  指定上传文件的原始文件名
         *  mimeType                //  指定商家文件的MIME类型
         */
        NSString *tempPng = nil;
        if ([self.fileImgName hasSuffix:@"png"]) {
            tempPng = @"image/png";
        }else{
            tempPng = @"image/jpg";

        }
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:self.fileNamePath] name:@"file" fileName:self.fileImgName mimeType:tempPng error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self hudWasHidden:self.hudProgress];
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *finalDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString *message = [finalDict objectForKey:@"message"];
        if ([finalDict[@"code"] isEqual:@"000000"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
        }
        if (!message) {
            [self.view makeToast:@"上传失败,请重新上传!"];
        }else{
            [self.view makeToast:message];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self hudWasHidden:self.hudProgress];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络不流畅，请换个网络重新试试!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alertView show];
        return ;

    }];
    
    
}
- (CGRect) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    CGSize newSize;
    if (image.size.height / image.size.width > 1){
        newSize.height = size.height;
        newSize.width = size.height / image.size.height * image.size.width;
    } else if (image.size.height / image.size.width < 1){
        newSize.height = size.width / image.size.width * image.size.height;
        newSize.width = size.width;
    } else {
        newSize = size;
    }
    return CGRectMake(0, 0, size.width, size.height);
}
- (void)viewWillDisappear:(BOOL)animated{
    [FileOperation clearFile:self.fileImgName andPath:NSTemporaryDirectory()];

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
