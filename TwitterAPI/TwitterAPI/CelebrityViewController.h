//
//  CelebrityViewController.h
//  TwitterAPI
//
//  Created by Administrador on 11/26/13.
//  Copyright (c) 2013 Oscar Suro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterRequest.h"

@interface CelebrityViewController : UITableViewController <UIAlertViewDelegate, TwitterRequestDelegate> {
    NSArray *Celebritys;
}

@property (nonatomic, strong) TwitterRequest *requestManager;

- (IBAction)addCelebrity:(id)sender;

@end
