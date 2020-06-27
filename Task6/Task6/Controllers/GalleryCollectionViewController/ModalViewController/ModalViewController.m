//
//  ModalViewController.m
//  Task6
//
//  Created by Tsimafei Zykau on 6/27/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import "ModalViewController.h"
#import <Photos/Photos.h>
#import "UIColor+Hex.h"

@interface ModalViewController ()

@property (nonatomic, strong) UIImageView* picture;

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexNumber:@0xFFFFFF];
    self.picture = [UIImageView new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[PHImageManager defaultManager] requestImageForAsset:self.photoAsset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if ([[info valueForKey:PHImageResultIsDegradedKey] intValue]) {
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.picture.image = result;
                [self.picture setNeedsLayout];
                [self.picture layoutIfNeeded];
            });
        }];
    });
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGFloat aspectRatio = self.picture.image.size.height / self.picture.image.size.width;
    [self.view addSubview:self.picture];
    self.picture.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.picture.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.picture.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.picture.widthAnchor constraintEqualToAnchor:self.view.widthAnchor constant:-20],
        [self.picture.heightAnchor constraintEqualToAnchor:self.picture.widthAnchor multiplier:aspectRatio]
    ]];
    
    UIView *swipeView = [UIView new];
    swipeView.translatesAutoresizingMaskIntoConstraints = NO;
    swipeView.opaque = NO;
    [self.view addSubview:swipeView];
    [NSLayoutConstraint activateConstraints:@[
        [swipeView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [swipeView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [swipeView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [swipeView.heightAnchor constraintEqualToConstant:100]
    ]];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backFromModal)];
    [swipeGesture setNumberOfTouchesRequired:1];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [swipeView addGestureRecognizer:swipeGesture];
}

- (void)backFromModal {
    NSLog(@"swiped");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
