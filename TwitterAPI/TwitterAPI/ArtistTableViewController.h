//
//  ArtistTableViewController.h
//  TwitterAPI
//
//  Created by Administrador on 11/22/13.
//  Copyright (c) 2013 Oscar Suro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterRequest.h"

@interface ArtistTableViewController : UITableViewController{
    NSArray *artistList;
    TwitterRequest *requestManager;
}

@end
