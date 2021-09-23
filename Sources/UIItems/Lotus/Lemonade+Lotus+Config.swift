//
//  Lemonade+Lotus+Config.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 23.09.2021.
//

import CoreGraphics



public struct LemonadeLotusConfig {
    var petalColor : UIColor
    var numberOfItems : Int
    var rotateAngle : CGFloat
    var pattern : [LemonadeLotusAnimationPattern]
    
    
    public init(petal : UIColor
                , numberOfItems : Int
                , pattern : [LemonadeLotusAnimationPattern] = []
                , angle : CGFloat = -CGFloat.pi) {
        self.petalColor = petal
        self.numberOfItems = numberOfItems
        self.pattern = pattern
        self.rotateAngle = angle
    }
}


public enum LemonadeLotusAnimationPosition : Equatable {
    case sleep
    case awake
}
public struct LemonadeLotusAnimationPattern {
    var duration : CGFloat
    var position : LemonadeLotusAnimationPosition
    
    
    public init(duration : CGFloat , position : LemonadeLotusAnimationPosition) {
        self.duration = duration
        self.position = position
    }
}
