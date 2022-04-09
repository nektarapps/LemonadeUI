//
//  Lemonade+View+Creator+Components.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 9.04.2022.
//

import Foundation

public enum ViewCreatorComponentType {
    case axis(axis: ViewCreatorAxis)
    case button(provider: ButtonProvider, height: CGFloat?)
    case text(provider: TextProvider)
    case textfield(provider: TextfieldProvider, height: CGFloat?)
    case imageView(provider: ImageProvider, width: CGFloat? , height: CGFloat?)
    case spacer(height: CGFloat)
    case customView(view: UIView)
    
    func generateView() -> UIView {
        var generatedView: UIView
        switch self {
        case .axis(let axis):
            generatedView = axis.generateStackView()
        case .button(let provider,  let height):
            let button = provider.applyModifiers()
            if let height = height { button.height(constant: height) }
            generatedView = button
        case .text(let provider):
            generatedView = provider.applyModifiers()
        case .textfield(let provider , let height):
            let textfield = provider.applyModifiers()
            if let height = height { textfield.height(constant: height) }
            generatedView = textfield
        case .spacer(let height):
            generatedView = UIView.init(frame: .zero, color: .init(backgroundColor: .clear))
            generatedView.height(constant: height)
        case .customView(let view):
            generatedView = view
        case .imageView(let provider, let width , let height):
            let imageView = provider.applyModifiers()
            imageView.clipsToBounds = true 
            if let width = width { imageView.width(constant: width) }
            if let height = height { imageView.height(constant: height) }
            generatedView = imageView
        }
        generatedView.translatesAutoresizingMaskIntoConstraints = false
        return generatedView
    }
}
