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
        
        let views : [UIView] = [
            .init(frame: .zero, color: .init(backgroundColor: .red)),
            .init(frame: .zero, color: .init(backgroundColor: .blue)),
            .init(frame: .zero, color: .init(backgroundColor: .brown)),
            .init(frame: .zero, color: .init(backgroundColor: .cyan)),
            .init(frame: .zero, color: .init(backgroundColor: .systemPink)),
            .init(frame: .zero, color: .init(backgroundColor: .magenta)),
            .init(frame: .zero, color: .init(backgroundColor: .purple)),
            .init(frame: .zero, color: .init(backgroundColor: .systemYellow)),
            .init(frame: .zero, color: .init(backgroundColor: .yellow))
        ]
        let flower = LemonadeFlower.init(frame: .zero, .init( views : views , numberOfItems: 9, spacing: 3 , sliceColor: .orange))
        view.addSubview(flower)
        flower.center(to: view, width: .screenWidth(24), height: 400)
        flower.flowerdelegate = self
    }
}

extension ViewController : LemonadeFlowerDelegate {
    func sliceTapped(_ flower: LemonadeFlower, index: Int) {
        print(index)
    }
}
