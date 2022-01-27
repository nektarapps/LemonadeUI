//
//  ButtonTableViewCell.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 25.01.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import LemonadeUI

class ButtonTableViewCell : UITableViewCell {
    private lazy var button: LemonadeButton = {
        let button: LemonadeButton = .init(frame: .zero, color: .init(backgroundColor: .clear), radius: .init(radius: 8), border: .init(borderColor: .black, width: 1.0))
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(button)
        button.top(self, equalTo: .top , constant: 15)
        button.leftAndRight(self , constant: 15)
        button.height(constant: 50)
        button.bottom(self, equalTo: .bottom , constant: -24)
    }
    func configureUI(text: LemonadeText, backgroundColor: UIColor) {
        button.text(text)
        button.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
