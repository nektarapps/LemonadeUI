//
//  GeneratedVC.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 6.04.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import LemonadeUI

class GeneratedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        ViewCreator.init(parentView: view , insets: .init(top: 20, left: 24, bottom: 20, right: 24))
            .create(axis: .vertical(spacing: 10, components: [
                
                .imageView(provider: .init(radius: .init(radius: 12)
                                           , shadow: .init(shadowColor: .black, offset: .init(width: 3, height: 6), radius: 12)
                                           , sourceType: .fromName(name: "rick_and_morty"), contentMode: .scaleAspectFill), width: nil , height: 200),
                
                .text(provider: .init(text: .init(text: "Create Account" , color: .systemBlue.withAlphaComponent(0.75) , font: .systemFont(ofSize: 20)))),
                
                .textfield(provider: .init(radius: .init(radius: 12)
                                           , border: .init(borderColor: .black, width: 2.0)
                                           , delegate: self
                                           , placeholder: .init(text: "Username" , color:.black)
                                           , text: .init(text: "John", color: .systemBlue))
                                           , height: 50),
                
                .textfield(provider: .init(radius: .init(radius: 12)
                                           , border: .init(borderColor: .black, width: 2.0)
                                           , delegate: self
                                           , placeholder: .init(text: "Country" , color:.black)
                                           , text: .init(text: "Turkey", color: .systemBlue))
                                           , height: 50),
                
                .textfield(provider: .init(radius: .init(radius: 12)
                                           , border: .init(borderColor: .black, width: 2.0)
                                           , delegate: self
                                           , placeholder: .init(text: "Email" , color:.black)
                                           , text: .init(text: "ozgur_elmasli@hotmail.com", color: .systemBlue))
                                           , height: 50),
                
                .textfield(provider: .init(radius: .init(radius: 12)
                                           , border: .init(borderColor: .black, width: 2.0)
                                           , delegate: self
                                           , placeholder: .init(text: "Password" , color:.black)
                                           , text: .init(text: "", color: .systemBlue) , limits: [
                                            .charLimit(min: nil, max: 8)
                                           ])
                                           , height: 50),
                .spacer(height: 80),
                .button(provider: ButtonProvider.init(backgroundColor: .init(backgroundColor: .systemBlue)
                                                      , radius: .init(radius: 12), border: .init(borderColor: .black, width: 2.0)
                                                      , text: .init(text: "Apply")
                                                      , action: {
                                                          print("Tapped")
                                                      }), height: 48),
                .spacer(height: 150),
                .axis(axis: .horizontal(spacing: 10, components: [
                    .button(provider: .init(backgroundColor: LemonadeColor.init(backgroundColor: .blue)
                                            , radius: .init(radius: 12), border: .init(borderColor: .white, width: 2.0)
                                            , text: .init(text: "Submit"), action: {
                                                print("Submit")
                                            }), height: 50),
                    .button(provider: .init(backgroundColor: LemonadeColor.init(backgroundColor: .red)
                                            , radius: .init(radius: 12), border: .init(borderColor: .white, width: 2.0)
                                            , text: .init(text: "Declined"), action: {
                                                print("Declined")
                                            }), height: 50),
                ], distributionType: .fillEqually))
            ]))
            
        
    }
}
extension GeneratedVC: LemonadeTextFieldDelegate {
    func isTextValid(_ textfield: LemonadeTextfield, _ value: Bool) {
        print(value)
    }
    
    func isMinimumLimitValid(_ textfield: LemonadeTextfield, _ value: Bool) {
        print(value)
    }
    
    func isMaximumLimitValid(_ textfield: LemonadeTextfield, _ value: Bool) {
        print(value)
    }
    
    func didTextChange(_ textfield: LemonadeTextfield) {
        print(textfield.text ?? "")
    }
    
    
}
