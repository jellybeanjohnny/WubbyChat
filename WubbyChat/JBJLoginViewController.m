//
//  JBJLoginViewController.m
//  TestChat
//
//  Created by Matt Amerige on 11/25/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

#import "JBJLoginViewController.h"
#import <Parse/Parse.h>

@interface JBJLoginViewController ()
{
  __weak IBOutlet UITextField *_usernameTextField;
  __weak IBOutlet UITextField *_passwordTextField;
  
}

@end

@implementation JBJLoginViewController

- (void)viewDidLoad
{
   [super viewDidLoad];
   // Do any additional setup after loading the view.
}

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







@end
