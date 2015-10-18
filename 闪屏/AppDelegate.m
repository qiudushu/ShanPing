//
//  AppDelegate.m
//  闪屏
//
//  Created by 邱读书 on 15/10/17.
//  Copyright © 2015年 邱读书. All rights reserved.
//

#import "AppDelegate.h"
#import "SwitchViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[SwitchViewController alloc] init];
//    self.window.rootViewController.view.alpha = 0;
//    UIImageView *splashImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpg"]];
//    [self.window addSubview:splashImageView];
//    
//    UIButton *mBtn = [[UIButton alloc]init];
//    mBtn.frame = CGRectMake(100, 100, 100, 100);
//    mBtn.backgroundColor = [UIColor redColor];
//    [mBtn addTarget:self action:@selector(gotoNext) forControlEvents:UIControlEventTouchUpInside];
//    [self.window addSubview:mBtn];
//    
//    [UIView animateWithDuration:3.7 animations:^{
////        self.window.rootViewController.view.alpha = 1.0;
//    } completion:^(BOOL finished) {
////        [splashImageView removeFromSuperview];
//    }];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)gotoNext
{
    NSLog(@"进入tabBar");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
