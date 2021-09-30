//
//  Lemonade+Slider+Config.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 30.09.2021.
//

import Foundation



public struct LemonadeSliderConfig {
    var startValue : CGFloat
    var endValue   : CGFloat
    var height     : CGFloat
    var thumbConfig : LemonadeThumbConfig
    var secondThumbConfig : LemonadeThumbConfig?
    var minDistaceBetweenThumbs : Int
    
    
    public init(startValue : CGFloat = 0.0
                , endValue : CGFloat = 100.0
                , sliderHeight : CGFloat = 3.0
                , thumbConfig : LemonadeThumbConfig
                , secondThumbConfig : LemonadeThumbConfig? = nil , minimumDistanceBetweenThumns : Int = 0) {
        self.startValue = startValue
        self.endValue = endValue
        self.height = sliderHeight
        self.thumbConfig = thumbConfig
        self.secondThumbConfig = secondThumbConfig
        self.minDistaceBetweenThumbs = minimumDistanceBetweenThumns
    }
    
}

public struct LemonadeThumbConfig {
    var color      : UIColor
    var value      : CGFloat
    var height     : CGFloat
    var border     : LemonadeBorder
    
    
    public init( color : UIColor , value : CGFloat , height : CGFloat , border : LemonadeBorder = .init(borderColor: .black, width: 2.0)) {
        self.color = color
        self.value  = value
        self.height = height
        self.border = border
    }
}
