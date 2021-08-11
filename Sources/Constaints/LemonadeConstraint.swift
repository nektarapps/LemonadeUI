//
//  LemonadeConstraint.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 11.08.2021.
//

import UIKit


public enum LemonadeConstraint {
    case top
    case bottom
    case left
    case right
    
    case centerX
    case centerY
}
extension LemonadeConstraint {
    fileprivate func anchor( _ view : UIView) -> Any {
        switch self {
        case .left:return view.leftAnchor
        case .right:return view.rightAnchor
        case .bottom:return view.bottomAnchor
        case .centerX:return view.centerXAnchor
        case .centerY:return view.centerYAnchor
        case .top:return view.topAnchor
        }
    }
    /**
     Constraint set function
     
     - parameter to: Anchor will connect to this View
     - parameter equalTo: Anchor Type
     - parameter constant: Margin between to view. Default value 0.0
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    internal func equalToConstraint(currentView : UIView
                                    , to : UIView
                                    , equalTo : LemonadeConstraint
                                    , constant : CGFloat = 0.0) {
        guard let currentViewAnchor = self.anchor(currentView) as? NSLayoutAnchor<AnyObject> else { return }
        guard let equalToAnchor = equalTo.anchor(to) as? NSLayoutAnchor<AnyObject> else { return }
        currentViewAnchor.constraint(equalTo: equalToAnchor , constant: constant).isActive = true
    }
}


public enum LemonadeConstraintBounds {
    case width
    case height
}
extension LemonadeConstraintBounds {
    
    ///Sending a anchor type
    fileprivate func anchor( _ view : UIView) -> NSLayoutDimension {
        switch self {
        case .width:return view.widthAnchor
        case .height:return view.heightAnchor
        }
    }
    
    
    /**
     Equal to width / height some view with multiplier and constant values
     
     - parameter currentView: Which view will be use.
     - parameter to: Which UI item will connect to
     - parameter equalTo: Anchor type
     - parameter constant: Margin between to view. Default value 0.0
     - parameter multiplier: Multiple to connected View height anchor
     */
    internal func equalTo( currentView : UIView
                           , to : UIView
                           , equalTo : LemonadeConstraintBounds
                           , constant : CGFloat = 0.0
                           , multiplier : CGFloat = 1.0) {
        let currentViewAnchor = self.anchor(currentView)
        let equalViewAnchor = equalTo.anchor(to)
        currentViewAnchor.constraint(equalTo: equalViewAnchor, multiplier: multiplier, constant: constant).isActive = true
    }
    /**
     View constant
     
     - parameter currentView: Which view will be use.
     - parameter constant: Size
     */
    internal func constant(currentView : UIView , constant : CGFloat) {
        let currentViewAnchor = self.anchor(currentView)
        currentViewAnchor.constraint(equalToConstant: constant).isActive = true
    }
}
