//
//  Lemonade+Alert+Configs.swift
//  LemonadeUI
//
//  Created by Mac on 15.09.2021.
//

public struct LemonadeAlertConfig {
    var icon            : UIImage?
    var title           : LemonadeText
    var message         : LemonadeText?
    var alertState      : LemonadeAlertState
    var position        : LemonadeAlertPosition
    var closeDuration   : Int
    
    public init( _ state : LemonadeAlertState
                 , position : LemonadeAlertPosition
                 , icon : UIImage? = nil
                 , title : LemonadeText
                 , message : LemonadeText? = nil
                 , closeDuration : Int = 0
                 ) {
        
        self.alertState             = state
        self.icon                   = icon
        self.title                  = title
        self.message                = message
        self.position               = position
        self.closeDuration          = closeDuration
    }
}

public enum LemonadeAlertPosition {
    case top
    case bottom
    case left
    case right
}





public enum LemonadeAlertState {
    case Warning
    case Error
    case Success
    case Custom(color : LemonadeColor)
    
    var alertColor : LemonadeColor {
        switch self {
        case .Error:
            return .init(backgroundColor: .systemRed)
        case .Warning:
            return .init(backgroundColor: .systemYellow)
        case .Success:
            return .init(backgroundColor: .systemGreen)
        case .Custom(let color):
            return color
        }
    }
}
