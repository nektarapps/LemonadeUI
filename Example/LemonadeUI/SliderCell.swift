//
//  SliderCell.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 27.01.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import LemonadeUI


class SliderTableViewCell : UITableViewCell {
    private lazy var slider: LemonadeSlider = {
        let slider: LemonadeSlider = .init(frame: .zero)
        slider.backgroundColor = .clear
        return slider
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(slider)
        slider.fill2SuperView(.init(right: 24, left: 24, top: 5, bottom: 5))
    }
    func configureUI(thumbCount: Int) {
        let config: LemonadeSliderConfig
        let thumbConfig_1 = LemonadeThumbConfig(color: .orange, value: 20, height: 25)
        let thumbConfig_2 = LemonadeThumbConfig(color: .brown, value: 50, height: 25)
        switch thumbCount {
        case 1:
            config = .init(sliderColor: .red, startValue:0 , endValue: 100, sliderHeight: 5, thumbConfig: thumbConfig_1, thumbLabelText: .init(text: "20" , color: .black))
        case 2:
            config = .init(sliderColor: .red, startValue: 0, endValue: 100, sliderHeight: 5, thumbConfig: thumbConfig_1, thumbLabelText: .init(text: "20" , color: .black), secondThumbConfig: thumbConfig_2, secondLabelText: .init(text: "50" , color: .black), maskedViewThumbsBetweenThumbs: .init(frame: .zero, color: .init(backgroundColor: .black)))
        default:
            config = .init(sliderColor: .red, startValue:0 , endValue: 100, sliderHeight: 5, thumbConfig: thumbConfig_1, thumbLabelText: .init(text: "20" , color: .black))
        }
        slider.configure(config)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
