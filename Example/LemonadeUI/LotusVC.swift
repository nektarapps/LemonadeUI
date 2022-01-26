//
//  LotusVC.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 26.01.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import LemonadeUI

class LotusVC: UIViewController {
    private lazy var titleLabel : LemonadeLabel = {
        return .init(frame: .zero, .init(text: "Lemonade Lotus", color: .black, font: .systemFont(ofSize: 30), alignment: .center, kern: 2.0))
    }()
    private lazy var lotus : LemonadeLotus = {
        let config = LemonadeLotusConfig(petal: .systemBlue, numberOfItems: 8, pattern: [
            .init(duration: 3, position: .sleep),
            .init(duration: 4, position: .awake),
            .init(duration: 1, position: .sleep),
            .init(duration: 5, position: .awake),
        ])
        let lotus = LemonadeLotus(frame: .zero, config)
        lotus.lotusDelegate = self
        return lotus
    }()
    private lazy var startPatterButton: LemonadeButton = {
        let button: LemonadeButton = .init(frame: .zero, color: .init(backgroundColor: .systemBlue), radius:.init(radius: 8))
        button.text(.init(text: "Start Pattern", color: .white, font: .systemFont(ofSize: 20), alignment: .center))
        return button
    }()
    private lazy var openLotusButton: LemonadeButton = {
        let button: LemonadeButton = .init(frame: .zero, color: .init(backgroundColor: .systemBlue), radius:.init(radius: 8))
        button.text(.init(text: "Open Lotus", color: .white, font: .systemFont(ofSize: 20), alignment: .center))
        return button
    }()
    private lazy var closeLotusButton: LemonadeButton = {
        let button: LemonadeButton = .init(frame: .zero, color: .init(backgroundColor: .systemBlue), radius:.init(radius: 8))
        button.text(.init(text: "Close Lotus", color: .white, font: .systemFont(ofSize: 20), alignment: .center))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        handlers()
    }
    private func configureUI(){
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(lotus)
        view.addSubview(startPatterButton)
        view.addSubview(openLotusButton)
        view.addSubview(closeLotusButton)
        
        titleLabel.top(view, equalTo: .top , safeArea: true)
        titleLabel.centerX(view, equalTo: .centerX)
        titleLabel.width(constant: .screenWidth(48))
        
        lotus.center(to: view, width: .screenWidth(48), height: 400)
        
        startPatterButton.top(lotus, equalTo: .bottom,  constant: 20)
        startPatterButton.leftAndRight(view , constant: 24)
        startPatterButton.height(constant: 50)
        
        openLotusButton.top(startPatterButton, equalTo: .bottom,  constant:5)
        openLotusButton.leftAndRight(view , constant: 24)
        openLotusButton.height(constant: 50)
        
        closeLotusButton.top(openLotusButton, equalTo: .bottom,  constant: 5)
        closeLotusButton.leftAndRight(view , constant: 24)
        closeLotusButton.height(constant: 50)
    }
    private func handlers(){
        startPatterButton.addAction { [weak self] in
            self?.lotus.startPattern()
        }
        openLotusButton.addAction { [weak self] in
            self?.lotus.openLotus(3)
        }
        closeLotusButton.addAction { [weak self] in
            self?.lotus.closeLotus(3)
        }
    }
}
extension LotusVC: LemonadeLotusDelegate {
    func actionChanged(_ lotus: LemonadeLotus, action: LemonadeLotusAnimationPatternItem) {
        print("Action changed -> \(action.position)")
    }
    
    func animationStart(_ lotus: LemonadeLotus) {
        print("Animate Start")
    }
    
    func animationEnd(_ lotus: LemonadeLotus) {
        print("Animate Stop")
    }
    
    
}

