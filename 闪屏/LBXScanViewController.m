//
//
//  LBXScanDemo
//
//  Created by lbxia on 15/10/21.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "LBXScanViewController.h"
#import "ScanViewController.h"

@interface LBXScanViewController ()
@end
@implementation LBXScanViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"扫描";
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor blackColor];
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self drawScanView];
    
    if (_isQQSimulator) {
        
         [self drawBottomItems];
         [self.view bringSubviewToFront:_topTitle];
    }
    else
        _topTitle.hidden = YES;
    [self performSelector:@selector(startScan) withObject:nil afterDelay:0.2];
}
//绘制扫描区域
- (void)drawScanView
{
    if (!_qRScanView)
    {
        CGRect rect = self.view.frame;
        rect.origin = CGPointMake(0, 0);
        
        self.qRScanView = [[LBXScanView alloc]initWithFrame:rect style:_style];
        [self.view addSubview:_qRScanView];
        
        self.topTitle = [[UILabel alloc]init];
        _topTitle.bounds = CGRectMake(0, 0, 145, 60);
        _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 50);
        
        //3.5inch iphone
        if ([UIScreen mainScreen].bounds.size.height <= 568 )
        {
            _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 38);
            _topTitle.font = [UIFont systemFontOfSize:14];
        }
        _topTitle.textAlignment = NSTextAlignmentCenter;
        _topTitle.numberOfLines = 0;
        _topTitle.text = @"将取景框对准二维码即可自动扫描";
        _topTitle.textColor = [UIColor whiteColor];
        [self.view addSubview:_topTitle];
    }
    [_qRScanView startDeviceReadyingWithText:@"相机启动中"];
}
- (void)drawBottomItems
{
    if (_bottomItemsView)
    {
        return;
    }
    self.bottomItemsView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-164,
                                                                      CGRectGetWidth(self.view.frame), 100)];
    _bottomItemsView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [self.view addSubview:_bottomItemsView];
    CGSize size = CGSizeMake(65, 87);
    self.btnFlash = [[UIButton alloc]init];
    _btnFlash.bounds = CGRectMake(0, 0, size.width, size.height);
    _btnFlash.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame)/3, CGRectGetHeight(_bottomItemsView.frame)/2);
     [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    [_btnFlash addTarget:self action:@selector(openOrCloseFlash) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnPhoto = [[UIButton alloc]init];
    _btnPhoto.bounds = _btnFlash.bounds;
    _btnPhoto.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame)*2/3, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnPhoto setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_photo_nor"] forState:UIControlStateNormal];
    [_btnPhoto setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_photo_down"] forState:UIControlStateHighlighted];
    [_btnPhoto addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomItemsView addSubview:_btnFlash];
    [_bottomItemsView addSubview:_btnPhoto];
}

//启动设备
- (void)startScan
{
    if ( ![LBXScanWrapper isGetCameraPermission] )
    {
        [_qRScanView stopDeviceReadying];
        //        [self showHUDMessage:@"请到设置隐私中开启本程序相机权限"];
        UIAlertView *mAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请到设置隐私中开启本程序相机权限" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [mAlert show];
        [self.view addSubview:mAlert];
        return;
    }
    
    if (!_scanObj )
    {
        __weak __typeof(self) weakSelf = self;
         // AVMetadataObjectTypeQRCode   AVMetadataObjectTypeEAN13Code
        
        CGRect cropRect = CGRectZero;
        
        if (_isOpenInterestRect) {
            
            cropRect = [LBXScanView getScanRectWithPreView:self.view style:_style];
        }

        self.scanObj = [[LBXScanWrapper alloc]initWithPreView:self.view
                                              ArrayObjectType:nil
                                                     cropRect:cropRect
                                                      success:^(NSArray<LBXScanResult *> *array){
                                                          [weakSelf scanResultWithArray:array];
                                                      }];
      
    }
    [_scanObj startScan];


    [_qRScanView stopDeviceReadying];
    
    [_qRScanView startScanAnimation];
    
    self.view.backgroundColor = [UIColor clearColor];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [_scanObj stopScan];
    [_qRScanView stopScanAnimation];
}

- (void)showError:(NSString*)str
{
//    [LBXAlertAction showAlertWithTitle:@"提示" msg:str chooseBlock:nil buttonsStatement:@"知道了",nil];
}

- (void)openLocalPhotoAlbum
{
    if ([LBXScanWrapper isGetPhotoPermission])
    {
        [self openLocalPhoto];
    }
    else
        [self showError:@"      请到设置->隐私中开启本程序相册权限     "];
}

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    
    if (array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        return;
    }
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
    for (LBXScanResult *result in array) {
        
        NSLog(@"scanResult:%@",result.strScanned);
    }

    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //震动提醒
    [LBXScanWrapper systemVibrate];
    //声音提醒
    [LBXScanWrapper systemSound];
    
    
    //[self popAlertMsgWithScanResult:strResult];
    
    [self showNextVCWithScanResult:scanResult];
   
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult)
    {
        
        strResult = @"识别失败";
    }
    
//    __weak __typeof(self) weakSelf = self;
//    [LBXAlertAction showAlertWithTitle:@"扫码内容" msg:strResult chooseBlock:^(NSInteger buttonIdx) {
//        
//        //点击完，继续扫码
//        [weakSelf.scanObj startScan];
//    } buttonsStatement:@"知道了",nil];
}

- (void)showNextVCWithScanResult:(LBXScanResult*)strResult
{
    ScanViewController *vc = [[ScanViewController alloc]init];
    vc.mScanUrl = strResult.strScanned;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -底部功能项
//打开相册
- (void)openPhoto
{
    [self openLocalPhoto];
}

//开关闪光灯
- (void)openOrCloseFlash
{
    [_scanObj openOrCloseFlash];
    
    self.isOpenFlash =!self.isOpenFlash;
    
    if (self.isOpenFlash)
    {
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_down"] forState:UIControlStateNormal];
    }
    else
    [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
}

#pragma mark --打开相册并识别图片
+ (UIViewController*)getWindowTopViewController
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

/*!
 *  打开本地照片，选择图片识别
 */
- (void)openLocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}
//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    __block UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image)
    {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    __weak __typeof(self) weakSelf = self;
    [LBXScanWrapper recognizeImage:image success:^(NSArray<LBXScanResult *> *array)
    {
        [weakSelf scanResultWithArray:array];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel");
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
