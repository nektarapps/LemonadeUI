//
//  Common+View+Extensions.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 12.08.2021.
//

import UIKit




extension UIView {
    
    public convenience init(frame: CGRect , color : LemonadeColor) {
        self.init(frame: frame)
        self.color(color)
    }
    public convenience init(frame: CGRect , color : LemonadeColor , radius : LemonadeRadius) {
        self.init(frame: frame)
        self.color(color)
        self.radius(radius)
    }
    public convenience init(frame: CGRect , color : LemonadeColor , radius : LemonadeRadius , border : LemonadeBorder) {
        self.init(frame: frame)
        self.color(color)
        self.radius(radius)
        self.border(border)
    }
    public convenience init(frame: CGRect , color : LemonadeColor , radius : LemonadeRadius , border : LemonadeBorder , shadow : LemonadeShadow) {
        self.init(frame: frame)
        self.color(color)
        self.radius(radius)
        self.border(border)
        self.shadow(shadow)
    }
    
    
}





extension UIView {
    /**
     Radius change
     
     - parameter radius: LemonadeRadius requires radius paramater (Default value = 12) , corners (Optional) .
     - returns: None
     - warning: This function avaliable above iOS 11.0
     */
    public func radius( _ radius : LemonadeRadius){
        self.layer.masksToBounds = true
        self.layer.cornerRadius  = radius.radius
        if radius.maskedCorners != nil { self.layer.maskedCorners = radius.maskedCorners! }
    }
    
    
    
    /**
     Gradient painting.
     
     - warning : Call function after constraint set
     */
    public func gradient( _ gradient : LemonadeGradient , at : UInt32 = 0) {
        self.layoutIfNeeded()
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = gradient.colors
        layer.startPoint = gradient.from
        layer.endPoint = gradient.to
        layer.locations = gradient.locations
        self.layer.insertSublayer(layer, at: at)
    }
    
    
    /// Deleting gradiet layer if gradient exists
    public func removeGradient(){
        guard
            let gradient = self.layer.sublayers!.first(where: { $0.isKind(of: CAGradientLayer.self) })
        else { return }
        gradient.removeFromSuperlayer()
    }
    
    
    /// Color painting including grandient colors
    public func color( _ color : LemonadeColor) {
        if color.backgroundColor != nil { self.backgroundColor = color.backgroundColor! }
        if color.gradient != nil { self.gradient( color.gradient! ) }
    }
    
    /// Border set
    public func border( _ border : LemonadeBorder) {
        self.layer.borderWidth = border.borderWidth
        self.layer.borderColor = border.borderColor
    }
    
    
    /// Shadow set
    public func shadow( _ shadow : LemonadeShadow) {
        self.layoutIfNeeded()
        self.layer.shadowColor = shadow.shadowColor.cgColor
        self.layer.shadowOpacity = shadow.opacity
        self.layer.shadowOffset = shadow.offset
        self.layer.shadowRadius = shadow.radius
    }
}
