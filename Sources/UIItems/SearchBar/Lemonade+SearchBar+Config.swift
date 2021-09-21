//
//  Lemonade+SearchBar+Config.swift
//  LemonadeUI
//
//  Created by Mac on 21.09.2021.
//

public enum LemonadeSearchState {
    case isSearching
    case Focussed
    case NotFocuessed
}


public struct LemonadeSearchBarConfig {
    var leftImage : UIImage?
    var rigthImage : UIImage?
    var buttons : [LemonadeButton]
    var buttonPositions : LemonadePosition
    
    public init(leftImage : UIImage? , rigthImage : UIImage? , buttons : [LemonadeButton] = [] , position: LemonadePosition = .right) {
        self.leftImage = leftImage
        self.rigthImage = rigthImage
        self.buttons = buttons
        self.buttonPositions = position
    }
}
