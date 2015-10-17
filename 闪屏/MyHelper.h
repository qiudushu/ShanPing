//
//  MyHelper.h
//  思无邪
//
//  Created by guo on 15/9/18.
//  Copyright (c) 2015年 qiudushu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Common.h"

@interface MyHelper : NSObject

/**
 * 功能描述: 判断字符串是否为空
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (BOOL)isEmpty:(NSString*)string;

/**
 *  红线
 */
+ (UIView *)getLineView;

/**
 * 功能描述: 十六进制转换成color
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (UIColor *)colorWithHexString: (NSString *)iStringToConvert;

/**
 * 功能描述: 返回一个UIScrollView属性自带需要改自行修改
 * 输入参数: nil
 * 返 回 值: UIScrollView
 */
+ (UIScrollView*)getScrollView;

/**
 * 功能描述: 获取程序版本号
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (NSString *)getVersion;

/**
 * 功能描述: 判断网络状况
 * 输入参数: N/A
 * 输出参数: N/A
 * 返 回 值: YES-网络连接正常，NO-无网络
 */
+ (BOOL)connectedToNetwork;

/**
 * 功能描述: 清除ios7或以上TableView多余线条
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (void)setExtraCellLineHidden: (UITableView *)iTableView;

/**
 * 功能描述: 清除ios7或以上 cell 向右多20像素
 * 输入参数: N/A
 * 返 回 值: N/A    效果不明显
 */
+ (void)setExtraCellPixelExcursion :(UITableView*)iTableView;

/**
 * 功能描述: 高斯白边模糊效果
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+(UIImage *)trainBackImg:(NSString *)imgName;

/**
 * 功能描述: // 验证手机号是否合法
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

// 注册邮箱格式是否正确
+ (BOOL)emailIsLegal:(NSString *)email;

//为按钮添加边框
+ (void)addBorderToButton:(UIButton *)btn
              BorderColor:(UIColor *)borderColor
              borderWidth:(CGFloat)borderWidth
             cornerRadius:(CGFloat)corneerRadius;
@end
