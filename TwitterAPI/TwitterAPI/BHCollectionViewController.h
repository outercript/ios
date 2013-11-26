//
//  BHCollectionViewController.h
//  CollectionViewTutorial
//
//  Created by Bryan Hansen on 11/3/12.
//  Copyright (c) 2012 Bryan Hansen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterRequest.h"

@interface BHCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>{
    NSArray *artistList;
    TwitterRequest *requestManager;
}

@end
