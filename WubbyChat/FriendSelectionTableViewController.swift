//
//  FriendSelectionTableViewController.swift
//  WubbyChat
//
//  Created by Matt Amerige on 1/11/16.
//  Copyright © 2016 Wubbyland. All rights reserved.
//
/**
  Class Description: This table view controller presents a friends list to the user. The cells contain the friends name and a button that indicates whether 
  that friend has been selected or not. 

  Data Structures: An array consisting of all the friends the user has selected. Each selection/deselection will add or remove friends from the array, respectively.

  Operations: Upon loading the view this class will query parse for an array of friends that the user has. These friends are other friends who also use this app. (note:
  in the future I may include something to invite friends who do not currently have the app, but that should be done in another viewController separate from this one.)

  Unsolved problems: This class will need a way of reporting the array data back to its parentViewController. I think that keeping the array as the default 'internal' access control should do the job. Will update when I come to that area. First I'm just going to add some fake data to get the table view up and running.

*/

import UIKit

class FriendSelectionTableViewController: UITableViewController {
  
  
  var selectedFriendIndexRow = [Int]()
  var selectedFriends = [TestUser]()
  private var _testUserQueryResults = [TestUser]()
  
  //MARK: Parse Query
  private func _queryForTestUserFriends() {
    let query = TestUser.query()
    query?.findObjectsInBackgroundWithBlock({ (testUsers: [PFObject]?, error: NSError?) -> Void in
      if error  == nil {
        // Sucessfully found objects
        self._testUserQueryResults = testUsers as! [TestUser]
        self.tableView.reloadData()
      } else {
        // Error finding objects
        print("Error: \(error!) \(error!.userInfo)")
      }
    })
  }
  
  //MARK: - UITableViewController Datasource & Delegate Methods
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return _testUserQueryResults.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath) as! FriendSelectionTableViewCell
    
    _configureCell(cell, atIndexPath: indexPath)
    
    _setSelectionButtonStateForCell(cell, row: indexPath.row)
    
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let cell = tableView.cellForRowAtIndexPath(indexPath) as! FriendSelectionTableViewCell
    _toggleSelectionButtonForCell(cell)
    _toggleSelectedFriendForIndexPathRow(indexPath.row)
  }
  
  
  //MARK: Selection Button
  private func _toggleSelectionButtonForCell(cell : FriendSelectionTableViewCell) {
    cell.selectionButton.isFilled = !cell.selectionButton.isFilled
    cell.selectionButton.bounce()
  }
  
  private func _setSelectionButtonStateForCell(cell : FriendSelectionTableViewCell, row : Int) {
    if selectedFriends.contains(_testUserQueryResults[row]) {
      cell.selectionButton.isFilled = true
    } else {
      cell.selectionButton.isFilled = false
    }
  }
  
  //MARK: Adding/Removing Users
  private func _toggleSelectedFriendForIndexPathRow(row : Int) {
    if selectedFriends.contains(_testUserQueryResults[row]) {
      if let indexToRemove = selectedFriends.indexOf(_testUserQueryResults[row]) {
        selectedFriends.removeAtIndex(indexToRemove)
      }
    } else {
      selectedFriends.append(_testUserQueryResults[row])
    }
  }
  
  //MARK: Cell Configuration
  private func _configureCell(cell: FriendSelectionTableViewCell, atIndexPath indexPath: NSIndexPath) {
    // TestUser Object for this index
    let user = _testUserQueryResults[indexPath.row]
    
    cell.nameLabel.text = user.displayName
  }
  
  
  override func viewDidLoad() {
    _queryForTestUserFriends()
  }
  
}






