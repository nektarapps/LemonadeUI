//
//  Lemonade+SearchBar+Config.swift
//  LemonadeUI
//
//  Created by Mac on 21.09.2021.
//

public enum LemonadeSearchState {
    /// When use typing some text
    case isSearching
    /// Focussed but not typing , equal = ""
    case Focussed
    /// Not focussed
    case NotFocuessed
}


public struct LemonadeSearchBarConfig {
    /// Custom left side View
    var leftView : UIView?
    /// Left Image to textfield
    var leftImage : UIImage?
    /// Custom Rigth side View
    var rigthView : UIView?
    /// Rigth Image to textfield
    var rigthImage : UIImage?
    /// Addtional Button
    var buttons : [LemonadeButton]
    /// Buttons position , (left and right)
    var buttonPositions : LemonadePosition
    
    /**
     Configure Init function
     
     - parameter leftImage: Left Image to textfield.
     - parameter rigthImage: Rigth Image to textfield.
     - parameter buttons: Addtional Button.
     - parameter buttonPositions: Buttons position , (left and right).
     */
    public init(leftView : UIView? = nil , leftImage : UIImage? , rigthView : UIView? = nil , rigthImage : UIImage? , buttons : [LemonadeButton] = [] , position: LemonadePosition = .right) {
        self.leftView = leftView
        self.rigthView = rigthView
        self.leftImage = leftImage
        self.rigthImage = rigthImage
        self.buttons = buttons
        self.buttonPositions = position
    }
}
