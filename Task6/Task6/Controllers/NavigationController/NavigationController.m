//
//  NavigationController.m
//  Task6
//
//  Created by Tsimafei Zykau on 6/25/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import "NavigationController.h"
#import "UIColor+Hex.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBarTintColor:[UIColor colorFromHexNumber:@0xF9CC78]];
    [self.navigationBar setTintColor:[UIColor colorFromHexNumber:@0x101010]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
        NSForegroundColorAttributeName:[UIColor colorFromHexNumber:@0x101010],
        NSFontAttributeName:[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]
    }];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
