//
//  Lemonade+View+Creator.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 6.04.2022.
//

import Foundation
import UIKit


public class ViewCreator {
    
    private var parentView: UIView!
    
    private var generatedStackView: UIStackView?
    
    private var insets: UIEdgeInsets?
    
    public init(parentView: UIView , insets: UIEdgeInsets? = nil) {
        self.parentView = parentView
        self.insets = insets
    }
    
    public func create(axis: ViewCreatorAxis) {
        let stackView = axis.generateStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(stackView)
        stackView.fill2SuperView()
        
        generatedStackView = stackView
        
        padding(insets: insets)
    }
    
    public func padding(insets: UIEdgeInsets?) {
        guard let insets = insets else {
            return
        }
        self.insets = insets
        generatedStackView?.isLayoutMarginsRelativeArrangement = true
        generatedStackView?.layoutMargins = insets
    }
}
