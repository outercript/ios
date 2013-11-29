//
//  BHCollectionViewController.m
//  CollectionViewTutorial
//
//  Created by Bryan Hansen on 11/3/12.
//  Copyright (c) 2012 Bryan Hansen. All rights reserved.
//

#import "BHCollectionViewController.h"
#import "BHPhotoAlbumLayout.h"
#import "BHAlbumPhotoCell.h"
#import "BHAlbum.h"
#import "BHPhoto.h"
#import "BHAlbumTitleReusableView.h"

#import "TwittsTableViewController.h"
#import "TwitterRequest.h"

#import "AppDelegate.h"
#import "Celebrity.h"
#import "CelebrityViewController.h"

#import <CoreData/CoreData.h>

static NSString * const PhotoCellIdentifier = @"PhotoCell";
static NSString * const AlbumTitleIdentifier = @"AlbumTitle";

@interface BHCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *albums;
@property (nonatomic, weak) IBOutlet BHPhotoAlbumLayout *photoAlbumLayout;
@property (nonatomic, strong) NSOperationQueue *thumbnailQueue;

@end

@implementation BHCollectionViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *patternImage = [UIImage imageNamed:@"concrete_wall"];
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    requestManager = [[TwitterRequest alloc] init];
    [requestManager requestAuth];

    
    [self.collectionView registerClass:[BHAlbumPhotoCell class]
            forCellWithReuseIdentifier:PhotoCellIdentifier];
    [self.collectionView registerClass:[BHAlbumTitleReusableView class]
            forSupplementaryViewOfKind:BHPhotoAlbumLayoutAlbumTitleKind
                   withReuseIdentifier:AlbumTitleIdentifier];
    
    self.thumbnailQueue = [[NSOperationQueue alloc] init];
    self.thumbnailQueue.maxConcurrentOperationCount = 3;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadData];
    [self.collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    if ([self hasTwitterAccount] == NO){
        NSLog(@"Trying to login again");
        [requestManager requestAuth];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    self.albums = [NSMutableArray array];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Celebrity"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:YES]];

    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    Celebritys = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];

    NSInteger photoIndex = 0;

    for (Celebrity *item in Celebritys) {
        BHAlbum *album = [[BHAlbum alloc] init];
        album.name = item.userName;

        for (NSInteger p = 0; p < 3; p++) {
            NSURL *photoURL;
            
            if (item.userPhoto == nil) {
                photoURL = [NSURL URLWithString:@"http://talesofgrim.files.wordpress.com/2013/07/personal_trollface_hd.png"];
            }
            
            else{
                photoURL = [NSURL URLWithString:item.userPhoto];
            }
            
            BHPhoto *photo = [BHPhoto photoWithImageURL:photoURL];
            [album addPhoto:photo];

            photoIndex++;
        }

        [self.albums addObject:album];
    }
}

#pragma mark - View Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        self.photoAlbumLayout.numberOfColumns = 3;
        
        // handle insets for iPhone 4 or 5
        CGFloat sideInset = [UIScreen mainScreen].preferredMode.size.width == 1136.0f ?
                            45.0f : 25.0f;
        
        self.photoAlbumLayout.itemInsets = UIEdgeInsetsMake(22.0f, sideInset, 13.0f, sideInset);
        
    } else {
        self.photoAlbumLayout.numberOfColumns = 2;
        self.photoAlbumLayout.itemInsets = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.albums.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    BHAlbum *album = self.albums[section];
    return album.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BHAlbumPhotoCell *photoCell =
        [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellIdentifier
                                                  forIndexPath:indexPath];
    
    BHAlbum *album = self.albums[indexPath.section];
    BHPhoto *photo = album.photos[indexPath.item];
    
    // load photo images in the background
    __weak BHCollectionViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *image = [photo image];

        // then set them via the main queue if the cell is still visible.
        if ([weakSelf.collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
            BHAlbumPhotoCell *cell =
                (BHAlbumPhotoCell *)[weakSelf.collectionView cellForItemAtIndexPath:indexPath];
            cell.imageView.image = image;
        }
    });

    return photoCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath;
{
    BHAlbumTitleReusableView *titleView =
        [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                           withReuseIdentifier:AlbumTitleIdentifier
                                                  forIndexPath:indexPath];
    
    BHAlbum *album = self.albums[indexPath.section];
    titleView.titleLabel.text = album.name;
    
    return titleView;
}

#pragma mark - Twitter stuff
- (BOOL) hasTwitterAccount{
    if (requestManager.userAccount == nil) {
        return NO;
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self hasTwitterAccount] == NO){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Upsss!"
                                  message:@"I could not connect to Twitter. Check internet connection and make sure you setup your Twitter account in your device"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }

    TwittsTableViewController *twittView = [self.storyboard instantiateViewControllerWithIdentifier:@"details"];

    Celebrity *celebrity = Celebritys[indexPath.section];
    twittView.celebrityName = celebrity.userName;
    twittView.keywordList = @[celebrity.userName];
    twittView.requestManager = requestManager;

    NSLog(@"Loading celebrity: %@", celebrity.userName);

    [self.navigationController pushViewController:twittView animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"editCelebrity"]) {
        CelebrityViewController *editView = segue.destinationViewController;
        editView.requestManager = requestManager;
    }
}

@end
