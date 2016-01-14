//
//  FillButton.swift
//  FillButton
//
//  Created by Matt Amerige on 1/6/16.
//  Copyright © 2016 Wubbyland. All rights reserved.
//

import UIKit


@IBDesignable class FillButton: UIControl {
  
  //MARK: - Private Properties
  private let _circleLayer = CALayer()
  
  //MARK: - Designable Properties
  
  //MARK: Border Color
  @IBInspectable var fillBorderColor : UIColor = UIColor.blackColor() {
    didSet {
      _updateLayoutProperties()
    }
  }
  
  @IBInspectable var unfilledBorderColor : UIColor = UIColor.blackColor() {
    didSet {
      _updateLayoutProperties()
    }
  }
  
  //MARK: Border Width
  @IBInspectable var fillBorderWidth : CGFloat = 0 {
    didSet {
      _updateLayoutProperties()
    }
  }
  
  @IBInspectable var unfilledBorderWidth : CGFloat = 0 {
    didSet {
      _updateLayoutProperties()
    }
  }
  
  //MARK: Fill Color
  @IBInspectable var fillColor : UIColor = UIColor.greenColor() {
    didSet {
      _updateLayoutProperties()
    }
  }
  
  @IBInspectable var unfilledColor : UIColor = UIColor.grayColor() {
    didSet {
      _updateLayoutProperties()
    }
  }
  
  //MARK: Circle Size
  @IBInspectable var circleSize : CGFloat = 44 {
    didSet {
      _updateLayoutProperties()
    }
  }
  
  //MARK: Fill Toggle
  
  /**
   Toggles between the filled and unfilled state of the fillButton. Starting state is unfilled.
  */
  @IBInspectable var isFilled : Bool = false {
    didSet {
      _updateLayoutProperties()
    }
  }
  
  //MARK: Animation Properties
  @IBInspectable var springBounce : CGFloat = 10
  @IBInspectable var springSpeed : CGFloat = 10
  @IBInspectable var bounceScale: CGFloat = 0.80
  
  
  
  //MARK: - Animations
  func bounce() {
    if let bounceAnim = pop_animationForKey("Bounce") as? POPSpringAnimation {
      bounceAnim.fromValue = NSValue.init(CGPoint: CGPointMake(bounceScale, bounceScale))
      bounceAnim.toValue = NSValue.init(CGPoint: CGPointMake(1, 1))
    }
    else {
      let bounceAnim = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleXY)
      bounceAnim.springSpeed = springSpeed
      bounceAnim.springBounciness = springBounce
      bounceAnim.fromValue = NSValue.init(CGPoint: CGPointMake(bounceScale, bounceScale))
      bounceAnim.toValue = NSValue.init(CGPoint: CGPointMake(1, 1))
      _circleLayer.pop_addAnimation(bounceAnim, forKey: "Bounce")
    }
  }
  
  /**
  Compresses the circle layer by the specified bounce scale
  */
  private func _compress() {
    _animateLayer(_circleLayer, toScale: bounceScale)
  }
  
  /**
   Expands the circle layer to its original scale
  */
  private func _expand() {
    _animateLayer(_circleLayer, toScale: 1)
  }
  
  /**
   POPSpringAnimation to animate a layer by a given scale
  */
  private func _animateLayer(layer : CALayer, toScale: CGFloat) {
    
    if let bounceAnim = pop_animationForKey("BounceAnim") as? POPSpringAnimation {
      // Animation already exists, so just update the toValue
      bounceAnim.toValue = NSValue.init(CGPoint: CGPointMake(toScale, toScale))
    }
    else {
      // No animation exists so create a new one
      let bounceAnim = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleXY)
      bounceAnim.springBounciness = springBounce
      bounceAnim.springSpeed = springSpeed
      bounceAnim.toValue = NSValue.init(CGPoint: CGPointMake(toScale, toScale))
      _circleLayer.pop_addAnimation(bounceAnim, forKey: "BounceAnim")
    }
  }
  
  /**
   POPSpringAnimation to animate a given layer's background color
  */
  private func _animateCircleBackgroundColor(layer : CALayer) {
    
    if let backgroundColorAnim = pop_animationForKey("BackgroundColorAnim") as? POPSpringAnimation {
      backgroundColorAnim.toValue = isFilled ? fillColor : unfilledColor
    }
    else {
      let backgroundColorAnim = POPSpringAnimation.init(propertyNamed: kPOPLayerBackgroundColor)
      backgroundColorAnim.toValue = isFilled ? fillColor : unfilledColor
      _circleLayer.pop_addAnimation(backgroundColorAnim, forKey: "BackgroundColorAnim")
    }
  }
  
  
  //MARK: - Touch Controls
  internal func _touchUpInsideHandler() {
    isFilled = !isFilled
    _expand()
  }
  
  internal func _touchDownHandler() {
    _compress()
  }
  
  private func _setupTouchControls() {
  
    self.addTarget(self, action: "_touchUpInsideHandler", forControlEvents: .TouchUpInside)
    self.addTarget(self, action: "_touchDownHandler", forControlEvents: .TouchDown)
    self.addTarget(self, action: "_touchUpInsideHandler", forControlEvents: .TouchDragExit)
  }
  
  
  //MARK: - Setup & Layout
  private func _setup() {
    _setupLayout()
    _setupTouchControls()
    
    
  }
  
  private func _setupLayout() {
    self.layer.addSublayer(_circleLayer)
    _updateLayoutProperties()
  }
  
  private func _updateLayoutProperties() {
    
    // The circle layer will always be in the center of its super layer.
    _circleLayer.anchorPoint = CGPointMake(0.5, 0.5)
    _circleLayer.position = CGPointMake(CGRectGetMidX(self.layer.bounds), CGRectGetMidY(self.layer.bounds))
    
    // Size
    _circleLayer.bounds = CGRectMake(0, 0, circleSize, circleSize)
    
    // Corner Radius
    _circleLayer.cornerRadius = CGRectGetHeight(_circleLayer.bounds) / 2
    
    // Fill Properties
    _circleLayer.backgroundColor = isFilled ? fillColor.CGColor : unfilledColor.CGColor
    _animateCircleBackgroundColor(_circleLayer)
    
    // Border Properties
    _circleLayer.borderWidth = isFilled ? fillBorderWidth : unfilledBorderWidth
    _circleLayer.borderColor = isFilled ? fillBorderColor.CGColor : unfilledBorderColor.CGColor

  }
  
   override func layoutSubviews() {
    super.layoutSubviews()
    _updateLayoutProperties()
  }
  
  //MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    _setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    _setup()
  }
  

  
}
