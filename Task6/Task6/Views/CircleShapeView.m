//
//  CircleShapeView.m
//  Task6
//
//  Created by Tsimafei Zykau on 6/25/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import "CircleShapeView.h"
#import "UIColor+Hex.h"

@implementation CircleShapeView

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColor(ctx, CGColorGetComponents([UIColor colorFromHexNumber:@0xFFFFFF].CGColor));
    CGContextFillRect(ctx, rect);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColor(ctx, CGColorGetComponents([UIColor colorFromHexNumber:@0xEE686A].CGColor));
    CGContextFillPath(ctx);
}

- (void)animation {
    [UIView animateKeyframesWithDuration:1
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionRepeat
                              animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
            [self setTransform:CGAffineTransformScale(self.transform, (CGFloat)77/70, (CGFloat)77/70)];
        }];
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.5 animations:^{
            [self setTransform:CGAffineTransformScale(self.transform, (CGFloat)63/77, (CGFloat)63/77)];
        }];
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            [self setTransform:CGAffineTransformScale(self.transform, (CGFloat)70/63, (CGFloat)70/63)];
        }];
    }
                              completion:nil];
}

@end
