//
//  ExampleFormViewModel.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 30.01.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import LemonadeUI

class ExampleFormViewModel: FormViewModelType {
    var configuration: LemonadeFormConfiguration
    
    init() {
        let components: [ LemonaedFormComponents ] = [
            .textfield(id:"username"
                       ,title: .init(text: "Username" , color: .black , font: .systemFont(ofSize: 20) , alignment: .left)
                       , placeholder: .init(text: "Username",color:.black.withAlphaComponent(0.5))
                       , text: .init(text: "Username",color:.black.withAlphaComponent(0.8))
                       , backgroundColor: .gray.withAlphaComponent(0.2)
                       , radius: .init(radius: 12), border: .init(borderColor: .white, width: 2.0)
                       , regex: .emailValidate
                       , limitTypes: []
                       , height: 50),
            .spacer(height: 20),
            .textfield(id:"password"
                       , title: .init(text: "Password" ,  color: .black , font: .systemFont(ofSize: 20) , alignment: .left)
                       , placeholder: .init(text: "Password",color:.black.withAlphaComponent(0.5))
                       , text: .init(text: "Password",color:.black.withAlphaComponent(0.8))
                       , backgroundColor: .gray.withAlphaComponent(0.2)
                       , radius: .init(radius: 12)
                       , regex: .none
                       , limitTypes: [.charLimit(min: 6, max: 20)]
                       , height: 50),
            .spacer(height: 20),
            .textfield(id: "confirm_password"
                       , title: .init(text: "Confirm Password" ,  color: .black , font: .systemFont(ofSize: 20) , alignment: .left)
                       , placeholder: .init(text: "Confirm Password",color:.black.withAlphaComponent(0.5))
                       , text: .init(text: "Confirm Password",color:.black.withAlphaComponent(0.8))
                       , backgroundColor: .gray.withAlphaComponent(0.2)
                       , radius: .init(radius: 12)
                       , regex: .none
                       , limitTypes: [.charLimit(min: 6, max: 20)]
                       , height: 50),
            .spacer(height: 20),
            .textView(id: "hear_about"
                      , title: .init(text: "Where did you hear?" ,  color: .black , font: .systemFont(ofSize: 20) , alignment: .left)
                      , placeholder: .init(text: "Github, linkedin or other platforms",color:.black.withAlphaComponent(0.5) , font: .systemFont(ofSize: 20), alignment: .left)
                      , text: .init(text: "Github",color:.black.withAlphaComponent(0.8) , font: .systemFont(ofSize: 20) , alignment: .left)
                      , backgroundColor: .gray.withAlphaComponent(0.2)
                      , radius: .init(radius: 12)
                      , border: .init(borderColor: .black, width: 3.0)
                      , height: 150),
            .spacer(height: 20)
        ]
        let button: LemonadeButton = LemonadeButton(frame: .zero , color: .init(backgroundColor: .systemBlue.withAlphaComponent(0.5))
                                                    , radius: .init(radius: 12)
                                                    , border: .init(borderColor: .black, width: 4.0))
        button.text(.init(text: "Register",color:.white,font:.systemFont(ofSize: 25)))
        button.height(constant: 60)
        self.configuration = .init(components: components, titleText: .init(text: "Register User" , color:.black , font:.systemFont(ofSize: 35)), formButton: button)
    }
    
    func actionButtonTapped(_ result: [FormResultItem]) {
        print(result.map {$0.value})
    }
    
}
