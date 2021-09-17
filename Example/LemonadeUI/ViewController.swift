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

        let elements : [LemonadeProgressChartElement] = [
            .init(percentage: 80, barColor: .init(backgroundColor: .orange.withAlphaComponent(0.4)) , text: .init(text: "Turkey" , font: .systemFont(ofSize: 15)), progressView: .init(frame: .zero, color: .init(backgroundColor: .systemTeal.withAlphaComponent(0.6)))),
            .init(percentage: 60, barColor: .init(backgroundColor: .yellow.withAlphaComponent(0.4))  , text: .init(text: "England" , font: .systemFont(ofSize: 15)), progressView: .init(frame: .zero, color: .init(backgroundColor: .systemPink.withAlphaComponent(0.6)))),
            .init(percentage: 20, barColor: .init(backgroundColor: .brown.withAlphaComponent(0.4))  , text: .init(text: "U.S.A" , font: .systemFont(ofSize: 15)), progressView: .init(frame: .zero, color: .init(backgroundColor: .systemPurple.withAlphaComponent(0.6)))),
            .init(percentage: 40, barColor: .init(backgroundColor: .cyan.withAlphaComponent(0.4)) , text: .init(text: "Coloumbia" , font: .systemFont(ofSize: 15)), progressView: .init(frame: .zero, color: .init(backgroundColor: .red)))
        ]
        let config : LemonadeProgressChartConfig = .init(alignment: .vertical
                                                         , titleText: .init(text : "Top Sales" , color: .black)
                                                         , elements: elements)
        let chart : LemonadeProgressChart? = LemonadeProgressChart.init(frame: .zero, config)
        self.view.addSubview(chart!)
        chart!.center(to: self.view, width: .screenWidth(24), height: .screenWidth(24))
    }
}
