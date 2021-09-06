//
//  LemonadeConstraint+View.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 11.08.2021.
//

import UIKit


extension UIView {
    
    /**
     Filling all views with padding. Default padding values 0.0
     
     - parameter padding: Default values 0.0.
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func fill2SuperView( _ padding : LemonadePadding = .init()){
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.top(superview!, equalTo: .top , constant: padding.top)
        self.left(superview!, equalTo: .left , constant: padding.left)
        self.right(superview!, equalTo: .right , constant: -padding.right)
        self.bottom(superview!, equalTo: .bottom , constant: -padding.bottom)
    }
    
    public func center(to : UIView , width : CGFloat , height : CGFloat) {
        self.centerX(to, equalTo: .centerX)
        self.centerY(to, equalTo: .centerY)
        self.width(constant: width)
        self.height(constant: height)
    }
    
    public func center(to : UIView) {
        self.centerX(to, equalTo: .centerX)
        self.centerY(to, equalTo: .centerY)
    }
    
    
    
    /**
     Width and Height equal anchor settings
     
     - parameter to: Anchor will connect to this View
     - parameter equalTo: Anchor Type
     - parameter constant: Margin between to view. Default value 0.0
     - parameter multiplier: Multiple to connected View height anchor
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func widthAndHeight( _ to : UIView , equalTo : LemonadeConstraintBounds , constant : CGFloat = 0.0 , multiplier : CGFloat = 1.0 , safeArea : Bool = false) {
        self.height(to, equalTo: equalTo, constant: constant, multiplier: multiplier, safeArea: safeArea)
        self.width(to, equalTo: equalTo, constant: constant, multiplier: multiplier, safeArea: safeArea)
    }
    
    /**
     Width and Height constant value
     
     - parameter constant: Bound value
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func widthAndHeight(constant : CGFloat) {
        self.height(constant: constant)
        self.width(constant: constant)
    }
    
    
    public func leftAndRight( _ to : UIView , constant : CGFloat = 0.0 , safeArea : Bool = false) {
        self.left(to, equalTo: .left, constant: constant, safeArea: safeArea)
        self.right(to, equalTo: .right, constant: -constant, safeArea: safeArea)
    }
    
    /// Ratio
}

extension UIView {
    
    
    
    
    
    /**
     Left anchor settings
     
     - parameter to: Anchor will connect to this View
     - parameter equalTo: Anchor Type
     - parameter constant: Margin between to view. Default value 0.0
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func left( _ to : UIView , equalTo : LemonadeConstraint , constant : CGFloat = 0.0 , safeArea : Bool = false) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constaint : LemonadeConstraint = .left
        constaint.equalToConstraint(currentView: self, to: to, equalTo: equalTo , constant: constant , safeArea: safeArea)
    }
    /**
     Right anchor settings
     
     - parameter to: Anchor will connect to this View
     - parameter equalTo: Anchor Type
     - parameter constant: Margin between to view. Default value 0.0
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func right( _ to : UIView , equalTo : LemonadeConstraint , constant : CGFloat = 0.0 , safeArea : Bool = false) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constaint : LemonadeConstraint = .right
        constaint.equalToConstraint(currentView: self, to: to, equalTo: equalTo , constant: constant , safeArea: safeArea)
    }
    /**
     Top anchor settings
     
     - parameter to: Anchor will connect to this View
     - parameter equalTo: Anchor Type
     - parameter constant: Margin between to view. Default value 0.0
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func top( _ to : UIView , equalTo : LemonadeConstraint , constant : CGFloat = 0.0 , safeArea : Bool = false) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constaint : LemonadeConstraint = .top
        constaint.equalToConstraint(currentView: self, to: to, equalTo: equalTo , constant: constant , safeArea: safeArea)
    }
    /**
     Bottom anchor settings
     
     - parameter to: Anchor will connect to this View
     - parameter equalTo: Anchor Type
     - parameter constant: Margin between to view. Default value 0.0
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func bottom( _ to : UIView , equalTo : LemonadeConstraint , constant : CGFloat = 0.0 , safeArea : Bool = false) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constaint : LemonadeConstraint = .bottom
        constaint.equalToConstraint(currentView: self, to: to, equalTo: equalTo , constant: constant , safeArea: safeArea)
    }
    /**
     CenterX anchor settings
     
     - parameter to: Anchor will connect to this View
     - parameter equalTo: Anchor Type
     - parameter constant: Margin between to view. Default value 0.0
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func centerX( _ to : UIView , equalTo : LemonadeConstraint , constant : CGFloat = 0.0 , safeArea : Bool = false) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constaint : LemonadeConstraint = .centerX
        constaint.equalToConstraint(currentView: self, to: to, equalTo: equalTo , constant: constant , safeArea: safeArea)
    }
    /**
     CenterY anchor settings
     
     - parameter to: Anchor will connect to this View
     - parameter equalTo: Anchor Type
     - parameter constant: Margin between to view. Default value 0.0
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func centerY( _ to : UIView , equalTo : LemonadeConstraint , constant : CGFloat = 0.0 , safeArea : Bool = false) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constaint : LemonadeConstraint = .centerY
        constaint.equalToConstraint(currentView: self, to: to, equalTo: equalTo , constant: constant , safeArea: safeArea)
    }
}
extension UIView {
    /**
     Width equal anchor settings
     
     - parameter to: Anchor will connect to this View
     - parameter equalTo: Anchor Type
     - parameter constant: Margin between to view. Default value 0.0
     - parameter multiplier: Multiple to connected View Width anchor
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func width( _ to : UIView  , equalTo : LemonadeConstraintBounds , constant : CGFloat = 0.0 , multiplier : CGFloat = 1.0 , safeArea : Bool = false) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint : LemonadeConstraintBounds = .width
        constraint.equalTo(currentView: self, to: to, equalTo: equalTo, constant: constant, multiplier: multiplier , safeArea: safeArea)
    }
    /**
     Width value
     
     - parameter constant: Bound value
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func width(constant : CGFloat) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint : LemonadeConstraintBounds = .width
        constraint.constant(currentView: self, type: .width, constant: constant)
    }
    /**
     Height equal anchor settings
     
     - parameter to: Anchor will connect to this View
     - parameter equalTo: Anchor Type
     - parameter constant: Margin between to view. Default value 0.0
     - parameter multiplier: Multiple to connected View height anchor
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func height( _ to : UIView  , equalTo : LemonadeConstraintBounds , constant : CGFloat = 0.0 , multiplier : CGFloat = 1.0 , safeArea : Bool = false) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint : LemonadeConstraintBounds = .height
        constraint.equalTo(currentView: self, to: to, equalTo: equalTo, constant: constant, multiplier: multiplier , safeArea: safeArea ) 
    }
    /**
     Height value
     
     - parameter constant: Bound value
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func height(constant : CGFloat) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint : LemonadeConstraintBounds = .height
        constraint.constant(currentView: self, type: .height, constant: constant)
    }
}
