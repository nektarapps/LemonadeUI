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
        
        let button1 = LemonadeButton.init(frame: .zero, .init(text: "Kabul et"  , color: .white , font: .systemFont(ofSize: 15)))
        button1.color(.init(backgroundColor: .systemGreen))
        button1.radius(.init(radius: 8))
        let button2 = LemonadeButton.init(frame: .zero, .init(text: "Reddet" , color: .white , font: .systemFont(ofSize: 15)))
        button2.color(.init(backgroundColor: .systemRed))
        button2.radius(.init(radius: 8))
        let button3 = LemonadeButton.init(frame: .zero, .init(text: "Sorun Bildir" , color: .white , font: .systemFont(ofSize: 15)))
        button3.color(.init(backgroundColor: .systemYellow))
        button3.radius(.init(radius: 8))
        
        let title : LemonadeText = .init(text: "Bilgilendirme", color: .white, font: UIFont.init(name: "Avenir-Black", size: 20)!, alignment: .center)
        let messgage : LemonadeText = .init(text: "Başka bir yerde oturum açılmış , onu kapatıp buradan devam etmek ister misin ?", color: UIColor.white.withAlphaComponent(0.6), font: UIFont.init(name: "Avenir-Black", size: 15)!, alignment: .center)
        
        let config = LemonadeAlertConfig.init(.Error, position: .bottom, icon: .init(), title:title , message: messgage , closeDuration: 2)
        let alert = LemonadeAlertDialog.init(frame: .zero, config: config , buttons: [button1 , button2 , button3])
        
        alert.show(presenter : self)
    }
}

