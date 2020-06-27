//
//  InfoTableViewCell.h
//  Task6
//
//  Created by Tsimafei Zykau on 6/25/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView* preview;
@property (strong, nonatomic) UILabel* fileName;
@property (strong, nonatomic) UIImageView* fileTypeIcon;
@property (strong, nonatomic) UILabel* fileInfo;

@end

NS_ASSUME_NONNULL_END
