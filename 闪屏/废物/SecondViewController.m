//
//  SecondViewController.m
//  思无邪
//
//  Created by guo on 15/9/16.
//  Copyright (c) 2015年 qiudushu. All rights reserved.
//

#import "SecondViewController.h"
#import <Masonry.h>

@interface SecondViewController ()<UIWebViewDelegate>
{
//    MLEmojiLabel *mEmoji;
}

@property (nonatomic,weak) UIWebView *mainWebView;

@end

@implementation SecondViewController

- (void)setupWebView{
    //
    NSString *urlStr = @"http://m.lottery.gov.cn";
    UIWebView *mainWebView = [[UIWebView alloc]init];
    self.mainWebView = mainWebView;
    mainWebView.delegate = self;
    [self.view addSubview:mainWebView];
    [mainWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-44);
    }];
    
    [mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];

}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"111111");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"2222");
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"前一页" style:UIBarButtonItemStyleDone target:self action:@selector(sendContent:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一页" style:UIBarButtonItemStyleDone target:self action:@selector(webAction:)];
    
    [self setupWebView];
    
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
    //https://live.500.com
    NSString *urlStr = @"https://live.500.com";
    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
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
    
    NSString *urlStr = @"http://quote.eastmoney.com/zs000001.html?from=BaiduAladdin";
    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];

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
