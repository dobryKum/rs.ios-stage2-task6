//
//  InfoViewController.h
//  Task6
//
//  Created by Tsimafei Zykau on 6/25/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "FilePreviewViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InfoViewController : UITableViewController <PHPhotoLibraryChangeObserver>

@end

NS_ASSUME_NONNULL_END
