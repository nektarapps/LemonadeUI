//
//  Lemonade+Pie+Chart+Config.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 24.09.2021.
//



public struct LemonadePieChartConfig {
    /// Chart Items
    var items : [LemonadePieChartItem]
    /// Animation
    var isAnimate : Bool
    
    public init( items : [LemonadePieChartItem] , isAnimate : Bool) {
        self.items = items
        self.isAnimate = isAnimate
    }
    
    /// Angle calculation
    internal func angles() -> [CGFloat] {
        let total = items.map{ $0.value }.reduce(0, +)
        
        var angles : [CGFloat] = []
        for item in items {
            let angle = ( item.value * 360 ) / total
            angles.append(angle)
        }
        return angles
    }
}

public struct LemonadePieChartItem {
    /// Chart Text , default is value text
    var text : LemonadeText?
    /// Pie slice value
    var value    : CGFloat
    /// Slice color
    var color    : UIColor
    /// Slice border , default is nil
    var border   : LemonadeBorder?
    
    public init( text : LemonadeText? = nil
                 , value : CGFloat
                 , color : UIColor , border : LemonadeBorder? = nil) {
        self.text     = text
        self.value    = value
        self.color    = color
        self.border   = border
    }
    
}
