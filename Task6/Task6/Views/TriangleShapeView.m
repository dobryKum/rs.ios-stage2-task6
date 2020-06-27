//
//  TriangleShapeView.m
//  Task6
//
//  Created by Tsimafei Zykau on 6/25/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import "TriangleShapeView.h"
#import "UIColor+Hex.h"

@implementation TriangleShapeView

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColor(ctx, CGColorGetComponents([UIColor colorFromHexNumber:@0xFFFFFF].CGColor));
    CGContextFillRect(ctx, rect);
    CGContextSetFillColor(ctx, CGColorGetComponents([UIColor colorFromHexNumber:@0x34C1A1].CGColor));
    CGContextMoveToPoint(ctx, 0.0, 70.0);
    CGContextAddLineToPoint(ctx, 35.0, 0);
    CGContextAddLineToPoint(ctx, 70.0, 70.0);
    CGContextFillPath(ctx);
}


- (void)animation {
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self setTransform:CGAffineTransformRotate(self.transform, M_PI_2)];
    }completion:^(BOOL finished){
        if (finished) {
            [self animation];
        }
    }];
}

@end
