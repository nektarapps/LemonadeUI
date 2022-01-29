//
//  Lemonade+Circle+Progress+Bar+Config.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 30.01.2022.
//

public struct LemonadeCircleProgessBarItem {
    /// Position Value between 0 - 360
    var positionValue : CGFloat
    /// Bar tintColor
    var barTintColor: UIColor
    /// Progress Color
    var progressColor: UIColor
    /// Width
    var lineWidth: CGFloat
    /// Stroke Animation
    var isAnimate: Bool
    /// Duration
    var animateDuration: CGFloat
    
    public init(positionValue: CGFloat
                , barTintColor: UIColor
                , progressColor: UIColor
                , lineWidth: CGFloat
                , isAnimate: Bool = true
                , animateDuration: CGFloat = 2.0) {
        self.positionValue = positionValue < 0 ? 0 : positionValue > 360 ? 360 : positionValue
        self.barTintColor = barTintColor
        self.progressColor = progressColor
        self.lineWidth = lineWidth
        self.isAnimate = isAnimate
        self.animateDuration = animateDuration
    }
}
extension LemonadeCircleProgessBarItem {
    /// End angle value depends on poisitionValue
    func angleValue() -> CGFloat {
        return (positionValue / 180) * .pi
    }
}



public struct LemonadeCircleProgessBarConfig {
    
    /// Items
    var items: [LemonadeCircleProgessBarItem]
    /// Space between all items
    var spaceBetweenItems: CGFloat
    /// Bar text
    var barTitleText: LemonadeText
    
    
    public init(items: [LemonadeCircleProgessBarItem] , spaceBetweenItems: CGFloat = 10.0 , barTitleText:LemonadeText) {
        self.items = items
        self.spaceBetweenItems = spaceBetweenItems
        self.barTitleText = barTitleText
    }
    
}
