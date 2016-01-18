//
//  NewChatViewController.swift
//  WubbyChat
//
//  Created by Matt Amerige on 12/21/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

/**
  Class description: This class is the main interface for creating a new chat.
  
  This class is responsbile for: 
  1. Naming the chat (can be pretty much any string, thing about giving it come kind of character limit)
  2. Respond to touch events and handle the keyboard appropriately 
  3. (Most importantly) this chat will create a chat object based on the user input. The chat object is stored in Parse (JBJChat). 
  Once saved, the actual chat should be presented to the user.
*/


import UIKit

class NewChatViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var _groupNameField: UITextField!
  
  private var _friendSelectionTableViewController : FriendSelectionTableViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    _groupNameField.delegate = self
    
    _setupGestures()
  }
  
  //MARK: - Actions
  @IBAction func _cancel(sender: AnyObject) {
    
    self.dismissViewControllerAnimated(true, completion: nil);
    
  }
  
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
  
  @IBAction func _createButtonPressed(sender: AnyObject) {
    _createChatParseObject { (succeeded) -> Void in
      if (succeeded) {
        self.dismissViewControllerAnimated(true, completion: nil)
      }
    }
  }
  
  // Create a JBJChat object and save to parse
  private func _createChatParseObject(completion:(succeeded : Bool) -> Void) {
    print(_friendSelectionTableViewController?.selectedFriendIndexRow.count)
    completion(succeeded: true)
  }
  
  //MARK: - Segue
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "EmbedFriendSelectionTableViewController" {
      // Grab a reference to the FriendSelectionTableViewController
      _friendSelectionTableViewController = segue.destinationViewController as? FriendSelectionTableViewController
    }
  }
  

}























