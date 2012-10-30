//
//  AppDelegate.m
//  NavBar
//
//  Created by Stas-PC on 08.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"

#import "SecondViewController.h"

#import "ThirdViewController.h"

#import "FourViewController.h"

#import "GroupMy.h"

@implementation AppDelegate

@synthesize tabBarController = _tabBarController;
@synthesize window = _window;
//@synthesize navController = _navController;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1, *viewController2;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPhone" bundle:nil];
        viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController_iPhone" bundle:nil];
    }
    
    ThirdViewController * viewController3 = [[ThirdViewController alloc] initWithNibName:@"ThirdViewController" bundle:nil];
    FourViewController  * viewController4 = [[FourViewController alloc] initWithNibName:@"FourViewController" bundle:nil];
    
    //Create our NavigationControllerObject
    UINavigationController * nav1 = [[UINavigationController alloc]
                                    initWithRootViewController:viewController1];
    UINavigationController * nav2 = [[UINavigationController alloc]
                                    initWithRootViewController:viewController2];
    UINavigationController * nav3 = [[UINavigationController alloc]
                                    initWithRootViewController:viewController3];
    UINavigationController * nav4 = [[UINavigationController alloc]
                                     initWithRootViewController:viewController4];
    
    UIImage *img = [ UIImage imageNamed:@"second.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    imgView.image = img;
    [self.window addSubview:imgView];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[nav2, nav1, nav3, nav4];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
   /* NSArray *listContent1 = [[NSArray alloc] initWithObjects:[GroupMy productWithType:@"iOS" name:@"IPhone"],
                        [GroupMy productWithType:@"iOS" name:@"IPhone"],
                        [GroupMy productWithType:@"iOS" name:@"IPhone 4S"],
                        [GroupMy productWithType:@"iOS" name:@"iPad"],
                        [GroupMy productWithType:@"iOS" name:@"iPod Touch"],
                        [GroupMy productWithType:@"iOS" name:@"IPhone 4"],
                        [GroupMy productWithType:@"iOS" name:@"IPhone 3"],
                        [GroupMy productWithType:@"iOS" name:@"IPhone 5"],
                        [GroupMy productWithType:@"Andriod" name:@"Samsung Galaxy Y"],
                        [GroupMy productWithType:@"Andriod" name:@"Samsung Galaxy S2"],
                        [GroupMy productWithType:@"Andriod" name:@"Samsung Galaxy Note"],
                        [GroupMy productWithType:@"Andriod" name:@"Motorola RAZR"],
                        [GroupMy productWithType:@"Andriod" name:@"Acer Liquid E"],
                        [GroupMy productWithType:@"Windows 7" name:@"Nokia Lumia 800"],nil];

    
    
    viewController3.listContent = listContent1;*/
    

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
