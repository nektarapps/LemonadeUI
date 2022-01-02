//
//  Lemonade+Slider+Config.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 30.09.2021.
//

import Foundation



public struct LemonadeSliderConfig {
    var sliderColor : UIColor
    var startValue : CGFloat
    var endValue   : CGFloat
    var height     : CGFloat
    var thumbConfig : LemonadeThumbConfig
    var thumbLabelText  : LemonadeText?
    var secondThumbConfig : LemonadeThumbConfig?
    var secondLabelText : LemonadeText?
    var minDistaceBetweenThumbs : CGFloat?
    var maskeedViewBetweenThumbs : UIView
    var isThumbsLabelsTrackProgress: Bool
    
    
    public init(sliderColor : UIColor = .black
                , startValue : CGFloat = 0.0
                , endValue : CGFloat = 100.0
                , sliderHeight : CGFloat = 3.0
                , thumbConfig : LemonadeThumbConfig
                , thumbLabelText : LemonadeText? = nil
                , secondThumbConfig : LemonadeThumbConfig? = nil
                , secondLabelText : LemonadeText? = nil
                , minimumDistanceBetweenThumns : CGFloat? = nil
                , maskedViewThumbsBetweenThumbs : UIView = .init(frame: .zero , color:.init(backgroundColor: .blue))
                , isThumbsLabelsTrackProgress: Bool = true) {
        self.sliderColor = sliderColor
        self.startValue = startValue
        self.endValue = endValue
        self.height = sliderHeight
        self.thumbConfig = thumbConfig
        self.thumbLabelText = thumbLabelText
        self.secondThumbConfig = secondThumbConfig
        self.secondLabelText = secondLabelText
        self.minDistaceBetweenThumbs = minimumDistanceBetweenThumns
        self.maskeedViewBetweenThumbs = maskedViewThumbsBetweenThumbs
        self.isThumbsLabelsTrackProgress = isThumbsLabelsTrackProgress
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
