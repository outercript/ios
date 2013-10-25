//
//  DetailViewController.h
//  Employee
//
//  Created by Administrador on 9/27/13.
//  Copyright (c) 2013 orsurove. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
