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
        
        let items : [LemonadePieChartItem] = [
            .init(text: .init(text: "Ankara", color: .white, font: .systemFont(ofSize: 20), alignment: .center) ,value: 60, color: .red),
            .init(text:.init(text: "İstanbul", color: .black, font: .systemFont(ofSize: 20), alignment: .center),value: 500, color: .orange , border: .init(borderColor: .white, width: 1.0)),
            .init(text : .init(text: "Adana"),value: 120, color: .purple),
            .init(text: .init(text: "İzmir", color: .white, font: .systemFont(ofSize: 20), alignment: .center), value: 120, color: .systemPink , border: .init(borderColor: .white, width: 3.0))
        ]
        let pieChart : LemonadePieChart = LemonadePieChart.init(frame: .zero, .init(items: items, isAnimate: true))
       // pieChart.configure(.init(items: items, isAnimate: true))
        view.addSubview(pieChart)
        pieChart.center(to: view, width: 300, height: 300)
        
    }
}
