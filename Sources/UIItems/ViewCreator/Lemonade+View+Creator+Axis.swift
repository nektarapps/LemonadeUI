//
//  Lemonade+View+Creator+Axis.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 6.04.2022.
//

import Foundation



public enum ViewCreatorAxis {
    case vertical(spacing: CGFloat = 0
                  , components: [ViewCreatorComponentType]
                  , distributionType: UIStackView.Distribution = .fill)
    case horizontal(spacing: CGFloat = 0
                    , components: [ViewCreatorComponentType]
                    , distributionType: UIStackView.Distribution = .fill)
    
    public func generateStackView() -> UIStackView {
        let stackView: UIStackView = .init()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        switch self {
        case .vertical(let spacing, let components, let distributionType):
            stackView.spacing = spacing
            stackView.axis = .vertical
            stackView.distribution = distributionType
            components.map { $0.generateView() }.forEach { view in
                stackView.addArrangedSubview(view)
            }
        case .horizontal(let spacing, let components, let distributionType):
            stackView.spacing = spacing
            stackView.axis = .horizontal
            stackView.distribution = distributionType
            components.map { $0.generateView() }.forEach { view in
                stackView.addArrangedSubview(view)
            }
        }
        return stackView
    }
}


