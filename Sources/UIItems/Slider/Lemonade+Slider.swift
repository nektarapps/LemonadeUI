//
//  Lemonade+Slider.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 30.09.2021.
//

import CoreGraphics

public protocol LemonadeSliderDelegate : AnyObject {
    func thumbChanged( _ value : CGFloat , _ slider : LemonadeSlider , thumbIndex : Int)
}


public class LemonadeSlider : UIView {
    private var config : LemonadeSliderConfig?
    
    public weak var delegate : LemonadeSliderDelegate?
    
    public convenience init(frame : CGRect , _  config : LemonadeSliderConfig) {
        self.init(frame: frame)
        self.configure(config)
    }
    
    private lazy var totalDistance : CGFloat = {
        return (config?.endValue ?? 0) - (config?.startValue ?? 0)
    }()
    private lazy var spacing : CGFloat = {
        return bounds.width / totalDistance
    }()
    private var centerY : CGFloat {
        return bounds.height / 2.0
    }
    
    private lazy var slider : UIView = {
        return .init(frame: .zero, color: .init(backgroundColor: config!.sliderColor))
    }()
    
    private lazy var firstThumb : UIView = {
        return .init(frame: .zero, color: .init(backgroundColor: config!.thumbConfig.color)
                     ,radius: .init(radius: (config!.thumbConfig.height / 2))
                     , border: config!.thumbConfig.border )
    }()
    private lazy var secondThumb : UIView = {
        return .init(frame: .zero, color: .init(backgroundColor: config!.secondThumbConfig!.color)
                     ,radius: .init(radius: (config!.secondThumbConfig!.height / 2))
                     , border: config!.secondThumbConfig!.border )
    }()
    
    private lazy var firstThumbLabel : LemonadeLabel = {
        return .init(frame: .zero, config!.thumbLabelText!)
    }()
    private lazy var secondThumbLabel : LemonadeLabel = {
        return .init(frame: .zero, config!.secondLabelText!)
    }()
    
    private var isDraw = false
    
    private var firstThumbPanGesture : UIPanGestureRecognizer?
    private var secondThumbPanGesture : UIPanGestureRecognizer?
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if isDraw { return }
        if config != nil {
            createSlider()
            createFirstThumb()
            if config!.secondThumbConfig != nil {
                if config!.secondThumbConfig!.value == config!.thumbConfig.value {
                    fatalError("First and second thumb value can't be equal")
                }
                createSecondThumb()
            }
            isDraw = true
        }
    }
}
extension LemonadeSlider {
    public func configure( _ config : LemonadeSliderConfig) {
        self.isUserInteractionEnabled = true
        self.config = config
    }
}

extension LemonadeSlider {
    private func createSlider(){
        addSubview(slider)
        slider.frame = .init(x: 0, y: centerY - (config!.height / 2 ) , width: bounds.width, height: config!.height)
    }
    
    private func createFirstThumb(){
        let condition = config!.thumbConfig.value > config!.endValue || config!.thumbConfig.value < 0
        if condition {
            fatalError("Thumb Starter Value need to be bigger than slider starter point")
        }
        addSubview(firstThumb)
        let point = (config!.thumbConfig.value * spacing) - (config!.thumbConfig.height / 2)
        firstThumb.frame = .init(x: point, y: centerY - (config!.thumbConfig.height / 2), width: config!.thumbConfig.height, height: config!.thumbConfig.height)
        
        firstThumbPanGesture = .init(target: self, action: #selector(thumbGesture(gesture:)))
        firstThumbPanGesture?.minimumNumberOfTouches = 1
        firstThumbPanGesture?.maximumNumberOfTouches = 1
        firstThumb.addGestureRecognizer(firstThumbPanGesture!)
        
        if config!.thumbLabelText != nil {
            addSubview(firstThumbLabel)
            firstThumbLabel.centerX(firstThumb, equalTo: .centerX)
            firstThumbLabel.top(firstThumb, equalTo: .bottom , constant: 5)
            firstThumbLabel.width(constant: 30)
        }
        
    }
    
    private func createSecondThumb(){
        let condition = config!.secondThumbConfig!.value > config!.endValue || config!.secondThumbConfig!.value < 0
        if condition {
            fatalError("Thumb Starter Value need to be bigger than slider starter point")
        }
        addSubview(secondThumb)
        let point = (config!.secondThumbConfig!.value * spacing) - (config!.secondThumbConfig!.height / 2)
        secondThumb.frame = .init(x: point, y: centerY - (config!.thumbConfig.height / 2), width: config!.thumbConfig.height, height: config!.thumbConfig.height)
        
        secondThumbPanGesture = .init(target: self, action: #selector(thumbGesture(gesture:)))
        secondThumbPanGesture?.minimumNumberOfTouches = 1
        secondThumbPanGesture?.maximumNumberOfTouches = 1
        secondThumb.addGestureRecognizer(secondThumbPanGesture!)
        
        if config!.secondLabelText != nil {
            addSubview(secondThumbLabel)
            secondThumbLabel.centerX(secondThumb, equalTo: .centerX)
            secondThumbLabel.top(secondThumb, equalTo: .bottom , constant: 5)
            secondThumbLabel.width(constant: 30)
        }
    }
}

extension LemonadeSlider {
    @objc private func thumbGesture(gesture : UIPanGestureRecognizer){
        let pin = gesture.translation(in: gesture.view!)
        if pin.x < 0 || pin.x > bounds.width - (config!.thumbConfig.height / 2) {
            return
        }
        if gesture.view == self.firstThumb {
            let point = (pin.x * spacing) - (config!.thumbConfig.height / 2)
            let value = point / spacing
            
            self.firstThumb.frame = .init(x: pin.x, y: self.centerY - (self.config!.thumbConfig.height / 2), width: self.config!.thumbConfig.height, height: self.config!.thumbConfig.height)
            if self.config!.thumbLabelText != nil {
                self.firstThumbLabel.text = "\(Int(value))"
            }
            self.delegate?.thumbChanged(point, self, thumbIndex: 0)
        }
        if gesture.view == self.secondThumb {
            let point = (pin.x * spacing) - (config!.secondThumbConfig!.height / 2)
            let value = point / spacing
            
            self.secondThumb.frame = .init(x: pin.x, y: self.centerY - (self.config!.secondThumbConfig!.height / 2), width: self.config!.secondThumbConfig!.height, height: self.config!.secondThumbConfig!.height)
            if self.config!.secondLabelText != nil {
                self.secondThumbLabel.text = "\(Int(value))"
            }
            self.delegate?.thumbChanged(point, self, thumbIndex: 1)
            
        }
    }
}
