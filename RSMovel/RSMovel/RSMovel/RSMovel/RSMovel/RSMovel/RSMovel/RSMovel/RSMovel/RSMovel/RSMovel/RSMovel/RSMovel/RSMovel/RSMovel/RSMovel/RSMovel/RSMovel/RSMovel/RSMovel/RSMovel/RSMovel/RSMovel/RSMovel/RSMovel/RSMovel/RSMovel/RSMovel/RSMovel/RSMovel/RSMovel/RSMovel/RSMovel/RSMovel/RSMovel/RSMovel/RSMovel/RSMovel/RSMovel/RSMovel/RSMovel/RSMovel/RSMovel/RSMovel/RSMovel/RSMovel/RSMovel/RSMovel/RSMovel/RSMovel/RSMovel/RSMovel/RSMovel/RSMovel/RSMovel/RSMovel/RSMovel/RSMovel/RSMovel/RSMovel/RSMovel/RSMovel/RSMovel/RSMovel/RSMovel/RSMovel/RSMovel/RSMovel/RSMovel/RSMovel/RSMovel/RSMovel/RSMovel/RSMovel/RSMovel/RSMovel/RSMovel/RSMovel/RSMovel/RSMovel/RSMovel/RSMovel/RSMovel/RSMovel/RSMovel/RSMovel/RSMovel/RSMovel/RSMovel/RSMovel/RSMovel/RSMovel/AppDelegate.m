//
//  AppDelegate.m
//  RSMovel
//
//  Created by Marcelo Alves Rezende on 30/09/13.
//  Copyright (c) 2013 Marcelo Alves Rezende. All rights reserved.
//

#import "AppDelegate.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	
	[[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x35913D)];
	[[UINavigationBar appearance] setTintColor:UIColorFromRGB(0xFFFFFF)];
	
	[[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:19.0], NSFontAttributeName, nil]];
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];

}

- (void)applicationWillTerminate:(UIApplication *)application
{
}


@end
