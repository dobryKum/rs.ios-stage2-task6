//
//  InfoViewController.m
//  Task6
//
//  Created by Tsimafei Zykau on 6/25/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import "InfoViewController.h"
#import <Photos/Photos.h>
#import "UIColor+Hex.h"
#import "InfoTableViewCell.h"
#import "NavigationController.h"
#import "FilePreviewViewController.h"

@interface InfoViewController ()

@property(nonatomic , strong) PHFetchResult *assetsFetchResults;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    [self.tableView registerClass:InfoTableViewCell.class forCellReuseIdentifier:@"photoCellId"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.assetsFetchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoTableViewCell *cell = (InfoTableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"photoCellId" forIndexPath:indexPath];
    PHAsset *asset = self.assetsFetchResults[indexPath.item];
    NSArray<PHAssetResource*> *assetResources = [PHAssetResource assetResourcesForAsset:asset];
    NSString *fileName = @"";
    if ([assetResources count] > 0) {
        fileName = [assetResources objectAtIndex:0].originalFilename;
    }

    [cell.fileName setText:fileName];
    [cell.fileName setTextColor:[UIColor colorFromHexNumber:@0x101010]];
    [cell.fileName setFont:[UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold]];
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        cell.preview.contentMode = UIViewContentModeScaleAspectFill;
        cell.preview.layer.masksToBounds = YES;
        cell.preview.image = result;

        [cell.fileInfo setTextColor:[UIColor colorFromHexNumber:@0x101010]];

        switch (asset.sourceType) {
            case PHAssetResourceTypeVideo:
                cell.fileTypeIcon.image = [UIImage imageNamed:@"video"];
                cell.fileInfo.attributedText = [self getSmallTextForLabel:[[NSString alloc] initWithFormat:@"%lux%lu %f", (unsigned long)asset.pixelWidth, (unsigned long)asset.pixelHeight, asset.duration]];
                    break;
            case PHAssetResourceTypeAudio:
                cell.fileTypeIcon.image = [UIImage imageNamed:@"audio"];
                cell.fileInfo.attributedText = [self getSmallTextForLabel:[[NSString alloc] initWithFormat:@"%f", asset.duration]];
                break;
            case PHAssetResourceTypePhoto:
                cell.fileTypeIcon.image = [UIImage imageNamed:@"image"];
//                cell.fileInfo
                cell.fileInfo.attributedText = [self getSmallTextForLabel:[[NSString alloc] initWithFormat:@"%lux%lu", (unsigned long)asset.pixelWidth, (unsigned long)asset.pixelHeight]];
                    break;
            default:
                cell.fileTypeIcon.image = [UIImage imageNamed:@"other"];
                cell.fileInfo.text = @"";
                break;
            }
        }];
    return cell;
}

- (NSAttributedString*) getTextForLabel:(NSString*)input color:(UIColor*)color
                                      size:(CGFloat)size
                                    weight:(UIFontWeight)weight {
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:input attributes:@{
        NSForegroundColorAttributeName:color,
        NSFontAttributeName:[UIFont systemFontOfSize:size weight:weight]
    }];
    return attributedText;
}

- (NSAttributedString*) getSmallTextForLabel:(NSString*)input {
    return [self getTextForLabel:input color:[UIColor colorFromHexNumber:@0x101010] size:12.0 weight:UIFontWeightRegular];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    FilePreviewViewController *filePreviewViewController = [FilePreviewViewController new];
    filePreviewViewController.photoAsset = self.assetsFetchResults[indexPath.item];
    [self.navigationController pushViewController:filePreviewViewController animated:YES];
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
