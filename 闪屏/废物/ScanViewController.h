//
//  ScanViewController.h
//  TicketSuper
//
//  Created by 邱读书 on 15/11/11.
//  Copyright © 2015年 FanKing. All rights reserved.
//

#import "BaseViewController.h"

@interface ScanViewController : BaseViewController
{
    UIWebView *mainWebView;
}
@property (nonatomic,strong) NSString *mScanUrl;
@end
