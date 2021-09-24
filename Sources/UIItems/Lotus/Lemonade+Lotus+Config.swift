//
//  Lemonade+Lotus+Config.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 23.09.2021.
//

public struct LemonadeLotusConfig {
    /// Circle color
    var petalColor : UIColor
    /// Number of circle
    var numberOfItems : Int
    /// Circle replicate rotation angle , default is -pi
    var rotateAngle : CGFloat
    /// Animation Pattern
    var pattern : [LemonadeLotusAnimationPatternItem]
    
    
    /**
     Config init function
     
     - parameter petal: Circle color.
     - parameter numberOfItems: Number of circle.
     - parameter pattern: Animation Pattern.Default is empty
     - parameter angle: Circle replicate rotation angle , default is -pi.
     */
    public init(petal : UIColor
                , numberOfItems : Int
                , pattern : [LemonadeLotusAnimationPatternItem] = []
                , angle : CGFloat = -CGFloat.pi) {
        self.petalColor = petal
        self.numberOfItems = numberOfItems
        self.pattern = pattern
        self.rotateAngle = angle
    }
}


public enum LemonadeLotusAnimationPosition : Equatable {
    /// Open position
    case sleep
    /// Close position
    case awake
}
public struct LemonadeLotusAnimationPatternItem {
    /// Animation duration
    public var duration : CGFloat
    /// Animation Position
    public var position : LemonadeLotusAnimationPosition
    
    
    public init(duration : CGFloat , position : LemonadeLotusAnimationPosition) {
        self.duration = duration
        self.position = position
    }
}
