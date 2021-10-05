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
    private var centerX : CGFloat {
        return bounds.width / 2.0
    }
    
    private var firstThumbValue : CGFloat = 0.0
    private var secondThumbValue : CGFloat = 0.0
    
    
    private lazy var slider : UIView = {
        return .init(frame: .zero, color: .init(backgroundColor: config!.sliderColor))
    }()
    
    private var firstThumbCenterX :NSLayoutConstraint?
    private lazy var firstThumb : UIView = {
        return .init(frame: .zero, color: .init(backgroundColor: config!.thumbConfig.color)
                     ,radius: .init(radius: (config!.thumbConfig.height / 2))
                     , border: config!.thumbConfig.border )
    }()
    private var secondThumbCenterX :NSLayoutConstraint?
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
        let point = centerX - (config!.thumbConfig.value * spacing)
    
        firstThumb.widthAndHeight(constant: config!.thumbConfig.height)
        firstThumbCenterX = firstThumb.centerXAnchor.constraint(equalTo: slider.centerXAnchor, constant: -point)
        firstThumbCenterX?.isActive = true
        firstThumb.centerY(slider, equalTo: .centerY)
        firstThumbPanGesture = .init(target: self, action: #selector(thumbGesture(gesture:)))
        firstThumbPanGesture?.minimumNumberOfTouches = 1
        firstThumbPanGesture?.maximumNumberOfTouches = 1
        firstThumb.addGestureRecognizer(firstThumbPanGesture!)
        firstThumbValue = config!.thumbConfig.value
        
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
        let point = centerX - (config!.secondThumbConfig!.value * spacing)
        secondThumb.widthAndHeight(constant: config!.secondThumbConfig!.height)
        
        secondThumbCenterX = secondThumb.centerXAnchor.constraint(equalTo: slider.centerXAnchor, constant: -point)
        secondThumbCenterX?.isActive = true
        secondThumb.centerY(slider, equalTo: .centerY)
        
        
        secondThumbPanGesture = .init(target: self, action: #selector(thumbGesture(gesture:)))
        secondThumbPanGesture?.minimumNumberOfTouches = 1
        secondThumbPanGesture?.maximumNumberOfTouches = 1
        secondThumb.addGestureRecognizer(secondThumbPanGesture!)
        secondThumbValue = config!.secondThumbConfig!.value
        if config!.secondLabelText != nil {
            addSubview(secondThumbLabel)
            secondThumbLabel.centerX(secondThumb, equalTo: .centerX)
            secondThumbLabel.top(secondThumb, equalTo: .bottom , constant: 5)
            secondThumbLabel.width(constant: 30)
        }
    }
}

extension LemonadeSlider {
    private func distanceIsValid(view:  UIView, newValue : CGFloat) -> Bool {
        if config!.minDistaceBetweenThumbs == nil { return true }
        let minDistance : CGFloat = CGFloat(config!.minDistaceBetweenThumbs!)
        var bigger : CGFloat = 0.0
        var smaller : CGFloat = 0.0
        if firstThumbValue > secondThumbValue {
            bigger = firstThumbValue
            smaller = secondThumbValue
        }else {
            bigger = secondThumbValue
            smaller = firstThumbValue
        }
        let biggerView = firstThumbValue > secondThumbValue ? firstThumb : secondThumb
        let min = biggerView == view ? smaller + minDistance : bigger - minDistance
        
        return biggerView == view ? newValue >= min : newValue <= min
    }
    @objc private func thumbGesture(gesture : UIPanGestureRecognizer){
        guard gesture.view != nil else { return }
        let pin = gesture.translation(in: gesture.view!)
        if pin.x > centerX || pin.x < (-centerX) {
            return
        }
        let point = pin.x / spacing
        let value = Int((self.config!.endValue / 2) + point)
        if !distanceIsValid(view:gesture.view! ,newValue: CGFloat(value)) { return }
        if gesture.view == self.firstThumb {
            self.firstThumbCenterX?.constant = pin.x
            firstThumbValue = CGFloat.init(value)
            self.delegate?.thumbChanged(CGFloat(value), self, thumbIndex: 0)
            self.firstThumbLabel.text = String.init(describing: Int(value))
        }
        if gesture.view == self.secondThumb {
            self.secondThumbCenterX?.constant = pin.x
            secondThumbValue = CGFloat.init(value)
            self.delegate?.thumbChanged(CGFloat(value), self, thumbIndex: 1)
            self.secondThumbLabel.text = String.init(describing: Int(value))
        }
    }
}
