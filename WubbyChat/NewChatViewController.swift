//
//  NewChatViewController.swift
//  WubbyChat
//
//  Created by Matt Amerige on 12/21/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

import UIKit

class NewChatViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

  @IBOutlet weak var _groupNameField: UITextField!
  @IBOutlet weak var _membersCollectionView: UICollectionView!

  var _members : Array<Int>?
  
  let addButtonCellSize = CGSizeMake(40, 40);
  let memberCellSize = CGSizeMake(70, 70)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    _membersCollectionView.delegate = self
    _membersCollectionView.dataSource = self
    
    // Setting the members array to an empty array
    _members = []
  }
  
  //MARK: - Actions
  @IBAction func _cancel(sender: AnyObject) {
    
    self.dismissViewControllerAnimated(true, completion: nil);
    
  }
  
  @IBAction func _removeFriend(sender: AnyObject) {
    print("friend removed")
    _members?.removeLast()
    _membersCollectionView.reloadData()
  }
  
  /**
   Presents a friend picker for the user to add friends
   */
  @IBAction func _addFriend(sender: AnyObject) {
    print("Add button pressed")
    _members?.append(1)
    _membersCollectionView.reloadData()
  }
  
  //MARK: UICollectionView
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return (_members?.count)! + 1
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    var cellIdentifier: String
    
    if (indexPath.row == (_members?.count)!) {
      cellIdentifier = "addCell"
    } else {
      cellIdentifier = "memberCell"
    }
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)
    
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    let headerIdentifier = "participantsHeader"
    
    let cell = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, forIndexPath: indexPath)
    
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    print("item selected")
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    if (indexPath.row == _members?.count) {
      return addButtonCellSize
    }
    else {
      return memberCellSize
    }

  }
  
  

}
