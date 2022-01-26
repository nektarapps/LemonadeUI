//
//  StarterVC.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 24.01.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import LemonadeUI

class StarterVC: UIViewController {
    private lazy var lemonadeTitleLabel: LemonadeLabel = {
        return .init(frame: .zero, .init(text: "Lemonade UI Playground"
                                         , color: .black, font: .systemFont(ofSize: 20)
                                         , alignment: .center, kern: 2.0))
    }()
    
    private lazy var authorLabel: LemonadeLabel = {
        return .init(frame: .zero, .init(text: "@Author: Hasan Özgür Elmaslı \n @Email: ozgur_elmasli@hotmail.com"
                                         , color: .black
                                         , font: .systemFont(ofSize: 16)
                                         , alignment: .center))
    }()
    
    private lazy var startPlaygroundButton: LemonadeButton = {
        let button: LemonadeButton = .init(frame: .zero
                                           , color: .init(backgroundColor: .systemGreen)
                                           , radius: .init(radius: 8)
                                           , border: .init(borderColor: .black, width: 2.0))
        button.text(.init(text: "Start Playground"
                          , color: .white
                          , font: .systemFont(ofSize: 20)
                          , alignment: .center))
        button.onClick { [weak self] in
            self?.navigationController?.pushViewController(PlaygroundVC.init(), animated: true)
        }
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    private func configureUI(){
        view.backgroundColor = .white
        
        view.addSubview(lemonadeTitleLabel)
        lemonadeTitleLabel.leftAndRight(view , constant: 24)
        lemonadeTitleLabel.top(view, equalTo: .top , constant: 20 , safeArea: true)
        
        view.addSubview(authorLabel)
        authorLabel.bottom(view, equalTo: .bottom , constant: -20 , safeArea: true)
        authorLabel.leftAndRight(view , constant: 24)
        
        view.addSubview(startPlaygroundButton)
        startPlaygroundButton.center(to: view, width: .screenWidth(48), height: 50)

    }
    



}
