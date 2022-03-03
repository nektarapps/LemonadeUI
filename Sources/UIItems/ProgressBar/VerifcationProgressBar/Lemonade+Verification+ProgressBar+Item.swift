//
//  Lemonade+Verification+ProgressBar+Item.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 3.03.2022.
//

import Foundation

public struct LemonadeVerificationProgressBarItem {
    var iconName: String
    var text: LemonadeText
    
    public init(iconName: String, text: LemonadeText) {
        self.iconName = iconName
        self.text = text
    }
}
