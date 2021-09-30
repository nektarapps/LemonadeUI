//
//  Lemonade+Slider.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 30.09.2021.
//


public class LemonadeSlider : UIView {
    private var config : LemonadeSliderConfig?
    convenience init(frame : CGRect , _  config : LemonadeSliderConfig) {
        self.init(frame: frame)
        self.configure(config)
    }
    
    private lazy var totalDistance : CGFloat = {
        return (config?.endValue ?? 0) - (config?.startValue ?? 0)
    }()
    private lazy var space : CGFloat = {
        return bounds.width / totalDistance
    }()
}
extension LemonadeSlider {
    public func configure( _ config : LemonadeSliderConfig) {
        self.config = config
    }
}
