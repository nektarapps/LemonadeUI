//
//  FlowerVC.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 26.01.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import LemonadeUI

class FlowerVC: UIViewController {
    private lazy var titleLabel : LemonadeLabel = {
        return .init(frame: .zero, .init(text: "Lemonade Flower", color: .black, font: .systemFont(ofSize: 30), alignment: .center, kern: 2.0))
    }()
    private lazy var flower: LemonadeFlower = {
        let config: LemonadeFlowerConfig = .init(items: [
            .init(sliceColor: .init(backgroundColor: .systemBlue.withAlphaComponent(0.7)), sliceBorder: .init(borderColor: .black, width: 2.0)),
            .init(sliceColor: .init(backgroundColor: .systemPink.withAlphaComponent(0.7)), sliceBorder: .init(borderColor: .black, width: 1.0)),
            .init(sliceColor: .init(backgroundColor: .systemGreen.withAlphaComponent(0.7)), sliceBorder: .init(borderColor: .black, width: 4.0)),
            .init(sliceColor: .init(backgroundColor: .red.withAlphaComponent(0.7)), sliceBorder: .init(borderColor: .black, width: 2.0)),
            .init(sliceColor: .init(backgroundColor: .brown.withAlphaComponent(0.7)), sliceBorder: .init(borderColor: .black, width: 2.0)),
            .init(sliceColor: .init(backgroundColor: .systemYellow.withAlphaComponent(0.7)), sliceBorder: .init(borderColor: .black, width: 1.0)),
            .init(sliceColor: .init(backgroundColor: .gray.withAlphaComponent(0.7)), sliceBorder: .init(borderColor: .black, width: 3.0)),
            .init(sliceColor: .init(backgroundColor: .black.withAlphaComponent(0.7)), sliceBorder: .init(borderColor: .white, width: 2.0), customView: .init(frame: .zero, color: .init(backgroundColor: .orange), radius: .init(radius: 20), border: .init(borderColor: .white, width: 2.0)))
        ], spacing: 3)
        let flower: LemonadeFlower = .init(frame: .zero, config)
        flower.backgroundColor = .clear
        flower.flowerdelegate = self
        return flower
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(flower)
        
        titleLabel.top(view, equalTo: .top , safeArea: true)
        titleLabel.centerX(view, equalTo: .centerX)
        titleLabel.width(constant: .screenWidth(48))
        
        flower.center(to: view, width: .screenWidth(48), height: 500)
    }
}
extension FlowerVC: LemonadeFlowerDelegate {
    func sliceTapped(_ flower: LemonadeFlower, index: Int) {
        print("Index Tapped -> \(index)")
    }
    
    
}
