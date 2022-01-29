//
//  Lemonade+ProgressBar+Config.swift
//  LemonadeUI
//
//  Created by Mac on 16.09.2021.
//

public enum LemonadeProgressBarText {
    /// No text
    case none
    /// Auto text , this only show percentage of value
    case auto(initialText : LemonadeText)
    /// Custom text , If you use this option , you will have to change label manually
    case custom(text : LemonadeText)
    
    /// Text value if exists
    var text : LemonadeText? {
        switch self {
        case .auto(let text) , .custom(let text):
            return text
        default:
            return nil
        }
    }
}

public struct LemonadeProgressBarConfig {
    /// Bar Alignment
    var alignment : LemonadeAlignment
    
    /// Bar text type
    var textType  : LemonadeProgressBarText
    
    /// Bar initial percentage , default is 0.0
    var starterPercentage : CGFloat
    
    /// Auto animate duration , default is 0
    var automaticProgressDuration : Int
    
    /// Custom Progress view
    var progressView : UIView
    
    
    public init(alignment : LemonadeAlignment
                , textType : LemonadeProgressBarText
                , starterPercentage : CGFloat = 0.0
                , automaticProgressDuration : Int = 0
                , progressView : UIView) {
        self.alignment = alignment
        self.textType = textType
        self.starterPercentage = starterPercentage
        self.automaticProgressDuration = automaticProgressDuration
        self.progressView = progressView
    }
}
