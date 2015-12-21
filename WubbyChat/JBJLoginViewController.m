//
//  JBJLoginViewController.m
//  TestChat
//
//  Created by Matt Amerige on 11/25/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

#import "JBJLoginViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>

@interface JBJLoginViewController ()
{
  __weak IBOutlet UITextField *_usernameTextField;
  __weak IBOutlet UITextField *_passwordTextField;
  
}

@end

@implementation JBJLoginViewController


- (IBAction)_login:(id)sender
{
  [PFUser logInWithUsernameInBackground:_usernameTextField.text password:_passwordTextField.text block:^(PFUser * _Nullable user, NSError * _Nullable error) {
    if (!error) {
      NSLog(@"Sucessfully logged in");
      [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
      NSLog(@"Error logging in.");
    }
    
  }];
}

- (IBAction)_loginWithFacebook:(id)sender
{
  NSArray<NSString *> *permissions = @[@"public_profile", @"user_friends"];
  
  [PFFacebookUtils logInInBackgroundWithReadPermissions:permissions block:^(PFUser * _Nullable user, NSError * _Nullable error) {
    if (!user) {
      NSLog(@"User cancelled Facebook login");
    }
    else if (user.isNew) {
      NSLog(@"New user sign up via Facebook");
    }
    else {
      NSLog(@"User logged in through Facebook");
    }
  }];
}






@end
