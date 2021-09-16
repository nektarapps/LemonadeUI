//
//  Lemonade+ProgressBar.swift
//  LemonadeUI
//
//  Created by Mac on 16.09.2021.
//


public class LemonadeProgressBar : UIView {
    
    private var currentPercentage : CGFloat = 0.0
    
    private var config : LemonadeProgressBarConfig?
    private var animationAnchor : NSLayoutConstraint?
    
    lazy var progressLabel : LemonadeLabel = {
        return LemonadeLabel.init(frame: .zero, config!.textType.text!)
    }()
    
    private lazy var progressView : UIView = {
        return config!.progressView
    }()
    
    public convenience init(frame: CGRect ,  _ config : LemonadeProgressBarConfig) {
        self.init(frame : frame)
        self.configure(config)
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        if animationAnchor == nil { self.configureProgressBar() }
    }
}

extension LemonadeProgressBar {
    public func configure( _ config : LemonadeProgressBarConfig) {
        self.config = config
        self.currentPercentage = config.starterPercentage
        self.configureLabel()
    }
    
    public func updatePercanteage( _ percentage : CGFloat? = nil ) {
        if animationAnchor == nil { return }
        if percentage != nil {
            currentPercentage = percentage!
        }
        DispatchQueue.main.async {
            switch self.config!.textType {
            case .none , .custom:
                break
            case .auto:
                self.progressLabel.text = "% \(Int(self.currentPercentage))"
            }
            self.animationAnchor?.constant = self.calculate()
            UIView.animate(withDuration: 1.0) {
                self.layoutIfNeeded()
            }
        }
    }
    
    public func addPercentage( _ percentage : CGFloat ) {
        if animationAnchor == nil { return }
        currentPercentage += percentage
        if currentPercentage > 100 {
            currentPercentage = 100.0
        }
        self.updatePercanteage()
    }
}
extension LemonadeProgressBar {
    
    private func calculate()-> CGFloat{
        let value = config!.alignment == .horizontal ? bounds.width : bounds.height
        let percentage = ((currentPercentage) * value) / 100
        if currentPercentage <= 100 {
            return percentage
        }
        return 0.0
    }
    
    private func configureLabel() {
        switch config!.textType {
        case .none:
            break
        default:
            self.addSubview(progressLabel)
            progressLabel.center(to: self)
            progressLabel.width(self, equalTo: .width , multiplier: 0.8)
            self.bringSubviewToFront(progressLabel)
        }
    }
    
    private func configureProgressBar(){
        self.addSubview(progressView)
        self.sendSubviewToBack(progressView)
        switch config!.alignment {
            case .horizontal:
                progressView.left(self, equalTo: .left)
                progressView.top(self, equalTo: .top)
                progressView.bottom(self, equalTo: .bottom)
                animationAnchor = progressView.widthAnchor.constraint(equalToConstant: calculate())
            case .vertical:
                progressView.bottom(self, equalTo: .bottom)
                progressView.left(self, equalTo: .left)
                progressView.right(self, equalTo: .right)
                animationAnchor = progressView.heightAnchor.constraint(equalToConstant: calculate())
            }
        animationAnchor?.isActive = true
        
        self.autoAnimate()
    }
    
    
    private func autoAnimate() {
        if config!.automaticProgressDuration == 0 { return }
        let stepByPerSecond : Double = Double(100 / config!.automaticProgressDuration)
        var currentSecond = 0
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.addPercentage(CGFloat(stepByPerSecond))
            currentSecond += 1
            if currentSecond >= self.config!.automaticProgressDuration {
                timer.invalidate()
            }
        }
    }
}
