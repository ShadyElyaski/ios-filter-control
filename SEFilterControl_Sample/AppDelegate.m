//
//  AppDelegate.m
//  SEFilterControl_Sample
//
//  Created by Shady A. Elyaski on 6/15/12.
//  Copyright (c) 2012 Shady Elyaski. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate
#pragma mark - Aplication lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    [self.window makeKeyAndVisible];

    return YES;
}
@end
