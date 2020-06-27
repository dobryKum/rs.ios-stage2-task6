//
//  FilePreviewViewController.m
//  Task6
//
//  Created by Tsimafei Zykau on 6/25/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import "FilePreviewViewController.h"
#import <Photos/Photos.h>
#import "UIColor+Hex.h"

@interface FilePreviewViewController ()

@property (strong, nonatomic) UIImageView *picture;
@property (strong, nonatomic) UILabel *creationDateLabel;
@property (strong, nonatomic) UILabel *modificationDateLabel;
@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) UIScrollView *mainArea;
@property (strong, nonatomic, nullable) NSLayoutConstraint *aspectRatioConstraint;
@property (strong, nonatomic) UIButton *shareButton;
@property (strong, nonatomic) UIStackView *labels;
@property (strong, nonatomic) UIImage *imageToShare;

@end

@implementation FilePreviewViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.aspectRatioConstraint = nil;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainArea = [[UIScrollView alloc] init];
    self.picture = [[UIImageView alloc] init];
    self.creationDateLabel = [[UILabel alloc] init];
    self.modificationDateLabel = [[UILabel alloc] init];
    self.typeLabel = [[UILabel alloc] init];
    self.shareButton = [[UIButton alloc] init];
    self.labels = [[UIStackView alloc] init];
    
    self.mainArea.alwaysBounceHorizontal = NO;
    
    [self.view addSubview:self.mainArea];
    self.view.backgroundColor = [UIColor colorFromHexNumber:@0xFFFFFF];
    self.mainArea.backgroundColor = [UIColor colorFromHexNumber:@0xFFFFFF];
    
    self.picture.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.mainArea addSubview:self.picture];
    
    [self.labels addArrangedSubview:self.creationDateLabel];
    [self.labels addArrangedSubview:self.modificationDateLabel];
    [self.labels addArrangedSubview:self.typeLabel];
    
    self.shareButton.layer.cornerRadius = 27.5 ;
    self.shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.shareButton.widthAnchor constraintEqualToConstant:250].active = YES;
    [self.shareButton.heightAnchor constraintEqualToConstant:55].active = YES;
    [self.shareButton setTitleColor:[UIColor colorFromHexNumber:@0x101010] forState:UIControlStateNormal];
    [self.shareButton setBackgroundColor:[UIColor colorFromHexNumber:@0xF9CC78]];
    [self.shareButton setTitle:@"Share" forState:UIControlStateNormal];
    
    [self.mainArea addSubview:self.labels];
    [self.mainArea addSubview:self.shareButton];
    
    [self setupLabels];
    
    self.shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.shareButton.centerXAnchor constraintEqualToAnchor:self.mainArea.centerXAnchor],
        [self.shareButton.bottomAnchor constraintEqualToAnchor:self.mainArea.bottomAnchor constant:-30.0],
    ]];
    
    [self.shareButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSArray<PHAssetResource*> *assetResources = [PHAssetResource assetResourcesForAsset:self.photoAsset];
    NSString *fileName = @"File info";
    if ([assetResources count] > 0) {
        fileName = [assetResources objectAtIndex:0].originalFilename;
        self.title = fileName;
    }
    
    self.picture.image = nil;
    CGFloat aspectRatio = (CGFloat) self.photoAsset.pixelHeight / (CGFloat) self.photoAsset.pixelWidth;
    
    if (self.aspectRatioConstraint) {
        [NSLayoutConstraint deactivateConstraints:@[self.aspectRatioConstraint]];
    }
    
    self.aspectRatioConstraint = [self.picture.heightAnchor constraintEqualToAnchor:self.picture.widthAnchor multiplier:aspectRatio];
    
    self.mainArea.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.mainArea.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.mainArea.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.mainArea.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.mainArea.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    ]];
    self.picture.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
     @[[self.picture.topAnchor constraintEqualToAnchor:self.mainArea.topAnchor constant:10.0],
       [self.picture.leadingAnchor constraintEqualToAnchor:self.mainArea.leadingAnchor constant:10.0],
       [self.picture.widthAnchor constraintEqualToAnchor:self.mainArea.widthAnchor constant:-20.0],
       self.aspectRatioConstraint
     ]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[PHImageManager defaultManager] requestImageForAsset:self.photoAsset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if ([[info valueForKey:PHImageResultIsDegradedKey] intValue]) {
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.picture.image = result;
                self.imageToShare = result;
                [self.picture setNeedsLayout];
                [self.picture layoutIfNeeded];
            });
        }];
    });
}

- (void)setupLabels {
    self.labels.backgroundColor = UIColor.magentaColor;
    self.labels.axis = UILayoutConstraintAxisVertical;
    self.labels.alignment = UIStackViewAlignmentLeading;
    self.labels.distribution = UIStackViewDistributionEqualCentering;
    self.labels.spacing = 10.0;
    
    self.labels.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.labels.topAnchor constraintEqualToAnchor:self.picture.bottomAnchor constant:30.0],
        [self.labels.leadingAnchor constraintEqualToAnchor:self.mainArea.leadingAnchor constant:10.0],
        [self.labels.trailingAnchor constraintEqualToAnchor:self.mainArea.trailingAnchor constant:-10.0],
        [self.labels.bottomAnchor constraintEqualToAnchor:self.shareButton.topAnchor constant:-10.0],
    ]];
    
    PHAsset *asset = self.photoAsset;
    NSMutableAttributedString *creationDate = [[NSMutableAttributedString alloc] init];
    [creationDate appendAttributedString:[[NSAttributedString alloc] initWithString:@"Creation date: "]];
    [creationDate appendAttributedString:[[NSAttributedString alloc] initWithString:[self getDateHint:asset.creationDate]]];
    self.creationDateLabel.attributedText = creationDate;
    NSMutableAttributedString *modificationDate = [[NSMutableAttributedString alloc] init];
    [modificationDate appendAttributedString:[[NSAttributedString alloc] initWithString:@"Modification date: "]];
    [modificationDate appendAttributedString:[[NSAttributedString alloc] initWithString:[self getDateHint:asset.modificationDate]]];
    self.modificationDateLabel.attributedText = modificationDate;
    
    NSMutableAttributedString *type = [[NSMutableAttributedString alloc] init];
    [type appendAttributedString:[[NSAttributedString alloc] initWithString:@"Type: "]];
    [type appendAttributedString:[[NSAttributedString alloc] initWithString:[self getMediaTypeHint:asset.mediaType]]];
    self.typeLabel.attributedText = type;
}

- (void)buttonPressed:(id) sender {
    if (!self.imageToShare) {
        return;
    }
    UIImage *exportedImage = self.imageToShare;
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[exportedImage] applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:^{}];
}

- (NSString*)getMediaTypeHint:(PHAssetMediaType) mediaType {
    switch (mediaType) {
        case PHAssetMediaTypeAudio: return @"Audio";
        case PHAssetMediaTypeImage: return @"Image";
        case PHAssetMediaTypeVideo: return @"Video";
        default: return @"Other";
    }
}

- (NSString*)getDateHint:(NSDate*)input {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"ss:mm:HH dd:MM:YYYY";
    NSString *hint = [fmt stringFromDate:input];
    return hint;
}

@end
