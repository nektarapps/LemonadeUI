//
//  Lemonade+Flower+Config.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 24.09.2021.
//

import Foundation


public struct LemonadeFlowerConfig {
    
    /// Custom Views for per slice
    var views         : [UIView]
    /// Slice count
    var numberOfItems : Int
    /// Space between slice
    var spacing       : Float
    /// Slice color
    var sliceColor    : UIColor
    
    /**
     Config init
     
     - parameter views: Custom Views for per slice.
     - parameter numberOfItems: Slice count.
     - parameter spacing: Space between slice.
     - parameter sliceColor: Slice color.

     */
    public init(views : [UIView] = [] , numberOfItems : Int , spacing : Float , sliceColor : UIColor) {
        self.views = views
        self.numberOfItems = numberOfItems
        self.spacing = spacing
        self.sliceColor = sliceColor
    }
}
