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
        
        let sliderconfig = LemonadeSliderConfig.init(sliderColor: .red
                                                     , thumbConfig: .init(color: .red, value: 0, height: 30)
                                                     , thumbLabelText: .init(text: "Start", color: .black)
                                                     //, secondThumbConfig: .init(color: .orange, value: 10, height: 30)
                                                     //, secondLabelText: .init(text: "End", color: .black)
                                                     , maskedViewThumbsBetweenThumbs: .init(frame: .zero, color: .init(backgroundColor:.blue)))
        let slider = LemonadeSlider.init(frame: .zero, sliderconfig)
        view.addSubview(slider)
        slider.center(to: view, width: 300, height: 50)
    }
}
