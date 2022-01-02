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
        return (bounds.width - ((config?.thumbConfig.height ?? 0.0) * 2)) / totalDistance
    }()
    private var centerY : CGFloat {
        return bounds.height / 2.0
    }
    private var centerX : CGFloat {
        return (bounds.width - ((config?.thumbConfig.height ?? 0.0) * 2)) / 2.0
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
    
    public lazy var firstThumbLabel : LemonadeLabel = {
        let text: LemonadeText = config!.thumbLabelText ?? .init(text: config!.isThumbsLabelsTrackProgress ? "\(Int(firstThumbValue))" : "",color:.black ,font : .systemFont(ofSize: 12))
        return .init(frame: .zero, text)
    }()
    public lazy var secondThumbLabel : LemonadeLabel = {
        let text: LemonadeText = config!.secondLabelText ?? .init(text: config!.isThumbsLabelsTrackProgress ? "\(Int(secondThumbValue))" : "",color:.black ,font : .systemFont(ofSize: 12))
        return .init(frame: .zero, text)
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
            
            createMaskedView()
            isDraw = true
        }
    }
}
extension LemonadeSlider {
    public func configure( _ config : LemonadeSliderConfig) {
        self.isUserInteractionEnabled = true
        self.config = config
    }
    public func moveFirstThumb(value: CGFloat) {
        guard let config = config else { return }
        let condition = value > config.endValue || value < 0
        if condition {
            fatalError("Thumb Value need to be less than endValue")
        }
        moveThumb(point: convertSliderPoint(value: value), view: firstThumb)
    }
    public func moveSecondThumb(value: CGFloat) {
        guard let config = config , config.secondThumbConfig != nil else { return }
        let condition = value > config.endValue || value < 0
        if condition {
            fatalError("Thumb Value need to be less than endValue")
        }
        moveThumb(point: convertSliderPoint(value: value), view: secondThumb)
    }
}

extension LemonadeSlider {
    private func createSlider(){
        addSubview(slider)
        slider.frame = .init(x: config?.thumbConfig.height ?? 0.0, y: centerY - (config!.height / 2 ) , width: bounds.width - (config?.thumbConfig.height ?? 0.0), height: config!.height)
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
        
        addSubview(firstThumbLabel)
        firstThumbLabel.centerX(firstThumb, equalTo: .centerX)
        firstThumbLabel.top(firstThumb, equalTo: .bottom , constant: 5)
        firstThumbLabel.width(constant: 30)
        
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
        addSubview(secondThumbLabel)
        secondThumbLabel.centerX(secondThumb, equalTo: .centerX)
        secondThumbLabel.top(secondThumb, equalTo: .bottom , constant: 5)
        secondThumbLabel.width(constant: 30)
    }
    
    private func createMaskedView(){
        let maskedView = config!.maskeedViewBetweenThumbs
        addSubview(maskedView)
        maskedView.height(constant: config!.height)
        maskedView.centerY(slider, equalTo: .centerY)
        if config!.secondThumbConfig == nil {
            maskedView.left(slider, equalTo: .left)
            maskedView.right(firstThumb, equalTo: .left)
        }else {
            let smallThumb = firstThumbValue > secondThumbValue ? secondThumb : firstThumb
            let bigThumb   = firstThumbValue > secondThumbValue ? firstThumb : secondThumb
            maskedView.left(smallThumb, equalTo: .right)
            maskedView.right(bigThumb, equalTo: .left)
        }
    }
}

extension LemonadeSlider {
    private func distanceIsValid(view:  UIView, newValue : CGFloat) -> Bool {
        if config!.minDistaceBetweenThumbs == nil { return true }
        let biggerValue  : CGFloat
        let smallerValue : CGFloat
        let biggerView   : UIView
        if firstThumbValue > secondThumbValue {
            biggerView = firstThumb
            biggerValue = firstThumbValue
            smallerValue = secondThumbValue
        }else {
            biggerView = secondThumb
            biggerValue = secondThumbValue
            smallerValue = firstThumbValue
        }
        return biggerView == view ? newValue >= (smallerValue + config!.minDistaceBetweenThumbs!) : newValue <= (biggerValue - config!.minDistaceBetweenThumbs!)
    }
    @objc private func thumbGesture(gesture : UIPanGestureRecognizer){
        guard gesture.view != nil else { return }
        let pin = gesture.translation(in: gesture.view!)
        if pin.x > centerX || pin.x < (-centerX) {
            return
        }
        let point = pin.x / spacing
        moveThumb(point: point, view: gesture.view!)
    }
    
    private func moveThumb(point: CGFloat , view: UIView) {
        let pinX = point * spacing
        let value = convertValue(sliderPoint: point)
        if !distanceIsValid(view: view, newValue: CGFloat(value)) { return }
        if view == self.firstThumb {
            self.firstThumbCenterX?.constant = pinX
            firstThumbValue = CGFloat.init(value)
            self.delegate?.thumbChanged(CGFloat(value), self, thumbIndex: 0)
            if config!.isThumbsLabelsTrackProgress {
                self.firstThumbLabel.text = String.init(describing: Int(value))
            }
        }
        if config!.secondThumbConfig == nil {return}
        if view == self.secondThumb {
            self.secondThumbCenterX?.constant = pinX
            secondThumbValue = CGFloat.init(value)
            self.delegate?.thumbChanged(CGFloat(value), self, thumbIndex: 1)
            if config!.isThumbsLabelsTrackProgress {
                self.secondThumbLabel.text = String.init(describing: Int(value))
            }
        }
    }
    private func convertValue(sliderPoint: CGFloat) -> Int {
        return Int((self.config!.endValue / 2) + sliderPoint)
    }
    private func convertSliderPoint(value: CGFloat) -> CGFloat {
        return -1 * ((config!.endValue / 2.0) - value)
    }
}


