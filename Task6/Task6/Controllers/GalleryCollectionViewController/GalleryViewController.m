//
//  GalleryViewController.m
//  Task6
//
//  Created by Tsimafei Zykau on 6/25/20.
//  Copyright © 2020 Timofey Zykov. All rights reserved.
//

#import "GalleryViewController.h"
#import <Photos/Photos.h>
#import "UIColor+Hex.h"
#import "GalleryCollectionViewCell.h"
#import "NavigationController.h"
#import "FilePreviewViewController.h"
#import "ModalViewController.h"

@interface GalleryViewController ()

@property (strong, atomic) NSMutableArray<PHAsset*>* dataSource;
@property (nonatomic, strong) PHFetchResult *assetsFetchResults;
@property (nonatomic, strong) PHCachingImageManager *imageManager;
@property (nonatomic, assign) CGRect frameSize;

@end

@implementation GalleryViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self.navigationController
                                                                            action:nil];
    
    [self.collectionView registerClass:[GalleryCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    self.collectionView.backgroundColor = [UIColor colorFromHexNumber:@0xFFFFFF];
    self.collectionView.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*) self.collectionViewLayout;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return ceil((float)[self.assetsFetchResults count]/3);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    long index = indexPath.row + indexPath.section * 3;

    GalleryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (index >= [self.assetsFetchResults count]) {
        return cell;
    }
    
    PHAsset *asset = self.assetsFetchResults[index];
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        cell.preview.contentMode = UIViewContentModeScaleAspectFill;
        cell.preview.layer.masksToBounds = YES;
        cell.preview.image = result;
    }];
    
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    long index = indexPath.row + indexPath.section * 3;
    if (index >= [self.assetsFetchResults count]) {
        return CGSizeZero;
    }
    CGRect mainFrame = self.collectionView.frame;
    return CGSizeMake((mainFrame.size.width - 20) / 3, (mainFrame.size.width - 20) / 3);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.collectionView reloadData];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section > 0) {
        return UIEdgeInsetsMake(0, 5, 5, 5);
    }
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    long index = indexPath.row + indexPath.section * 3;
//    if (index >= [self.assetsFetchResults count]) {
//        return;
//    }
    PHAsset *asset = self.assetsFetchResults[index];
    ModalViewController *modalViewController = [ModalViewController new];
    modalViewController.photoAsset = asset;
    [self.navigationController presentViewController:modalViewController animated:YES completion:nil];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    return NO;
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

@end
