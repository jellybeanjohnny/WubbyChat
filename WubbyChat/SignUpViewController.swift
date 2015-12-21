//
//  SignUpViewController.swift
//  WubbyChat
//
//  Created by Matt Amerige on 12/17/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var _emailTextField: UITextField!
  @IBOutlet weak var _displayNameTextField: UITextField!
  @IBOutlet weak var _passwordTextField: UITextField!
  
  
  override func viewDidLoad() {
    
    // Set the textfield delegates so we can respond to return events
    _emailTextField.delegate = self
    _displayNameTextField.delegate = self
    _passwordTextField.delegate = self
    
    // Setting the email text field as the first responder so the user can begin typing right away
    _emailTextField.becomeFirstResponder()
  }
  
/**
   Signs up the user to be stored on Parse via the standard sign up process
*/
  
  func _signUpUser() {
    
    /**
    Some preliminary checks to make sure the data the user enters is acceptable.
    This will probably have to change to be more thorough, but for now these simple
    tests will suffice
    */
    //WARNING: add better checks here
    if (_emailTextField.text == "" || _displayNameTextField.text == "" || _passwordTextField.text == "") {
      print("One or more of the entered data is blank!")
      return
    }
    
    // Assuming entered data is good at this point...
    let newUser = PFUser()
    newUser.username = _emailTextField.text
    newUser.email = _emailTextField.text
    newUser.password = _passwordTextField.text
    newUser["displayName"] = _displayNameTextField.text
    
    // Saving the new user object to parse
    newUser.signUpInBackgroundWithBlock { (succeeded : Bool, error : NSError?) -> Void in
      if let error = error {
        let errorString = error.userInfo["error"] as? NSString
        print("Error signing in user. Here are the details: \(errorString)")
      } else {
        print("Success! User \(newUser.username!) is successfully saved to Parse")
        // Unwind back to the ChatListViewController
        self.performSegueWithIdentifier("unwindToChatList", sender: nil);
      }
    }
  }
  
  //MARK: - UITextFieldDelegate
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if textField == _emailTextField {
      // Move the first responder
      _displayNameTextField.becomeFirstResponder()
    } else if textField == _displayNameTextField {
      // Move to the password field
      _passwordTextField.becomeFirstResponder()
    }
    else {
      _signUpUser()
    }
    return false
  }
}














