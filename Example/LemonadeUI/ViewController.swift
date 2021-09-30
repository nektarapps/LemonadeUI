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
            .init(xAxisText: .init(text: "Pazt" , color: .black), value: 1 , color: .red , lineWidth: 1.0),
            .init(xAxisText: .init(text: "Salı" , color: .black), value: 4 , color: .yellow , lineWidth: 2.0),
            .init(xAxisText: .init(text: "Çarş" , color: .black), value: 2 , color: .brown),
            .init(xAxisText: .init(text: "Perş" , color: .black), value: 8 , color: .magenta ,lineWidth: 30.0),
            .init(xAxisText: .init(text: "Cumar" , color: .black), value: 0.5),
            .init(xAxisText: .init(text: "Paz" , color: .black), value: 0 , lineWidth: 5.0),
            .init(xAxisText: .init(text: "Pazt" , color: .black), value: 2000 , lineWidth: 12),
            
            
        ], color: .orange , animate: true))
        
        view.addSubview(lineChart)
        lineChart.center(to: view, width: 300, height: 300)
        
    }
}
