//
//  ButtonProvider.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 9.04.2022.
//

import Foundation


public class ButtonProvider: ViewProvider<LemonadeButton> {
    var text:LemonadeText?
    var action: ()->()?
    
    public init(backgroundColor: LemonadeColor? = nil, radius: LemonadeRadius? = nil, border: LemonadeBorder? = nil, shadow: LemonadeShadow? = nil,text: LemonadeText?
                , action: @escaping ()-> ()) {
        if let text = text {
            self.text = text
        }
        self.action = action
        super.init(backgroundColor: backgroundColor, radius: radius, border: border, shadow: shadow)
    }
    public override func applyModifiers() -> LemonadeButton {
        let button = super.applyModifiers()
        if let text = text {
            button.text(text)
        }
        button.addAction {
            self.action()
        }
        return button
    }
}
