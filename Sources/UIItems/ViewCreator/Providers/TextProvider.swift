//
//  TextProvider.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 9.04.2022.
//

import Foundation


public class TextProvider: ViewProvider<LemonadeLabel> {
    var text: LemonadeText?
    
    public init(backgroundColor: LemonadeColor? = nil, radius: LemonadeRadius? = nil, border: LemonadeBorder? = nil, shadow: LemonadeShadow? = nil,text: LemonadeText?) {
        if let text = text {
            self.text = text
        }
        
        super.init(backgroundColor: backgroundColor, radius: radius, border: border, shadow: shadow)
    }
    
    public override func applyModifiers() -> LemonadeLabel {
        let label = super.applyModifiers()
        if let text = text { label.text(text) }
        return label
    }
}
