//
//  HomeViewController.m
//  Task6
//
//  Created by Tsimafei Zykau on 6/25/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import "HomeViewController.h"
#import "UIColor+Hex.h"
#import "ShapesStackView.h"
#import "StartupViewController.h"
#import "NavigationController.h"

@interface HomeViewController ()

@property (nonatomic, strong) UIStackView *buttonsStackView;
@property (nonatomic, strong) UILabel *deviceNameLabel;
@property (nonatomic, strong) UILabel *deviceLabel;
@property (nonatomic, strong) UILabel *systemVersionLabel;
@property (nonatomic, strong) ShapesStackView *shapesStackView;
@property (nonatomic, strong) UIImageView *appleImage;
@property (nonatomic, strong) UIButton *githubButton;
@property (nonatomic, strong) UIButton *startButton;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.deviceNameLabel = [UILabel new];
    [self.deviceNameLabel setText:[NSString stringWithFormat:@"%@", [[UIDevice currentDevice] name]]];
    [self.deviceNameLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightSemibold]];
    self.deviceNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.deviceLabel = [UILabel new];
    [self.deviceLabel setText:[NSString stringWithFormat:@"%@", [[UIDevice currentDevice] model]]];
    [self.deviceLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightSemibold]];
    self.deviceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.systemVersionLabel = [UILabel new];
    [self.systemVersionLabel setText:[NSString stringWithFormat:@"iOS %@", [[UIDevice currentDevice] systemVersion]]];
    [self.systemVersionLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightSemibold]];
    self.systemVersionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIStackView *systemInfoStackView = [UIStackView new];
    [systemInfoStackView setDistribution:UIStackViewDistributionFillEqually];
    [systemInfoStackView setAxis:UILayoutConstraintAxisVertical];
    systemInfoStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [systemInfoStackView addArrangedSubview:self.deviceNameLabel];
    [systemInfoStackView addArrangedSubview:self.deviceLabel];
    [systemInfoStackView addArrangedSubview:self.systemVersionLabel];
    
    self.appleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];;
    self.appleImage.image = [UIImage imageNamed:@"apple"];
    self.appleImage.contentMode = UIViewContentModeScaleAspectFill;
    self.appleImage.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIStackView *infoStackView = [UIStackView new];
    infoStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [infoStackView setDistribution:UIStackViewDistributionFill];
    [infoStackView setAxis:UILayoutConstraintAxisHorizontal];
    
    [infoStackView addArrangedSubview:self.appleImage];
    [infoStackView addArrangedSubview:systemInfoStackView];
    
    UIView *topDevidingLine = [UIView new];
    topDevidingLine.backgroundColor = [UIColor colorFromHexNumber:@0x707070];
    topDevidingLine.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.shapesStackView = [ShapesStackView new];
    self.shapesStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *bottomDevidingLine = [UIView new];
    bottomDevidingLine.backgroundColor = [UIColor colorFromHexNumber:@0x707070];
    bottomDevidingLine.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.buttonsStackView = [UIStackView new];
    self.buttonsStackView.distribution = UIStackViewDistributionFillEqually;
    self.buttonsStackView.spacing = 20;
    self.buttonsStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (self.view.frame.size.height>self.view.frame.size.width) {
        self.buttonsStackView.axis = UILayoutConstraintAxisVertical;
    }
    else{
        self.buttonsStackView.axis = UILayoutConstraintAxisHorizontal;
    }
    
    self.githubButton = [UIButton new];
    self.githubButton.layer.cornerRadius = 27.5;
    [self.githubButton setTitle:@"Open Git CV" forState:UIControlStateNormal];
    self.githubButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    [self.githubButton setTitleColor:[UIColor colorFromHexNumber:@0x101010] forState:normal];
    self.githubButton.backgroundColor = [UIColor colorFromHexNumber:@0xF9CC78];
    self.githubButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.startButton = [UIButton new];
    self.startButton.layer.cornerRadius = 27.5;
    [self.startButton setTitle:@"Go to start!" forState:UIControlStateNormal];
    self.startButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    [self.startButton setTitleColor:[UIColor colorFromHexNumber:@0xFFFFFF] forState:normal];
    self.startButton.backgroundColor = [UIColor colorFromHexNumber:@0xEE686A];
    self.startButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.buttonsStackView addArrangedSubview:self.githubButton];
    [self.buttonsStackView addArrangedSubview:self.startButton];
    
    UIStackView *allElementsStackView = [UIStackView new];
    allElementsStackView.translatesAutoresizingMaskIntoConstraints = NO;
    allElementsStackView.axis = UILayoutConstraintAxisVertical;
    allElementsStackView.distribution = UIStackViewDistributionFill;
    allElementsStackView.alignment = UIStackViewAlignmentCenter;
    allElementsStackView.spacing = 20;
    
    [allElementsStackView addArrangedSubview:infoStackView];
    [allElementsStackView addArrangedSubview:topDevidingLine];
    [allElementsStackView addArrangedSubview:self.shapesStackView];
    [allElementsStackView addArrangedSubview:bottomDevidingLine];
    [allElementsStackView addArrangedSubview:self.buttonsStackView];
    
    [self.view addSubview:allElementsStackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.appleImage.trailingAnchor constraintEqualToAnchor:systemInfoStackView.leadingAnchor constant:-10],
        [self.deviceLabel.centerXAnchor constraintEqualToAnchor:systemInfoStackView.centerXAnchor],
        [self.deviceNameLabel.centerXAnchor constraintEqualToAnchor:systemInfoStackView.centerXAnchor],
        [self.systemVersionLabel.centerXAnchor constraintEqualToAnchor:systemInfoStackView.centerXAnchor],
        
        [topDevidingLine.centerXAnchor constraintEqualToAnchor:allElementsStackView.centerXAnchor],
        [topDevidingLine.bottomAnchor constraintEqualToAnchor:self.shapesStackView.topAnchor constant:-20],
        [topDevidingLine.leadingAnchor constraintEqualToAnchor:allElementsStackView.leadingAnchor],
        [topDevidingLine.trailingAnchor constraintEqualToAnchor:allElementsStackView.trailingAnchor],
        [topDevidingLine.heightAnchor constraintEqualToConstant:1],
        
        [self.shapesStackView.widthAnchor constraintEqualToConstant:280],
        [self.shapesStackView.heightAnchor constraintEqualToConstant:70],
        
        [bottomDevidingLine.centerXAnchor constraintEqualToAnchor:allElementsStackView.centerXAnchor],
        [bottomDevidingLine.topAnchor constraintEqualToAnchor:self.shapesStackView.bottomAnchor constant:20],
        [bottomDevidingLine.leadingAnchor constraintEqualToAnchor:allElementsStackView.leadingAnchor],
        [bottomDevidingLine.trailingAnchor constraintEqualToAnchor:allElementsStackView.trailingAnchor],
        [bottomDevidingLine.heightAnchor constraintEqualToConstant:1],
        
        [self.githubButton.widthAnchor constraintEqualToConstant:250],
        [self.githubButton.heightAnchor constraintEqualToConstant:55],
        
        [self.startButton.heightAnchor constraintEqualToConstant:55],
        [self.startButton.widthAnchor constraintEqualToConstant:250],
        
        [allElementsStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [allElementsStackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
        
    ]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.githubButton addTarget:self action:@selector(gitButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.startButton addTarget:self action:@selector(startButtonTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.shapesStackView animateViews];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        self.buttonsStackView.axis = UILayoutConstraintAxisHorizontal;
    }
    else {
        self.buttonsStackView.axis = UILayoutConstraintAxisVertical;
    }
}

-(void)gitButtonTapped{
    NSLog(@"TAP");
    NSURL* url = [[NSURL alloc] initWithString: @"https://dobrykum.github.io/rsschool-cv/cv"];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

-(void)startButtonTapped{
    UIViewController *homeViewController = [StartupViewController new];
    self.view.window.rootViewController = homeViewController;
}

@end
