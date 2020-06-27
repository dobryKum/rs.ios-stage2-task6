//
//  UIColor+Hex.m
//  Task6
//
//  Created by Tsimafei Zykau on 6/24/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *) colorFromHexNumber:(NSNumber *)hexNumber {
    return [UIColor colorWithRed:((float)((hexNumber.intValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexNumber.intValue & 0x00FF00) >>  8))/255.0
                            blue:((float)((hexNumber.intValue & 0x0000FF) >>  0))/255.0
                           alpha:1.0];
}

@end
