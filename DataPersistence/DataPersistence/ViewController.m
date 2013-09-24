//
//  ViewController.m
//  DataPersistence
//
//  Created by Administrador on 9/24/13.
//  Copyright (c) 2013 orsurove. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view addGestureRecognizer:tapGesture];
    [userPhoto addGestureRecognizer:photoGesture];
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ageChanged:(id)sender {
    ageLabel.text = [NSString stringWithFormat:@"%u", (int)ageSelector.value ];
    [self saveData];
}

- (IBAction)photoSelect:(id)sender {
    UIImagePickerController *picker = [[ UIImagePickerController alloc] init ];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil ];
    [self saveData ];
}

- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:YES ];
}

-(void)saveData{
    NSUserDefaults *userData = [ NSUserDefaults standardUserDefaults ];
    [ userData setObject:firstName.text forKey:@"firstName" ];
    [ userData setObject:lastName.text forKey:@"lastName" ];
    [ userData setInteger:(int)ageSelector.value forKey:@"age" ];
    
    if (userPhoto.image != nil) {
        NSData *photoData = UIImagePNGRepresentation(userPhoto.image);
        [ userData setObject:photoData forKey:@"userPhoto"];
    }
    
    [ userData synchronize ];
}

-(void)loadData{
    NSUserDefaults *userData = [ NSUserDefaults standardUserDefaults ];
    firstName.text = [ userData objectForKey:@"firstName" ];
    lastName.text = [ userData objectForKey:@"lastName" ];
    
    ageSelector.value = [ userData integerForKey:@"age" ];
    [ self ageChanged:self ];

    if([userData objectForKey:@"userPhoto"] != nil ){
        NSData *tmp =[userData objectForKey:@"userPhoto"];
        userPhoto.image = [ UIImage imageWithData:tmp];
    }

}


#pragma mark - UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    userPhoto.image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil ];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil ];
}

#pragma mark - UITextField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self saveData ];
}

@end
