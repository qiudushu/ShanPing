//
//  SecondViewController.m
//  思无邪
//
//  Created by guo on 15/9/16.
//  Copyright (c) 2015年 qiudushu. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
{
//    MLEmojiLabel *mEmoji;
}

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(sendContent:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"网页" style:UIBarButtonItemStyleDone target:self action:@selector(webAction:)];
    
//    mEmoji = [[MLEmojiLabel alloc]initWithFrame:CGRectMake(0, 400, kWidth, 50)];
//    mEmoji.backgroundColor = [UIColor grayColor];
//    mEmoji.delegate = self;
//    mEmoji.backgroundColor = [UIColor clearColor];
//    mEmoji.numberOfLines = 0;
//    mEmoji.isNeedAtAndPoundSign = YES;
//    mEmoji.disableThreeCommon = YES;
//    mEmoji.disableEmoji = YES;
//    mEmoji.textColor = [MyHelper colorWithHexString:@"#444444"];
//    [self.view addSubview:mEmoji];
    
}
/*
 *  webAction
 */
- (void)webAction:(UIBarButtonItem *)sender
{
}

/**
 *  发布
 */
- (void)sendContent:(UIBarButtonItem *)sender
{
//    SendContentViewController *mSend = [[SendContentViewController alloc]init];
//    
//    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:mSend];
//    [self presentViewController:nv animated:YES completion:nil];
}
/**
 *  <#Description#>
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
//    NSUserDefaults *mDef = [NSUserDefaults standardUserDefaults];
//    [mDef synchronize];
//    self.ExamLable.text = [mDef valueForKey:@"SEND_VALUE"];
//    mEmoji.text = [mDef valueForKey:@"SEND_VALUE"];
}

//- (void)mlEmojiLabel:(MLEmojiLabel *)emojiLabel didSelectLink:(NSString *)link withType:(MLEmojiLabelLinkType)type
//{
//    NSLog(@"------%@",emojiLabel.text);
//}
@end
