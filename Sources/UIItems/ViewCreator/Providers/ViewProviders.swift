//
//  ViewProviders.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 9.04.2022.
//

import Foundation


public class ViewProvider<V : UIView> {
    var radius : LemonadeRadius?
    var color  : LemonadeColor?
    var border : LemonadeBorder?
    var shadow : LemonadeShadow?
    
    
    public init(backgroundColor: LemonadeColor? = nil, radius:LemonadeRadius? = nil, border: LemonadeBorder? = nil, shadow: LemonadeShadow? = nil) {
        self.radius = radius
        self.color = backgroundColor
        self.border = border
        self.shadow = shadow
    }
    
    
    func generateBase() -> V {
        let generatedView = V.init()
        
        if let radius = radius {
            generatedView.radius(radius)
        }
        
        if let border = border {
            generatedView.border(border)
        }
        
        if let color = color {
            generatedView.color(color)
        }
        
        return generatedView
    }
    //Override function
    public func applyModifiers() -> V { return generateBase() }
}
