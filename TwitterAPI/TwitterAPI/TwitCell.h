//
//  TwitCell.h
//  TwitterAPI
//
//  Created by Oscar Suro on 11/22/13.
//  Copyright (c) 2013 Oscar Suro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *content;

@end
