//
//  FilePreviewViewController.h
//  Task6
//
//  Created by Tsimafei Zykau on 6/25/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilePreviewViewController : UIViewController

@property (strong, nonatomic) PHAsset *photoAsset;

@end

NS_ASSUME_NONNULL_END
