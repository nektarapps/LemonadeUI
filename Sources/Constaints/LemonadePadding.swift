//
//  LemonadePadding.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 11.08.2021.
//


///Padding type
public struct LemonadePadding {
    var top         : CGFloat
    var left        : CGFloat
    var right       : CGFloat
    var bottom      : CGFloat
    
    
    /// Padding init default values = 0.0
    public init(right : CGFloat = 0.0 , left : CGFloat = 0.0 , top : CGFloat = 0.0 ,  bottom : CGFloat = 0.0){
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
    }
}
