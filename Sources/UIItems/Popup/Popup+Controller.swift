//
//  PopupController.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 30.12.2021.
//

import Foundation


public class LemonadePopupController: UIViewController {
    
    private var centerXConstraint: NSLayoutConstraint?
    private var centerYConstraint: NSLayoutConstraint?
    
    private lazy var stackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.layoutMargins = .init(top: 24, left: 24, bottom: 24, right: 24)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    private var configuration: LemonadePopupConfiguration?
    
    /// Default init function. PopupConfiguration value is required
    public init(configuration: LemonadePopupConfiguration) {
        super.init(nibName: nil, bundle: nil)
        self.configuration = configuration
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureUI() {
        guard let configuration = configuration else {
            return
        }
        view.backgroundColor = .black.withAlphaComponent(0.7)
        view.addSubview(stackView)
        
        prepareConstraintForAnimate()
        
        stackView.color(configuration.backgroundColor)
        stackView.radius(configuration.radius)
        
        view.layoutIfNeeded()
        configuration.components.forEach {
            stackView.addArrangedSubview($0.view)
        }
        stackView.layoutSubviews()
        stackView.layoutIfNeeded()
    }
    
    private func prepareConstraintForAnimate(){
        guard let configuration = configuration else {
            return
        }
        switch configuration.animation {
            case .fade(let position):
                stackView.layer.opacity = 0.0
                switch position {
                case .top:
                    stackView.top(view, equalTo: .top)
                case .bottom:
                    stackView.bottom(view, equalTo: .bottom)
                case .left:
                    stackView.left(view, equalTo: .left)
                case .right:
                    stackView.right(view, equalTo: .right)
                }
            case .slideToCenter(let from):
                switch from {
                case .top:
                    centerYConstraint = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -2 * .screenHeight())
                    centerXConstraint = stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                case .bottom:
                    centerYConstraint = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 2 * .screenHeight())
                    centerXConstraint = stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                case .left:
                    centerYConstraint = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                    centerXConstraint = stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor , constant: -2 * .screenWidth())
                case .right:
                    centerYConstraint = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                    centerXConstraint = stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor , constant: 2 * .screenWidth())
                }
                centerXConstraint?.isActive = true
                centerYConstraint?.isActive = true
        }
        
        stackView.width(constant: .screenWidth(configuration.margin))
    }
    
    public func show(){
        guard let configuration = configuration else {
            return
        }
        switch configuration.animation {
        case .fade:
            UIView.animate(withDuration: configuration.animationDuration) {
                self.stackView.layer.opacity = 1.0
            }
        case .slideToCenter:
            centerXConstraint?.constant = 0
            centerYConstraint?.constant = 0
            UIView.animate(withDuration: configuration.animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    public func hide(){
        guard let configuration = configuration else {
            return
        }
        switch configuration.animation {
        case .fade:
            UIView.animate(withDuration: configuration.animationDuration) {
                self.stackView.layer.opacity = 0.0
            }
        case .slideToCenter(let from):
            centerXConstraint?.isActive = false
            centerYConstraint?.isActive = false
            switch from {
            case .top:
                centerYConstraint = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -2 * .screenHeight())
                centerXConstraint = stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            case .bottom:
                centerYConstraint = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 2 * .screenHeight())
                centerXConstraint = stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            case .left:
                centerYConstraint = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                centerXConstraint = stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor , constant: -2 * .screenWidth())
            case .right:
                centerYConstraint = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                centerXConstraint = stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor , constant: 2 * .screenWidth())
            }
            centerXConstraint?.isActive = true
            centerYConstraint?.isActive = true
            UIView.animate(withDuration: configuration.animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
}
