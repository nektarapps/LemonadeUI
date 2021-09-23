//
//  ViewController.swift
//  LemonadeUI
//
//  Created by Hasan Ozgur Elmasli on 08/11/2021.
//  Copyright (c) 2021 Hasan Ozgur Elmasli. All rights reserved.
//
import LemonadeUI

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lotusConfig = LemonadeLotusConfig.init(petal: .red.withAlphaComponent(0.3), numberOfItems: 4, pattern: [
            .init(duration: 2, position: .sleep),
            .init(duration: 5, position: .awake),
            .init(duration: 2, position: .awake),
            .init(duration: 3, position: .sleep)
        ])
        let lotus = LemonadeLotus.init(frame: .zero, lotusConfig)
        view.addSubview(lotus)
        lotus.center(to: view, width: .screenWidth(10), height: 400)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            lotus.startAnimation()
        })
    }
    
}
