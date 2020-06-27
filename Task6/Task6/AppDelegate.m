//
//  AppDelegate.m
//  Task6
//
//  Created by Tsimafei Zykau on 6/21/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import "AppDelegate.h"
#import "StartupViewController.h"
#import "NavigationController.h"
#import "InfoViewController.h"
#import "GalleryViewController.h"
#import "HomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(switchController:) name:@"startButtonTapped" object:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:[StartupViewController new]];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)switchController:(NSNotification *)notification {
    self.tabBarController = [TabBarController new];
    
    InfoViewController *infoViewController = [InfoViewController new];
    NavigationController *infoNavigationController = [[NavigationController alloc] initWithRootViewController:infoViewController];
    infoNavigationController.navigationBar.topItem.title = @"Info";
    GalleryViewController *galleryViewController = [[GalleryViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    NavigationController *galleryNavigationController = [[NavigationController alloc] initWithRootViewController:galleryViewController];
    galleryNavigationController.navigationBar.topItem.title = @"Gallery";
    HomeViewController *homeViewController = [HomeViewController new];
    NavigationController *homeNavigationController = [[NavigationController alloc] initWithRootViewController:homeViewController];
    homeNavigationController.navigationBar.topItem.title = @"RSSchool Task 6";
    
    NSArray *tabBarControllersArray = [[NSArray alloc] initWithObjects:infoNavigationController, galleryNavigationController, homeNavigationController, nil];
    self.tabBarController.viewControllers = tabBarControllersArray;
    
    
    [self.window setRootViewController: self.tabBarController];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

@end
