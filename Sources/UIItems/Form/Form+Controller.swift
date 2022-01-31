//
//  Form+Controller.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 30.01.2022.
//

import UIKit

public struct FormResultItem {
    public var id: String
    public var value: String
}

public protocol FormViewModelType {
    var configuration: LemonadeFormConfiguration { get set }
    func actionButtonTapped( _ result: [FormResultItem])
}
public class LemonadeForm: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .vertical
        stackView.spacing = viewModel.configuration.spacingBetweenItems
        stackView.layoutMargins = .init(top: 24, left: 24, bottom: 24, right: 24)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    private lazy var titleLabel: LemonadeLabel = {
        return .init(frame: .zero, viewModel.configuration.formTitleText)
    }()
    private var viewModel: FormViewModelType!

    public init(viewModel: FormViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI(){
        view.backgroundColor = .white
        view.addEndEditingAction()
        view.addSubview(stackView)
        stackView.fill2SuperView()
        
        viewModel.configuration.formActionButton.addAction { [weak self] in
            self?.viewModel.actionButtonTapped(self?.getResults() ?? [])
        }
        stackView.addArrangedSubview(titleLabel)
        viewModel.configuration.components.forEach {
            stackView.addArrangedSubview($0.view)
        }
        stackView.addArrangedSubview(viewModel.configuration.formActionButton)
         
        stackView.layoutSubviews()
        stackView.layoutIfNeeded()
    }
    
    private func getResults() -> [FormResultItem] {
        if stackView.subviews.isEmpty { return [] }
        var values: [FormResultItem] = [FormResultItem]()
        stackView.subviews.forEach {
            if let textStackView = $0 as? UIStackView {
                if textStackView.subviews.isEmpty { return }
                textStackView.subviews.forEach { item in
                    if let textField = item as? LemonadeTextfield {
                        values.append(.init(id: textField.identifier, value: textField.text ?? "" ))
                    }
                    if let textView = item as? LemonadeTextView {
                        values.append(.init(id: textView.identifier, value: textView.text ?? "" ))
                    }
                }
            }
        }
        
        return values
    }
}
