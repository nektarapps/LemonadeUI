//
//  ViewController.swift
//  LemonadeUI
//
//  Created by Hasan Ozgur Elmasli on 08/11/2021.
//  Copyright (c) 2021 Hasan Ozgur Elmasli. All rights reserved.
//
import LemonadeUI

class ViewController: UIViewController {
    lazy var acceptDeclineAlertButton: LemonadeButton = {
        let button: LemonadeButton = .init(frame: .zero, .init(text: "Accept Decline", color: .white, font: .systemFont(ofSize: 20), alignment: .center))
        button.backgroundColor = .red
        button.radius(.init(radius: 12))
        return button
    }()
    let manager: LemonadeAlertManager = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bind()
    }
    private func configureUI(){
        view.addSubview(acceptDeclineAlertButton)
        acceptDeclineAlertButton.top(view, equalTo: .top, safeArea: true)
        acceptDeclineAlertButton.centerX(view, equalTo: .centerX)
        acceptDeclineAlertButton.width(constant: .screenWidth(48))
        acceptDeclineAlertButton.height(constant: 50)
    }
    private func bind(){
        acceptDeclineAlertButton.onClick { [weak self] in
            guard let self = self else { return }
            let acceptButton = LemonadeButton(frame: .zero, color: .init(backgroundColor: .systemGreen), radius: .init(radius: 12), border: .init(borderColor: .black, width: 1.0))
            acceptButton.text(.init(text: "Accept",color: .white,font: .systemFont(ofSize: 18)))
            acceptButton.height(constant: 50)
            let declineButton = LemonadeButton(frame: .zero, color: .init(backgroundColor: .systemRed), radius: .init(radius: 12), border: .init(borderColor: .black, width: 1.0))
            declineButton.text(.init(text: "Decline",color: .white, font: .systemFont(ofSize: 18)))
            declineButton.height(constant: 50)
            let cancelButton = LemonadeButton(frame: .zero, color: .init(backgroundColor: .systemYellow), radius: .init(radius: 12), border: .init(borderColor: .black, width: 1.0))
            cancelButton.text(.init(text: "Cancel",color: .white, font: .systemFont(ofSize: 18)))
            cancelButton.height(constant: 50)
            cancelButton.onClick {
                self.manager.dismiss(presenter: self)
            }
            let components : [LemonadePopupComponents] = [
                .label(text: .init(text: "Gerçekten bir şeyler yapmak ister misin?", color: .black, font: .systemFont(ofSize: 25), alignment: .center)),
                .spacer(height: 10),
                .label(text: .init(text: "Bu uygulama da bir şeyler yapmak istediğiniz emin misiniz? Eğer evet ise bazı bilgileriniz bize gelemesi gerekiyor yoksa olmaz", color: .black.withAlphaComponent(0.4), font: .systemFont(ofSize: 20), alignment: .center)),
                .spacer(height: 20),
                .sideButtons(buttons: [
                    acceptButton,declineButton,cancelButton
                ], spacing: 10)
            ]
            self.manager.showCustomPopup(components: components, animation: .slideToCenter(from: .top),margin: 48, presenter: self)
        }
    }
}
