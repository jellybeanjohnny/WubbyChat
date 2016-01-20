//
//  RoundedCornerImageView.swift
//  WubbyChat
//
//  Created by Matt Amerige on 1/19/16.
//  Copyright © 2016 Wubbyland. All rights reserved.
//

/**
 Simple subclass of PFImageView to expost the corner radius property in IB.
Also offers a simple Bool to switch the imageView to a circle based on the corner radius of .5 * height
*/

import UIKit

@IBDesignable  class RoundedCornerImageView: PFImageView {

  @IBInspectable var cornerRadius : CGFloat = 0 {
    didSet {
      self.layer.cornerRadius = cornerRadius
    }
  }
  
  @IBInspectable var circleMode : Bool = false
  
  override func layoutSubviews() {
    if (circleMode == true) {
      cornerRadius = self.bounds.height / 2
    }
  }
}
