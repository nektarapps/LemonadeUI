//
//  Lemonade+Verification+ProgressBar+Config.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 3.03.2022.
//

import Foundation


public struct LemonadeVerificationProgressBarConfig {
    var items: [LemonadeVerificationProgressBarItem]
    var startStep: Int
    var progressBarColor: LemonadeColor
    var activeImageBackgroundColor: LemonadeColor
    var defaultImageBackgroundColor: LemonadeColor
    var barBacgroundColor: LemonadeColor
    
    public init(items: [LemonadeVerificationProgressBarItem]
                , startStep: Int = 0
                , activeImageBackgroundColor: LemonadeColor = .init(backgroundColor: .systemGreen)
                , defaultImageBackgroundColor: LemonadeColor = .init(backgroundColor: .systemGray)
                , progressBarColor: LemonadeColor = .init(backgroundColor: .systemGreen)
                , barBackgroundColor: LemonadeColor = .init(backgroundColor: .systemGray)) {
        self.items = items
        self.startStep = startStep
        self.activeImageBackgroundColor = activeImageBackgroundColor
        self.defaultImageBackgroundColor = defaultImageBackgroundColor
        self.progressBarColor = progressBarColor
        self.barBacgroundColor = barBackgroundColor
    }
}
