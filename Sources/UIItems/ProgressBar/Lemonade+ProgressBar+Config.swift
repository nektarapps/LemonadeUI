//
//  Lemonade+ProgressBar+Config.swift
//  LemonadeUI
//
//  Created by Mac on 16.09.2021.
//


public enum LemonadeProgressBarAlignment {
    case horizontal
    case vertical
}

public enum LemonadeProgressBarText {    
    case none
    case auto(initialText : LemonadeText)
    case custom(text : LemonadeText)
    
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
    var alignment : LemonadeProgressBarAlignment
    var textType  : LemonadeProgressBarText
    var starterPercentage : CGFloat
    var automaticProgressDuration : Int
    var progressView : UIView
    
    
    public init(alignment : LemonadeProgressBarAlignment
                , textType : LemonadeProgressBarText
                , starterPercentage : CGFloat = 0.0
                , automaticProgressDuration : Int = 0
                , progressColor : UIView) {
        self.alignment = alignment
        self.textType = textType
        self.starterPercentage = starterPercentage
        self.automaticProgressDuration = automaticProgressDuration
        self.progressView = progressColor
    }
}
