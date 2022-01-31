//
//  Form+Components.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 30.01.2022.
//

public enum LemonaedFormComponents {
    case textfield(id: String
                   , title: LemonadeText
                   , placeholder: LemonadeText
                   , text: LemonadeText
                   , backgroundColor: UIColor = .white
                   , radius: LemonadeRadius? = nil
                   , border: LemonadeBorder? = nil
                   , regex: RegexType /// Regex types
                   , limitTypes: [TextLimitType] /// Limit types
                   , isSecureText: Bool /// Secure text
                   , height: CGFloat?)
    case textView(id:String
                  ,title:LemonadeText
                  , placeholder: LemonadeText
                  , text: LemonadeText
                  , backgroundColor: UIColor = .white
                  , radius: LemonadeRadius? = nil
                  , border: LemonadeBorder? = nil
                  , height: CGFloat?)
    case spacer(height: CGFloat)
    case custom(view: UIView, height: CGFloat?)
    
    
    var view: UIView {
        switch self {
        case .textfield(let id, let title, let placeholder , let text, let backgroundColor , let radius, let border, let regex, let validations , let isSecure , let height):
            let titleLabel = LemonadeLabel(frame: .zero, title)
            let input      = LemonadeTextfield(frame: .zero
                                               , text: text
                                               , placeholder: placeholder)
            input.setState(.warning)
            input.addRegex(type: regex)
            input.addTextLimits(types: validations)
            input.identifier = id
            input.isSecureTextEntry = isSecure
            input.backgroundColor = backgroundColor
            if let radius = radius { input.radius(radius) }
            if let border = border { input.border(border) }
            if let height = height { input.height(constant: height) }
            let stackView  = UIStackView(arrangedSubviews: [titleLabel , input])
            stackView.spacing = 5
            stackView.axis  = .vertical
            return stackView
        case .textView(let id, let title, let placeholder , let text, let backgroundColor , let radius, let border, let height):
            let titleLabel = LemonadeLabel(frame: .zero, title)
            let input      = LemonadeTextView(frame: .zero
                                              , textContainer: nil
                                              , text: text
                                              , placeholder: placeholder)
            input.backgroundColor = backgroundColor
            input.identifier = id
            if let radius = radius { input.radius(radius) }
            if let border = border { input.border(border) }
            if let height = height { input.height(constant: height) }
            let stackView  = UIStackView(arrangedSubviews: [titleLabel , input])
            stackView.spacing = 5
            stackView.axis  = .vertical
            return stackView
        case .spacer(let height):
            let view: UIView = .init(frame: .zero, color: .init(backgroundColor: .clear))
            view.height(constant: height)
            return view
        case .custom(let view, let height):
            if let height = height {
                view.height(constant: height)
            }
            return view
        }
    }
}


