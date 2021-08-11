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
    public func left( _ to : UIView , equalTo : LemonadeConstraint , constant : CGFloat = 0.0) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constaint : LemonadeConstraint = .left
        constaint.equalToConstraint(currentView: self, to: to, equalTo: equalTo , constant: constant)
    }
    /**
     Right anchor settings
     
     - parameter to: Anchor will connect to this View
     - parameter equalTo: Anchor Type
     - parameter constant: Margin between to view. Default value 0.0
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func right( _ to : UIView , equalTo : LemonadeConstraint , constant : CGFloat = 0.0) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constaint : LemonadeConstraint = .right
        constaint.equalToConstraint(currentView: self, to: to, equalTo: equalTo , constant: constant)
    }
    /**
     Top anchor settings
     
     - parameter to: Anchor will connect to this View
     - parameter equalTo: Anchor Type
     - parameter constant: Margin between to view. Default value 0.0
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func top( _ to : UIView , equalTo : LemonadeConstraint , constant : CGFloat = 0.0) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constaint : LemonadeConstraint = .top
        constaint.equalToConstraint(currentView: self, to: to, equalTo: equalTo , constant: constant)
    }
    /**
     Bottom anchor settings
     
     - parameter to: Anchor will connect to this View
     - parameter equalTo: Anchor Type
     - parameter constant: Margin between to view. Default value 0.0
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func bottom( _ to : UIView , equalTo : LemonadeConstraint , constant : CGFloat = 0.0) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constaint : LemonadeConstraint = .bottom
        constaint.equalToConstraint(currentView: self, to: to, equalTo: equalTo , constant: constant)
    }
    /**
     CenterX anchor settings
     
     - parameter to: Anchor will connect to this View
     - parameter equalTo: Anchor Type
     - parameter constant: Margin between to view. Default value 0.0
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func centerX( _ to : UIView , equalTo : LemonadeConstraint , constant : CGFloat = 0.0) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constaint : LemonadeConstraint = .centerX
        constaint.equalToConstraint(currentView: self, to: to, equalTo: equalTo , constant: constant)
    }
    /**
     CenterY anchor settings
     
     - parameter to: Anchor will connect to this View
     - parameter equalTo: Anchor Type
     - parameter constant: Margin between to view. Default value 0.0
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    public func centerY( _ to : UIView , equalTo : LemonadeConstraint , constant : CGFloat = 0.0) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constaint : LemonadeConstraint = .centerY
        constaint.equalToConstraint(currentView: self, to: to, equalTo: equalTo , constant: constant)
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
    public func width( _ to : UIView  , equalTo : LemonadeConstraintBounds , constant : CGFloat = 0.0 , multiplier : CGFloat = 1.0) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint : LemonadeConstraintBounds = .width
        constraint.equalTo(currentView: self, to: to, equalTo: equalTo, constant: constant, multiplier: multiplier)
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
        constraint.constant(currentView: self, constant: constant)
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
    public func height( _ to : UIView  , equalTo : LemonadeConstraintBounds , constant : CGFloat = 0.0 , multiplier : CGFloat = 1.0) {
        if superview == nil { fatalError( LemonadeConstraintError.superViewError.rawValue )}
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint : LemonadeConstraintBounds = .height
        constraint.equalTo(currentView: self, to: to, equalTo: equalTo, constant: constant, multiplier: multiplier)
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
        constraint.constant(currentView: self, constant: constant)
    }
}
