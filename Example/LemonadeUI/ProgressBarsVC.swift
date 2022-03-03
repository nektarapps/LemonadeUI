//
//  ProgressBarsVC.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 30.01.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import LemonadeUI

class ProgressBarsVC: UIViewController {
    private lazy var circleProgressBar: LemonadeCircleProgressBar = {
        let items: [LemonadeCircleProgessBarItem] = [
            .init(positionValue: 120, barTintColor: .systemBlue.withAlphaComponent(0.4), progressColor: .systemBlue, lineWidth: 15.0),
            .init(positionValue: 70, barTintColor: .systemOrange.withAlphaComponent(0.4), progressColor: .systemOrange, lineWidth: 15.0, animateDuration: 4),
            .init(positionValue: 80, barTintColor: .systemRed.withAlphaComponent(0.4), progressColor: .systemRed, lineWidth: 15.0),
            .init(positionValue: 300, barTintColor: .brown.withAlphaComponent(0.4), progressColor: .brown, lineWidth: 15.0 , animateDuration: 2)
        ]
        let config = LemonadeCircleProgessBarConfig(items: items
                                                    , spaceBetweenItems: 30
                                                    , barTitleText: .init(text: "Your Progress" ,color: .blue , font: .systemFont(ofSize: 30)))
        let cirleProgressBar = LemonadeCircleProgressBar(frame: .zero, config)
        return cirleProgressBar
    }()
    
    private lazy var defaultProgressBarHorizontal: LemonadeProgressBar = {
        let config = LemonadeProgressBarConfig(alignment: .horizontal
                                               , textType: .auto(initialText: .init(text: "Starter Text" , font: .systemFont(ofSize: 20)))
                                               , starterPercentage: 10.0
                                               , automaticProgressDuration: 3, progressView: .init(frame: .zero, color: .init(backgroundColor: .systemRed.withAlphaComponent(0.5)), radius: .init(radius: 12), border: .init(borderColor: .white, width: 2.0)))
        let progressBar = LemonadeProgressBar(frame: .zero, config)
        progressBar.backgroundColor = .red.withAlphaComponent(0.1)
        progressBar.radius(.init(radius: 12))
        progressBar.delegate = self
        return progressBar
    }()
    /*
    private lazy var defaultProgressBarVertical: LemonadeProgressBar = {
        let config = LemonadeProgressBarConfig(alignment: .vertical
                                               , textType: .auto(initialText: .init(text: "Starter Text" , font: .systemFont(ofSize: 20)))
                                               , starterPercentage: 10.0
                                               , automaticProgressDuration: 3, progressView: .init(frame: .zero, color: .init(backgroundColor: .systemRed.withAlphaComponent(0.5)), radius: .init(radius: 12), border: .init(borderColor: .white, width: 2.0)))
        let progressBar = LemonadeProgressBar(frame: .zero, config)
        progressBar.backgroundColor = .red.withAlphaComponent(0.1)
        progressBar.radius(.init(radius: 12))
        progressBar.delegate = self
        return progressBar
    }()
     */
    
    private lazy var lemonadeVerificationProgressBar: LemonadeVerificationProgressBar = {
        let config = LemonadeVerificationProgressBarConfig(items: [
            .init(iconName: "pencil", text: .init(text: "Doğum Tarhiiniz" , color: .black)),
            .init(iconName: "pencil", text: .init(text: "IBAN numaranız" , color: .black)),
            .init(iconName: "pencil", text: .init(text: "Adres" , color: .black)),
            .init(iconName: "pencil", text: .init(text: "Fotoğraf" , color: .black)),
            .init(iconName: "pencil", text: .init(text: "Daha fazlası" , color: .black))
        ] , startStep: 0)
        return LemonadeVerificationProgressBar(frame: .zero, config)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(circleProgressBar)
        circleProgressBar.top(view, equalTo: .top , safeArea: true)
        circleProgressBar.leftAndRight(view)
        circleProgressBar.height(constant: .screenHeight() / 2.0)
        
        view.addSubview(defaultProgressBarHorizontal)
        defaultProgressBarHorizontal.top(circleProgressBar, equalTo: .bottom, constant: 50)
        defaultProgressBarHorizontal.leftAndRight(view, constant: 24)
        defaultProgressBarHorizontal.height(constant: 70)
        
        view.addSubview(lemonadeVerificationProgressBar)
        lemonadeVerificationProgressBar.top(defaultProgressBarHorizontal
                                            , equalTo: .bottom , constant: 20)
        lemonadeVerificationProgressBar.leftAndRight(view ,constant: 24)
        lemonadeVerificationProgressBar.height(constant: 120)
        
        lemonadeVerificationProgressBar.delegate = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.lemonadeVerificationProgressBar.step(to: 4)
        }
        /*
        view.addSubview(defaultProgressBarVertical)
        defaultProgressBarVertical.top(defaultProgressBarHorizontal, equalTo: .bottom, constant: 20)
        defaultProgressBarVertical.width(constant: 70)
        defaultProgressBarVertical.centerX(view, equalTo: .centerX)
        defaultProgressBarVertical.bottom(view, equalTo: .bottom ,safeArea: true)
        */
        
    }
}
extension ProgressBarsVC: LemonadeVerificationDelegate {
    func stepChanged(_ progressBar: LemonadeVerificationProgressBar, step: Int) {
        print(step)
    }
    
    func progressFinished(_ progressBar: LemonadeVerificationProgressBar) {
        print("Finished")
    }
}
extension ProgressBarsVC: LemonadeProgressBarDelegate {
    func percantageChanged(_ bar: LemonadeProgressBar, value: CGFloat) {
        if bar.alignment == .vertical {
            print("Vertical \(value)")
        }
        if bar.alignment == .horizontal {
            print("Horizontal \(value)")
        }
    }
    
    func progressFinished(_ bar: LemonadeProgressBar) {
        if bar.alignment == .vertical {
            print("Vertical Finished")
        }
        if bar.alignment == .horizontal {
            print("Horizontal Finished")
        }
    }
    
    
}
