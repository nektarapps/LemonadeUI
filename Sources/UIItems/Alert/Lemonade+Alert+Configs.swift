//
//  Lemonade+Alert+Configs.swift
//  LemonadeUI
//
//  Created by Mac on 15.09.2021.
//

/// Alert configuration options
public struct LemonadeAlertConfig {
    
    /// Icon for alert
    var icon            : UIImage?
    
    /// Title
    var title           : LemonadeText
    
    /// Description of alert
    var message         : LemonadeText?
    
    /// Default Alert States
    var alertState      : LemonadeAlertState
    
    /// Animation Position
    var position        : LemonadePosition
    
    /// Auto Close Duration default value is 0.0
    var closeDuration   : Int
    
    
    /**
     Configure init function
     
     - parameter state:Default Alert States.
     - parameter position:Animation Position.
     - parameter icon:Icon for alert. Default value is nil
     - parameter title:Title
     - parameter message:/// Description of alert. Default value is nil
     - parameter closeDuration:Auto Close Duration default value is 0.0
     - returns: none
     - warning: none
     # Notes: #
     1. none
     */

    public init( _ state : LemonadeAlertState
                 , position : LemonadePosition
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
