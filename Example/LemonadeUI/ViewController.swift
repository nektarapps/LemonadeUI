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
        
        let labelledInput = LemonadeLabelledInput.init(frame: .zero, text: .init(text: "Sayın özgür elmaslı , nasılsınız bugün ?????" , color: .black , font: .systemFont(ofSize: 20)), labelPosition: .top, textfieldText: .init(text: "Özgür" , color: .black) , margin: 10)
        self.view.addSubview(labelledInput)
        labelledInput.lemonadeTextfield?.border(.init(borderColor: UIColor.black, width: 2.0))
        labelledInput.widthAndHeight(constant: 100)
        labelledInput.center(to: self.view)
        
        //labelledInput.center(to: self.view, width: .screenWidth(24), height: 80)
    }
    
}
extension ViewController {
    @objc func tapped(){
        print("tapped")
    }
}
