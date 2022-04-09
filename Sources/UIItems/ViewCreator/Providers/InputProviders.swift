//
//  InputProviders.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 9.04.2022.
//

import Foundation


public class TextfieldProvider: ViewProvider<LemonadeTextfield> {
    
    weak var delegate: LemonadeTextFieldDelegate?
    var placeholder: LemonadeText?
    var text: LemonadeText?
    var textLimits: [TextLimitType]?
    var regexType: RegexType?
    
    public init(backgroundColor: LemonadeColor? = nil
                         , radius: LemonadeRadius? = nil
                         , border: LemonadeBorder? = nil
                         , shadow: LemonadeShadow? = nil
                         , delegate: LemonadeTextFieldDelegate? = nil
                         , placeholder: LemonadeText? = nil
                         , text:LemonadeText?
                         , limits: [TextLimitType]? = nil
                         , regex: RegexType? = nil) {
        
        self.delegate = delegate
        self.placeholder = placeholder
        self.text = text
        self.textLimits = limits
        self.regexType = regex
        
        super.init(backgroundColor: backgroundColor, radius: radius, border: border, shadow: shadow)
    }
    
    public override func applyModifiers() -> LemonadeTextfield {
        let textfield = super.applyModifiers()
        
        textfield.lemonadeDelegate = delegate
        
        if let placeholder = placeholder {
            textfield.placeholder(placeholder)
        }
        
        if let text = text {
            textfield.text(text)
        }
        
        if let textLimits = textLimits {
            textfield.addTextLimits(types: textLimits)
        }
        
        if let regexType = regexType {
            textfield.addRegex(type: regexType)
        }
        return textfield
    }
    
}
