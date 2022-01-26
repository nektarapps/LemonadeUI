//
//  PlaygroundHeaderView.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 25.01.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import LemonadeUI

class PlaygroundHeaderView: UITableViewHeaderFooterView {
    private lazy var titleLabel: LemonadeLabel = {
        return .init(frame: .zero, .init(text: "", color: .black, font: .systemFont(ofSize: 20), alignment: .center))
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubview(titleLabel)
        titleLabel.fill2SuperView()
    }
    
    func configureUI(text: String) {
        titleLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
