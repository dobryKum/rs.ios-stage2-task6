//
//  TabBarController.m
//  Task6
//
//  Created by Tsimafei Zykau on 6/24/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import "TabBarController.h"
#import "UIColor+Hex.h"

@interface TabBarController ()

@property (nonatomic, strong) UINavigationController *infoNavigationController;
@property (nonatomic, strong) UINavigationController *galleryNavigationController;
@property (nonatomic, strong) UINavigationController *homeNavigationController;

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupBarItems];
}

- (void)setupBarItems {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
 
    self.tabBar.tintColor = [UIColor colorFromHexNumber:@0x101010];
    self.tabBar.itemPositioning = UITabBarItemPositioningFill;
    
    UITabBarItem *infoTabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                                 image:[UIImage imageNamed:@"info_unselected"]
                                                                   tag:0];
    infoTabBarItem.selectedImage = [UIImage imageNamed:@"info_selected"];
    self.viewControllers[0].tabBarItem = infoTabBarItem;
    UITabBarItem *galleryTabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                                    image:[UIImage imageNamed:@"gallery_unselected"]
                                                                      tag:1];
    galleryTabBarItem.selectedImage = [UIImage imageNamed:@"gallery_selected"];
    self.viewControllers[1].tabBarItem = galleryTabBarItem;
    UITabBarItem *homeTabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                                 image:[UIImage imageNamed:@"home_unselected"]
                                                                   tag:2];
    homeTabBarItem.selectedImage = [UIImage imageNamed:@"home_selected"];
    self.viewControllers[2].tabBarItem = homeTabBarItem;
    
    [self setSelectedIndex:1];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
