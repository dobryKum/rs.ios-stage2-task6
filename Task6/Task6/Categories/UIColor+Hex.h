//
//  UIColor+Hex.h
//  Task6
//
//  Created by Tsimafei Zykau on 6/24/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

+ (UIColor *) colorFromHexNumber:(NSNumber *)hexNumber;

@end

NS_ASSUME_NONNULL_END
