//
//  CelebrityViewController.h
//  TwitterAPI
//
//  Created by Administrador on 11/26/13.
//  Copyright (c) 2013 Oscar Suro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CelebrityViewController : UITableViewController <UIAlertViewDelegate> {
    NSArray *Celebritys;
}

- (IBAction)addCelebrity:(id)sender;

@end
