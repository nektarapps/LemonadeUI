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
        
        let lineChart = LemonadeLineChart(frame: .zero, .init(items: [
            .init(xAxisText: .init(text: "Pazt"), yAxisText: .init(text: "300"), value: 300),
            .init(xAxisText: .init(text: "Salı"), yAxisText: .init(text: "100"), value: 100),
            .init(xAxisText: .init(text: "Çarş"), yAxisText: .init(text: "500"), value: 500),
            .init(xAxisText: .init(text: "Perş"), yAxisText: .init(text: "400"), value: 400),
            .init(xAxisText: .init(text: "Cum"), yAxisText: .init(text: "700"), value: 700),
        ], color: .black))
        
        view.addSubview(lineChart)
        lineChart.center(to: view, width: 300, height: 300)
        
    }
}
