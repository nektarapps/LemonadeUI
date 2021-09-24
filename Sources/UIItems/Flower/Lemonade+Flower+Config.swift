//
//  Lemonade+Flower+Config.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 24.09.2021.
//

import Foundation


public struct LemonadeFlowerConfig {
    
    var flowerItems : [LemonadeFlowerItem]
    /// Space between slice
    var spacing       : Float

    public init(items : [LemonadeFlowerItem] , spacing : Float) {
        self.spacing = spacing
        self.flowerItems = items
    }
    
    internal var numberOfItems : Int {
        return flowerItems.count
    }
}

public struct LemonadeFlowerItem  {
    /// Slice color
    var slideColor : LemonadeColor
    /// Slice Border
    var sliceBorder: LemonadeBorder?
    /// Custom Views for per slice
    var view       : UIView?
    
    /**
     Config init
     
     - parameter view: Custom View for per slice.
     - parameter sliceColor: Slice color.
     - parameter sliceBorder: Slice border.

     */
    public init(sliceColor : LemonadeColor , sliceBorder : LemonadeBorder? = nil , customView : UIView? = nil) {
        self.slideColor = sliceColor
        self.sliceBorder = sliceBorder
        self.view = customView
    }
}
