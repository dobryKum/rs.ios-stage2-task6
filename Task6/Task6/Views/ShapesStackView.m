//
//  ShapesStackView.m
//  Task6
//
//  Created by Tsimafei Zykau on 6/25/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import "ShapesStackView.h"
#import "CircleShapeView.h"
#import "SquareShapeView.h"
#import "TriangleShapeView.h"

@interface ShapesStackView ()

@property (nonatomic, strong) CircleShapeView *circle;
@property (nonatomic, strong) SquareShapeView *square;
@property (nonatomic, strong) TriangleShapeView *triangle;

@end

@implementation ShapesStackView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.circle = [CircleShapeView new];
        self.square = [SquareShapeView new];
        self.triangle = [TriangleShapeView new];
        [self animateViews];
        
        [self addArrangedSubview:self.circle];
        [self addArrangedSubview:self.square];
        [self addArrangedSubview:self.triangle];
        self.axis = UILayoutConstraintAxisHorizontal;
        self.alignment = UIStackViewAlignmentCenter;
        self.distribution = UIStackViewDistributionEqualCentering;
        self.spacing = 35;
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints: @[
            [self.circle.heightAnchor constraintEqualToConstant:70.0],
            [self.circle.widthAnchor constraintEqualToConstant:70.0],
            [self.square.heightAnchor constraintEqualToConstant:70.0],
            [self.square.widthAnchor constraintEqualToConstant:70.0],
            [self.triangle.heightAnchor constraintEqualToConstant:70.0],
            [self.triangle.widthAnchor constraintEqualToConstant:70.0]
        ]];
    }
    return self;
}

- (void) animateViews {
    [self.circle animation];
    [self.square animation];
    [self.triangle animation];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
