//
//  SquareShapeView.m
//  Task6
//
//  Created by Tsimafei Zykau on 6/25/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import "SquareShapeView.h"
#import "UIColor+Hex.h"

@implementation SquareShapeView

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColor(ctx, CGColorGetComponents([UIColor colorFromHexNumber:@0x29C2D1].CGColor));
    CGContextFillRect(ctx, rect);
}

- (void)animation {
    [UIView animateKeyframesWithDuration:1
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionRepeat
                              animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
            [self setTransform:CGAffineTransformTranslate(self.transform, 0, 7)];
        }];
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.5 animations:^{
            [self setTransform:CGAffineTransformTranslate(self.transform, 0, -14)];
        }];
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            [self setTransform:CGAffineTransformTranslate(self.transform, 0, 7)];
        }];
    }
                              completion:nil];
}

@end
