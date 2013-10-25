//
//  ViewController.m
//  textField
//
//  Created by Administrador on 8/23/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate method for UITextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == textFieldUsername){
        [ textFieldPasswd becomeFirstResponder ];
    }
    else if (textField == textFieldPasswd){
        NSString *promt_msg = [ NSString stringWithFormat:
                               @"Hello %@, your password has %d characters",
                               [ textFieldUsername text ],
                               [[ textFieldPasswd text ] length]
                               ];

        UIAlertView *loginAlert = [[ UIAlertView alloc ]
                                  initWithTitle: @"Login Prompt"
                                  message: promt_msg
                                  delegate: self
                                  cancelButtonTitle: @"Ok"
                                  otherButtonTitles: nil, nil
                                  ];
        [ loginAlert show ];
    }
    return YES;
}

- (IBAction)dismissKeyboard:(id)sender {
    [ textFieldUsername resignFirstResponder];
    [ textFieldPasswd resignFirstResponder];
}

@end
