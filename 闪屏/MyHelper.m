//
//  MyHelper.m
//  思无邪
//
//  Created by guo on 15/9/18.
//  Copyright (c) 2015年 qiudushu. All rights reserved.
//

#import "MyHelper.h"
#import <SystemConfiguration/SystemConfiguration.h>
#include <netdb.h>

@implementation MyHelper


+ (BOOL)isEmpty:(NSString*)string
{
    if (string == nil)
    {
        return YES;
    }
    else if (string == NULL)
    {
        return YES;
    }
    else if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if ([string  isEqualToString:@""])
    {
        return YES;
    }
    else if([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        return YES;
    }
    else if ([string isEqualToString:@"<null>"]
             || [string isEqualToString:@"null"]
             || [string isEqualToString:@"(null)"]
             ||[string isEqualToString:@"NULL"]
             || [string isEqualToString:@"<NULL>"]
             || [string isEqualToString:@"(NULL)"])
    {
        return YES;
    }
    return NO;
}

/**
 *  获取红线
 *
 *  @return View
 */
+ (UIView *)getLineView{
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, 0, kWidth, 1.0f);
    lineView.backgroundColor = [UIColor redColor];
    return lineView;
}

/**
 * 功能描述: 十六进制转换成color
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (UIColor *)colorWithHexString: (NSString *)iStringToConvert
{
    NSString *cString = [[iStringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor yellowColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


/**
 * 功能描述: 返回一个UIScrollView属性自带需要改自行修改
 * 输入参数: nil
 * 返 回 值: UIScrollView
 */
+ (UIScrollView*)getScrollView
{
    UIScrollView *scr_Main = [[UIScrollView alloc]init];
    scr_Main.backgroundColor = [MyHelper colorWithHexString:@"#eeeeeb"];
    scr_Main.bounces = YES;
    scr_Main.pagingEnabled = YES;
    scr_Main.clipsToBounds = YES;
    scr_Main.showsHorizontalScrollIndicator = NO;
    scr_Main.showsVerticalScrollIndicator = NO;
    scr_Main.scrollsToTop = NO;
    return scr_Main;
}

/**
 * 功能描述: 获取程序版本号
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (NSString *)getVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    NSString *oAppVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return oAppVersion;
}

/**
 * 功能描述: 判断网络状况
 * 输入参数: N/A
 * 输出参数: N/A
 * 返 回 值: YES-网络连接正常，NO-无网络
 */
+ (BOOL)connectedToNetwork
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        NSLog(@"连不上网");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

/**
 * 功能描述: 清除ios7或以上TableView多余线条
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (void)setExtraCellLineHidden: (UITableView *)iTableView;
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [iTableView setTableFooterView:view];
}

/**
* 功能描述: 清除ios7或以上 cell 向右多20像素
* 输入参数: N/A
* 返 回 值: N/A
*/
+ (void)setExtraCellPixelExcursion :(UITableView*)iTableView
{
    if([iTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [iTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([iTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [iTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

/**
 * 功能描述: 高斯白边模糊效果
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+(UIImage *)trainBackImg:(NSString *)imgName{
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *inputImage = [[CIImage alloc]initWithImage:[UIImage imageNamed:imgName]];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:10.0] forKey:@"inputRadius"];
    // blur image
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}

/**
 * 功能描述: // 验证手机号是否合法
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:mobileNum]) {
        return YES;
    }
    return NO;
}

// 注册邮箱格式是否正确
+ (BOOL)emailIsLegal:(NSString *)email
{
    
    NSString *Regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    BOOL bEmail = [emailCheck evaluateWithObject:email];
    return bEmail;
}

//为按钮添加边框
+ (void)addBorderToButton:(UIButton *)btn
              BorderColor:(UIColor *)borderColor
              borderWidth:(CGFloat)borderWidth
             cornerRadius:(CGFloat)corneerRadius
{
    btn.layer.borderColor = borderColor.CGColor;
    btn.layer.borderWidth = borderWidth;
    btn.layer.cornerRadius = corneerRadius;
    btn.layer.masksToBounds = YES;
}

@end
