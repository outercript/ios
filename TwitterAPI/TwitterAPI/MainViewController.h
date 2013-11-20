//
//  MainViewController.h
//  TwitterAPI
//
//  Created by Oscar Suro on 11/19/13.
//  Copyright (c) 2013 Oscar Suro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterRequest.h"

@interface MainViewController : UIViewController <TwitterRequestDelegate>{
    TwitterRequest *twitter;
    IBOutlet UITextField *searchBar;
}

- (IBAction)doQuery:(id)sender;

@end
