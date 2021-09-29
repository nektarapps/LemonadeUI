//
//  Lemonade+Line+Chart+Config.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 29.09.2021.
//


public struct LemonadeLineChartConfig {
    var items : [LemonadeChartItem]
    var color : UIColor
    
    
    public init(items : [LemonadeChartItem] , color : UIColor) {
        self.items = items
        self.color = color
    }
    internal var max : CGFloat {
        return items.map{$0.value}.max() ?? 0.0
    }
    internal var min : CGFloat {
        return items.map{$0.value}.min() ?? 0.0
    }
}

public struct LemonadeChartItem {
    var XAxisText : LemonadeText?
    var YAxisText : LemonadeText?
    var value     : CGFloat
    var color     : UIColor
    
    public init(xAxisText : LemonadeText
                , yAxisText : LemonadeText
                , value : CGFloat
                , color : UIColor = .black) {
        self.XAxisText = xAxisText
        self.YAxisText = yAxisText
        self.value     = value
        self.color     = color
    }
}
