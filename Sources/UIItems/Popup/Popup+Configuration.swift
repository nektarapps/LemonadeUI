//
//  Popup+Configuration.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 2.01.2022.
//

import Foundation



public struct LemonadePopupConfiguration {
    ///Components
    var components: [LemonadePopupComponents]
    /// Popup backgroundColor
    var backgroundColor: LemonadeColor = .init(backgroundColor: .white)
    /// Popup radius default is 12
    var radius: LemonadeRadius = .init(radius: 12)
    /// Popup radius
    var animation: LemonadePopupAnimation
    /// Animataion duration default is 0.5
    var animationDuration: CGFloat = 0.5
    /// Left and right margin default is 0.0
    var margin: CGFloat = 0.0
}

