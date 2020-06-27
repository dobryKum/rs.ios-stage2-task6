//
//  GalleryCollectionViewCell.m
//  Task6
//
//  Created by Tsimafei Zykau on 6/25/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import "GalleryCollectionViewCell.h"
#import "UIColor+Hex.h"

@implementation GalleryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (void) setupCell {
    
    self.preview = [[UIImageView alloc] init];
    
    [self addSubview:self.preview];
    
    self.preview.translatesAutoresizingMaskIntoConstraints = false;
    
    [NSLayoutConstraint activateConstraints: @[
        [self.preview.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0.0],
        [self.preview.topAnchor constraintEqualToAnchor:self.topAnchor constant:0.0],
        [self.preview.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0.0],
        [self.preview.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0.0]
    ]];
    
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = [UIColor colorFromHexNumber:@0xFDF4E3];
    self.backgroundColor = [UIColor colorFromHexNumber:@0xFFFFFF];
}

@end
