//
//  Config+Lemonade+Button.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 17.08.2021.
//


public protocol LemonadeSwitchButtonDelegate : AnyObject {
    /**
     Function only trigger when tapped for toggling
     
     - parameter button: Curren Button.
     - parameter isOn: Curren state.
     */
    func didToggle( _ button : LemonadeButton , isOn : Bool)
}

public struct LemonadeSwitchButtonConfig {
    
    /// On state background color
    var activeColor : LemonadeColor
    
    /// Off state background color
    var deActiveColor : LemonadeColor
    
    /// Transition duration
    var animationDuration : Double
    
    public init(activeColor : LemonadeColor = .init(backgroundColor: .white)
                , deActiveColor : LemonadeColor = .init(backgroundColor: .brown)
                , duration : Double = 2.0) {
        self.activeColor = activeColor
        self.deActiveColor = deActiveColor
        self.animationDuration = duration
    }
}

public struct LemonadeSwitchToggleConfig {
    /// On state toggle color
    var activeColor : LemonadeColor
    
    /// Off state toggle color
    var deActiveColor : LemonadeColor
    
    /// Toggle view border
    var border : LemonadeBorder
    
    /// Initial state true = ON false = OFF
    var isOn : Bool
    
    /// Padding Between view and toggle
    var padding : CGFloat
    
    /// Toggle width
    var width : CGFloat
    
    /// Toggle height
    var height : CGFloat
    
    public init( isOn : Bool
                 , activeColor : LemonadeColor = .init(backgroundColor: .red)
                 , deActiveColor : LemonadeColor = .init(backgroundColor: .yellow)
                 , border : LemonadeBorder = .init(borderColor: .blue, width: 2.0)
                 , padding : CGFloat = 4.0
                 , width : CGFloat = 24
                 , height : CGFloat = 24) {
        self.isOn = isOn
        self.padding = padding
        self.activeColor = activeColor
        self.deActiveColor = deActiveColor
        self.border = border
        self.width = width
        self.height = height
    }
    
    /// isOn Change
    mutating func onChange( _ isOn : Bool) {
        self.isOn = isOn
    }
}
