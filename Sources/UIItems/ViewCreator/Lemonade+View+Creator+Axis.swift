//
//  Lemonade+View+Creator+Axis.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 6.04.2022.
//

import Foundation


public enum ViewCreatorAxis {
    case vertical(spacing: CGFloat = 0, components: [ViewCreatorComponentType])
    case horizontal(spacing: CGFloat = 0, components: [ViewCreatorComponentType])
    
    public func generateStackView() -> UIStackView {
        let stackView: UIStackView = .init()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        switch self {
        case .vertical(let spacing, let components):
            stackView.spacing = spacing
            stackView.axis = .vertical
            components.map { $0.generateView() }.forEach { view in
                stackView.addArrangedSubview(view)
            }
        case .horizontal(let spacing, let components):
            stackView.spacing = spacing
            stackView.axis = .horizontal
            components.map { $0.generateView() }.forEach { view in
                stackView.addArrangedSubview(view)
            }
        }
        return stackView
    }
}


