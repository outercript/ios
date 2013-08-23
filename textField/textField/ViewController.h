//
//  ViewController.h
//  textField
//
//  Created by Administrador on 8/23/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
    <UITextFieldDelegate>
{

    __weak IBOutlet UITextField *textFieldUsername;
    __weak IBOutlet UITextField *textFieldPasswd;


}

- (IBAction)dismissKeyboard:(id)sender;

@end
