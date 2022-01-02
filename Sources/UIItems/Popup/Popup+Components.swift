//
//  Popup+Components.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 2.01.2022.
//

public enum LemonadePopupComponents {
    case label(text: LemonadeText)
    case singleButton(button: LemonadeButton)
    case sideButtons(buttons: [LemonadeButton], spacing: CGFloat)
    case textView(placeholder: LemonadeText, text: LemonadeText)
    case textfield(placeholder: LemonadeText, text: LemonadeText)
    case spacer(height: CGFloat)
    case custuom(view: UIView, height: CGFloat?)
    
    
    var view: UIView {
        switch self {
        case .label(let text):
            return LemonadeLabel.init(frame: .zero, text)
        case .singleButton(let button):
            return button
        case .sideButtons(let buttons, let spacing):
            let stackView: UIStackView = UIStackView(arrangedSubviews: buttons)
            stackView.axis = .horizontal
            stackView.spacing = spacing
            stackView.distribution = .fillEqually
            return stackView
        case .textView(let placeholder, let text):
            return LemonadeTextView(frame: .zero, textContainer: .init(), text: text, placeholder: placeholder)
        case .textfield(let placeholder, let text):
            return LemonadeTextfield(frame: .zero, text: text, placeholder: placeholder)
        case .spacer(let height):
            let view: UIView = .init(frame: .zero, color: .init(backgroundColor: .clear))
            view.height(constant: height)
            return view
        case .custuom(let view, let height):
            if let height = height {
                view.height(constant: height)
            }
            return view
        }
    }
}
