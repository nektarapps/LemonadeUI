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
        let config = LemonadeProgressBarConfig.init(alignment: .vertical
                                                    , textType: .auto(initialText: .init(text: "Starting", color: .black, font: .systemFont(ofSize: 12)))
                                                    , starterPercentage: 40.0
                                                    ,automaticProgressDuration:5
                                                    , progressColor: .init(frame: .zero, color: .init(backgroundColor: .red.withAlphaComponent(0.5))))
        let progressBar = LemonadeProgressBar.init(frame: .zero, config)
        progressBar.delegate = self
        progressBar.color(.init(backgroundColor: .systemBlue))
        progressBar.radius(.init(radius: 8))
        self.view.addSubview(progressBar)
        progressBar.center(to: self.view, width: 30, height: 100)
    }
}
extension ViewController : LemonadeProgressBarDelegate {
    func percantageChanged(_ bar: LemonadeProgressBar, value: CGFloat) {
        print(value)
    }
    
    func progressFinished(_ bar: LemonadeProgressBar) {
        print("finished")
    }
    
    
}
