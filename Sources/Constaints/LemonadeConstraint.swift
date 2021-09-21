//
//  LemonadeConstraint.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 11.08.2021.
//

import UIKit


/// Alert animation positions
public enum LemonadePosition {
    case top
    case bottom
    case left
    case right
}

public enum LemonadeAlignment {
    case horizontal
    case vertical
}




public enum LemonadeConstraint : String {
    case top = "topAnchor"
    case bottom = "bottomAnchor"
    case left = "leftAnchor"
    case right = "rightAnchor"
    
    case centerX = "centerXAnchor"
    case centerY = "centerYAnchor"
}
extension LemonadeConstraint {
    fileprivate func anchor( _ view : UIView , safeArea : Bool) -> Any {
        switch self {
        case .left:return safeArea
            ? view.safeAreaLayoutGuide.leftAnchor
            : view.leftAnchor
        case .right:return safeArea
            ? view.safeAreaLayoutGuide.rightAnchor
            : view.rightAnchor
        case .bottom:return safeArea
            ? view.safeAreaLayoutGuide.bottomAnchor
            : view.bottomAnchor
        case .centerX:return safeArea
            ? view.safeAreaLayoutGuide.centerXAnchor
            : view.centerXAnchor
        case .centerY:return safeArea
            ? view.safeAreaLayoutGuide.centerYAnchor
            : view.centerYAnchor
        case .top:return safeArea
            ? view.safeAreaLayoutGuide.topAnchor
            : view.topAnchor
        }
    }
    /**
     Constraint set function
     
     - parameter to: Anchor will connect to this View
     - parameter equalTo: Anchor Type
     - parameter constant: Margin between to view. Default value 0.0
     - parameter safeArea: is Safe area active ?
     - returns: None
     - warning: If superView is nil , function will return fatalError
     */
    internal func equalToConstraint(currentView : UIView
                                    , to : UIView
                                    , equalTo : LemonadeConstraint
                                    , constant : CGFloat = 0.0
                                    , safeArea : Bool){
        guard let currentViewAnchor = self.anchor(currentView, safeArea: false) as? NSLayoutAnchor<AnyObject> else { return }
        guard let equalToAnchor = equalTo.anchor(to, safeArea: safeArea) as? NSLayoutAnchor<AnyObject> else { return }
        let anchor = currentViewAnchor.constraint(equalTo: equalToAnchor , constant: constant)
        anchor.identifier = currentView.identifier + equalTo.rawValue
        anchor.isActive = true
    }
}


public enum LemonadeConstraintBounds : String {
    case width = "width"
    case height = "height"
}
extension LemonadeConstraintBounds {
    
    ///Sending a anchor type
    fileprivate func anchor( _ view : UIView , safeArea : Bool) -> NSLayoutDimension {
        switch self {
        case .width:return safeArea
            ? view.safeAreaLayoutGuide.widthAnchor
            : view.widthAnchor
        case .height:return safeArea
            ? view.safeAreaLayoutGuide.heightAnchor
            : view.heightAnchor
        }
    }
    
    
    /**
     Equal to width / height some view with multiplier and constant values
     
     - parameter currentView: Which view will be use.
     - parameter to: Which UI item will connect to
     - parameter equalTo: Anchor type
     - parameter constant: Margin between to view. Default value 0.0
     - parameter safeArea: is Safe area active ?
     - parameter multiplier: Multiple to connected View height anchor
     */
    internal func equalTo( currentView : UIView
                           , to : UIView
                           , equalTo : LemonadeConstraintBounds
                           , constant : CGFloat = 0.0
                           , multiplier : CGFloat = 1.0
                           , safeArea : Bool) {
        let currentViewAnchor = self.anchor(currentView, safeArea: safeArea)
        let equalViewAnchor = equalTo.anchor(to, safeArea: false)
        let anchor = currentViewAnchor.constraint(equalTo: equalViewAnchor, multiplier: multiplier, constant: constant)
        anchor.identifier = currentView.identifier + "." + equalTo.rawValue
        anchor.isActive = true
    }
    /**
     View constant
     
     - parameter currentView: Which view will be use.
     - parameter constant: Size
     */
    internal func constant(currentView : UIView
                           , type : LemonadeConstraintBounds
                           , constant : CGFloat){
        let currentViewAnchor = self.anchor(currentView, safeArea: false)
        let anchor = currentViewAnchor.constraint(equalToConstant: constant)
        
        anchor.identifier = currentView.identifier + "." + type.rawValue
        anchor.isActive = true
    }
}
