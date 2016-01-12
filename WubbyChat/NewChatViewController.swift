//
//  NewChatViewController.swift
//  WubbyChat
//
//  Created by Matt Amerige on 12/21/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

import UIKit

class NewChatViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var _groupNameField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    _groupNameField.delegate = self
    
    _setupGestures()
  }
  
  //MARK: - Actions
  @IBAction func _cancel(sender: AnyObject) {
    
    self.dismissViewControllerAnimated(true, completion: nil);
    
  }
  
   /**
   Lowers the keyboard
   */
  func _lowerKeyboard() {
    if _groupNameField.isFirstResponder() {
      _groupNameField.resignFirstResponder()
    }
  }
  
  //MARK: - Gestures
  func _setupGestures() {
    let tapGesture = UITapGestureRecognizer.init(target: self, action: "_lowerKeyboard")
    tapGesture.cancelsTouchesInView = false
    self.view.addGestureRecognizer(tapGesture)
  }
  
  //MARK: - UITextfieldDelegate
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    _lowerKeyboard()
    return true
  }
  

}
