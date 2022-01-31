//
//  Form+Configuration.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 30.01.2022.
//

import Foundation

public struct LemonadeFormConfiguration {
    
    var components: [LemonaedFormComponents]
    
    var formTitleText: LemonadeText
    
    var formActionButton: LemonadeButton
    
    var spacingBetweenItems: CGFloat
    
    public init(components: [LemonaedFormComponents]
                , titleText: LemonadeText
                , formButton: LemonadeButton , spacingBetweenItems: CGFloat = 10.0) {
        self.components = components
        self.formTitleText = titleText
        self.formActionButton = formButton
        self.spacingBetweenItems = spacingBetweenItems
    }
}
