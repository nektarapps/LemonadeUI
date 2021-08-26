//
//  Lemonade+ToolTip+Config.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 26.08.2021.
//




public struct LemonadeToolTipConfig {
    var isAnimate : Bool = false
    var text : LemonadeText?
    var textBackgroundColor : LemonadeColor?
    var view : UIView
    var duration : Int?
    
    public init(view : UIView , isAnimate : Bool = false , duration : Int? = nil , text : LemonadeText? = nil , textBackgroundColor : LemonadeColor? = nil){
        self.view = view
        self.isAnimate = isAnimate
        self.duration = duration
        self.text = text
        self.textBackgroundColor = textBackgroundColor
    }
}
