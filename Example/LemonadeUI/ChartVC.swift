//
//  ChartVC.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 26.01.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import LemonadeUI

class ChartVC: UIViewController {
    private lazy var lineChart: LemonadeLineChart = {
        let chartConfig = LemonadeLineChartConfig(items: [
            .init(xAxisText: .init(text: "XAxis1", color: .systemGreen, font: .systemFont(ofSize: 15), alignment: .center)
                  , yAxisText: .init(text: "YAxis1", color: .orange, font: .systemFont(ofSize: 15), alignment: .center)
                  , value: 5, color: .purple, lineWidth: 5),
            .init(xAxisText: .init(text: "XAxis2", color: .systemGreen, font: .systemFont(ofSize: 15), alignment: .center)
                  , yAxisText: .init(text: "YAxis2", color: .orange, font: .systemFont(ofSize: 15), alignment: .center)
                  , value: 100, color: .blue, lineWidth: 3),
            .init(xAxisText: .init(text: "XAxis3", color: .systemGreen, font: .systemFont(ofSize: 15), alignment: .center)
                  , yAxisText: .init(text: "YAxis3", color: .orange, font: .systemFont(ofSize: 15), alignment: .center)
                  , value: 40, color: .brown, lineWidth:8),
            .init(xAxisText: .init(text: "XAxis4", color: .systemGreen, font: .systemFont(ofSize: 15), alignment: .center)
                  , yAxisText: .init(text: "YAxis4", color: .orange, font: .systemFont(ofSize: 15), alignment: .center)
                  , value: 70, color: .red, lineWidth: 1)
        ], color: .black, animate: true)
        let chart = LemonadeLineChart.init(frame: .zero, chartConfig)
        return chart
    }()
    
    private lazy var pieChart: LemonadePieChart = {
        let config = LemonadePieChartConfig(items: [
            .init(text: .init(text: "Basketball"), value: 50, color: .red, border: .init(borderColor: .black, width: 2.0)),
            .init(text: .init(text: "Football"), value: 80, color: .orange, border: .init(borderColor: .green, width: 1.0)),
            .init(text: .init(text: "Voleyball"), value: 100, color: .systemTeal, border: .init(borderColor: .black, width: 2.0)),
        ], isAnimate: true)
        let pieChart = LemonadePieChart(frame: .zero, config)
        pieChart.backgroundColor = .clear
        //pieChart.pieCharDelegate = self
        return pieChart
    }()
    
    private lazy var progressChart: LemonadeProgressChart = {
        let config = LemonadeProgressChartConfig(alignment: .horizontal, borderColor: .init(backgroundColor: .systemGreen), titleText: .init(text: "Year Progress" , color: .black), isLinePercentageShow: false, elements: [
            .init(percentage: 30, barColor: .init(backgroundColor: .black.withAlphaComponent(0.3)), text: .init(text: "2021"), progressView: UIView.init(frame: .zero, color: .init(backgroundColor:.systemPink), radius: .init(radius: 6))),
            .init(percentage: 60, barColor: .init(backgroundColor: .black.withAlphaComponent(0.3)), text: .init(text: "2020"), progressView: UIView.init(frame: .zero, color: .init(backgroundColor:.systemBlue), radius: .init(radius: 6)))
        ])
        let chart = LemonadeProgressChart(frame: .zero, config)
        return chart
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.backgroundColor = .clear
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        stackView.top(view, equalTo: .top ,safeArea: true)
        stackView.leftAndRight(view , constant: 24)
        stackView.bottom(view, equalTo: .bottom, safeArea: true)
        
        [lineChart , progressChart , pieChart].forEach { stackView.addArrangedSubview($0) }
    }
}
