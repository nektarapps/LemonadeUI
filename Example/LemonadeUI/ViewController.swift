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
    
        let button1 = LemonadeButton.init(frame: .zero, .init(text: "Özgür"  , color: .red))
        button1.color(.init(backgroundColor: .white))
        let button2 = LemonadeButton.init(frame: .zero, .init(text: "Elmaslı" , color: .brown))
        button2.color(.init(backgroundColor: .white))
        let config = LemonadeAlertConfig.init(.Success, position: .top, title: .init(text: "Naber dostum???") , closeDuration: 2)
        let alert = LemonadeBarAlert.init(frame: .zero, config: config , buttons: [button1 , button2])
        alert.show(presenter : self)
    }
}

