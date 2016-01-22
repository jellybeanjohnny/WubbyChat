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


class NewChatViewController: UIViewController, UITextFieldDelegate, FriendSelectionTableViewDelegate {

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
  
  //MARK: - Creating a New Chat
  @IBAction func _createButtonPressed(sender: AnyObject) {
    _createChatParseObject { (succeeded) -> Void in
      if (succeeded) {
        self.dismissViewControllerAnimated(true, completion: nil)
      }
    }
  }
  
  // Create a JBJChat object and save to parse
  private func _createChatParseObject(completion:(succeeded : Bool) -> Void) {
    
    if let selectedFriends = _friendSelectionTableViewController?.selectedFriends {
      if selectedFriends.isEmpty {
        // Throw up a message that no one is currently selected
        _showNoFriendSelectedAlert()
        completion(succeeded: false)
      } else {
        let newchat = JBJChat.object()
        newchat.chatName = _groupNameField.text
        _addSelectedFriendsToChat(newchat, selectedFriends: selectedFriends)
        // save JBJChat to parse, return the appropriate result to the closure
        
        completion(succeeded: true)
      }
    }
  }
  
  /**
   Adds the selected friends that were selected in the tableViewController to the JBJChat object
  */
   //TODO: After testing is over replace the [TestUser] with normal [PFUser]
  private func _addSelectedFriendsToChat(chat : JBJChat, selectedFriends : [TestUser]) {
    for friend in selectedFriends {
      //TODO: The participants property is @dynamic, so the getter and setter are not specified until runtime (i think)?
      // This results in participants being nil at this point in the program, so it will crash when trying to call the addObject() method.
      // I can either do something like alloc init a new NSMutableArray at the point of use (now), or I will have to figure out another way
      // to add this functionality to the JBJChat object.
      chat.participants.addObject(friend)
    }
  }
  
  private func _showNoFriendSelectedAlert() {
    //TODO: implement this method
    print("No friends currently selected!")
  }
  
  //MARK: - FriendSelectionTableViewDelegate Methods
  func tableViewIsScrolling(isScrolling: Bool) {
    if (isScrolling) {
      _lowerKeyboard()
    }
  }
  
  //MARK: - Segue
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "EmbedFriendSelectionTableViewController" {
      // Grab a reference to the FriendSelectionTableViewController
      _friendSelectionTableViewController = segue.destinationViewController as? FriendSelectionTableViewController
      _friendSelectionTableViewController?.delegate = self
    }
  }
  

}























