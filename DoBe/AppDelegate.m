//
//  AppDelegate.m
//  DoBe
//
//  Created by liuxuan on 15/6/1.
//  Copyright (c) 2015年 liuxuan. All rights reserved.
//

#import "AppDelegate.h"
#import "DBMainController.h"
#import "DBHomeController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    DBMainController *main_vc = [[DBMainController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:main_vc];
    [nav.navigationBar setTranslucent:YES];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    UIImage *bgImage = [UIImage imageNamed:@"my_buttonbg"]; //328*40  194*120
    [nav.navigationBar setBackgroundImage:[bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(20.0f, 20.0f, 19.0f, 307.0f) resizingMode:UIImageResizingModeStretch]forBarMetrics:UIBarMetricsDefault];
    [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    
    
    DBUser *userInfo = [DBUser sharedInstance];
    userInfo.name = @"MIMO";
    userInfo.signature = @"这家伙很懒什么也没留下";
    userInfo.headImage = @"my_headImage";
    
    userInfo.cellphone = @"13954009794";
    userInfo.email = @"13954009794@139.com";
    userInfo.city = @"北京";
    userInfo.address = @"海淀区北四环中关村大街66号";
    userInfo.tags = @[@"宅男",@"技术控",@"驴友",@"程序猿"];
    
    userInfo.focusCount = @"10";
    userInfo.fans = @"20";
    userInfo.doCion = @"1000";
    
    /*
    DBHomeController *homeVC = [[DBHomeController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    [self.window setRootViewController:nav];*/

    return YES;
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
