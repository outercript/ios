//
//  TwittsTableViewController.h
//  TwitterAPI
//
//  Created by Administrador on 11/22/13.
//  Copyright (c) 2013 Oscar Suro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterRequest.h"

@interface TwittsTableViewController : UITableViewController <TwitterRequestDelegate>{
    NSMutableArray *twittsList;
    TwitterRequest *requestManager;
}

@property (nonatomic, strong) NSString *celebrityName;
@property (nonatomic, strong) NSArray *keywordList;

@end
