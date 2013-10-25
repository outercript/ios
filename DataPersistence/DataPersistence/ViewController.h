//
//  ViewController.h
//  DataPersistence
//
//  Created by Administrador on 9/24/13.
//  Copyright (c) 2013 orsurove. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
< UITextFieldDelegate, UIImagePickerControllerDelegate,
  UINavigationControllerDelegate>
{
    
    __weak IBOutlet UIImageView *userPhoto;
    __weak IBOutlet UITextField *firstName;
    __weak IBOutlet UITextField *lastName;
    __weak IBOutlet UIStepper *ageSelector;
    __weak IBOutlet UILabel *ageLabel;
    IBOutlet UITapGestureRecognizer *tapGesture;
    IBOutlet UITapGestureRecognizer *photoGesture;
}


- (IBAction)ageChanged:(id)sender;
- (IBAction)photoSelect:(id)sender;
- (IBAction)hideKeyboard:(id)sender;
@end
