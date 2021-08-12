//
//  Config+Animation.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 12.08.2021.
//


public struct LemonadeAnimationConfig {
    var duration    : CGFloat = 0
    var repeatCount : CGFloat? = nil
    var autoReverse : Bool = false
    
    
    /**
     Animation config
     
     - parameter duration: Animation duration time.
     - parameter repeatCount: Animation repeat value. Default is nil
     - parameter autoReverse: Animation reverse. If it is true , animation will reverse with same settings. Default is false
     */
    public init(duration : CGFloat , repeatCount : CGFloat? = nil , autoReverse : Bool = false) {
        self.duration = duration
        self.repeatCount = repeatCount
        self.autoReverse = autoReverse
    }
}
