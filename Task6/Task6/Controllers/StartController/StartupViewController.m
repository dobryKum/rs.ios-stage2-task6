//
//  StartupViewController.m
//  Task6
//
//  Created by Tsimafei Zykau on 6/24/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import "StartupViewController.h"
#import "ShapesStackView.h"
#import "UIColor+Hex.h"

@interface StartupViewController ()

@property (nonatomic, strong) UILabel *startLabel;
@property (nonatomic, strong) ShapesStackView *shapesStackView;
@property (nonatomic, strong) UIButton *startButton;

@end

@implementation StartupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor colorFromHexNumber:@0xFFFFFF];
    
    UIStackView *allElementsStackView = [UIStackView new];
    [allElementsStackView setAxis:UILayoutConstraintAxisVertical];
    [allElementsStackView setDistribution:UIStackViewDistributionFill];
    [allElementsStackView setAlignment:UIStackViewAlignmentCenter];
    [allElementsStackView setSpacing:100];
    [allElementsStackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.startLabel = [UILabel new];
    [self.startLabel setText:@"Are you ready?"];
    [self.startLabel setFont:[UIFont systemFontOfSize:24 weight:UIFontWeightMedium]];
    [self.startLabel setTextColor:[UIColor colorFromHexNumber:@0x101010]];
    [self.startLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.shapesStackView = [ShapesStackView new];
    [self.shapesStackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.startButton = [UIButton new];
    [self.startButton setBackgroundColor:[UIColor colorFromHexNumber:@0xF9CC78]];
    [self.startButton setTitle:@"START" forState:UIControlStateNormal];
    [self.startButton setTitleColor:[UIColor colorFromHexNumber:@0x101010] forState:UIControlStateNormal];
    [self.startButton.titleLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
    [self.startButton.layer setCornerRadius:27.5];
    [self.startButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [allElementsStackView addArrangedSubview:self.startLabel];
    [allElementsStackView addArrangedSubview:self.shapesStackView];
    [allElementsStackView addArrangedSubview:self.startButton];
    
    [self.view addSubview:allElementsStackView];
    
     [NSLayoutConstraint activateConstraints:@[
         [self.startLabel.centerXAnchor constraintEqualToAnchor:allElementsStackView.centerXAnchor],
         
         [self.shapesStackView.widthAnchor constraintEqualToConstant:280],
         [self.shapesStackView.bottomAnchor constraintEqualToAnchor:self.startButton.topAnchor constant:-100],
         
         [self.startButton.heightAnchor constraintEqualToConstant:55],
         [self.startButton.widthAnchor constraintEqualToAnchor:self.shapesStackView.widthAnchor],
         [allElementsStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
         [allElementsStackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
    
    [self.startButton addTarget:self action:@selector(startButtonTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)startButtonTapped {
    [NSNotificationCenter.defaultCenter postNotification:[NSNotification notificationWithName:@"startButtonTapped" object:nil]];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
