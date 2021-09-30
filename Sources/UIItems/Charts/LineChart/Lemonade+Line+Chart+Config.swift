//
//  Lemonade+Line+Chart+Config.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 29.09.2021.
//


public struct LemonadeLineChartConfig {
    var items : [LemonadeChartItem]
    var color : UIColor
    var animate : Bool
    
    
    public init(items : [LemonadeChartItem] , color : UIColor , animate : Bool) {
        self.items = items
        self.color = color
        self.animate = animate
    }
}

public struct LemonadeChartItem {
    var XAxisText : LemonadeText?
    var YAxisText : LemonadeText?
    var value     : CGFloat
    var color     : UIColor
    var lineWidth : CGFloat
    
    public init(xAxisText : LemonadeText? = nil
                , yAxisText : LemonadeText? = nil
                , value : CGFloat
                , color : UIColor = .black
                , lineWidth : CGFloat = 3.0) {
        self.XAxisText = xAxisText
        self.YAxisText = yAxisText
        self.value     = value
        self.color     = color
        self.lineWidth = lineWidth
    }
}
