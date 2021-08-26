//
//  ViewController.swift
//  LemonadeUI
//
//  Created by Hasan Ozgur Elmasli on 08/11/2021.
//  Copyright (c) 2021 Hasan Ozgur Elmasli. All rights reserved.
//

import UIKit
import LemonadeUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         let textField : LemonadeTextfield = .init(frame: .zero
                                                   , text: .init(text: "", color: .red, font: .systemFont(ofSize: 12), alignment: .center)
                                                   , placeholder: .init(text: "Özgür" ,color: .red))
         textField.border(.init(borderColor: .red, width: 2.0))
         textField.radius(.init(radius: 12))
         self.view.addSubview(textField)
         textField.center(to: self.view, width: .screenWidth(24), height: 50)
        
         let toolTipConfigs : [LemonadeToolTipConfig] = [LemonadeToolTipConfig.init(view: textField)]
         let toolTip = LemonadeToolTip.init(frame: .zero, color: .init(backgroundColor: UIColor.black.withAlphaComponent(0.8)))
         self.view.addSubview(toolTip)
         toolTip.configure(toolTipConfigs)
    }
    
}
