//
//  Lemonade+ProgressBar.swift
//  LemonadeUI
//
//  Created by Mac on 16.09.2021.
//

public protocol LemonadeProgressBarDelegate : AnyObject {
    
    /// Trigger when percentage changed
    func percantageChanged( _ bar : LemonadeProgressBar , value : CGFloat)
    
    /// Trigger when progress come up to 100.0
    func progressFinished( _ bar : LemonadeProgressBar)
}

public class LemonadeProgressBar : UIView {
    
    public weak var delegate : LemonadeProgressBarDelegate?
    
    /// Active percentage value (GET)
    private(set) var currentPercentage : CGFloat = 0.0 {
        didSet {
            DispatchQueue.main.async { self.delegate?.percantageChanged(self, value: self.currentPercentage) }
        }
    }
    /// Config
    private var config : LemonadeProgressBarConfig?
    
    // Animation Anchor
    private var animationAnchor : NSLayoutConstraint?
    
    /// Current progress label
    public lazy var progressLabel : LemonadeLabel = {
        return LemonadeLabel.init(frame: .zero, config!.textType.text!)
    }()
    
    // Progress View
    private lazy var progressView : UIView = {
        return config!.progressView
    }()
    
    public convenience init(frame: CGRect ,  _ config : LemonadeProgressBarConfig) {
        self.init(frame : frame)
        self.configure(config)
    }
    
    deinit {
        config = nil
        animationAnchor = nil
        delegate = nil
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if animationAnchor == nil { self.configureProgressBar() }
    }
}

extension LemonadeProgressBar {
    
    /// Manuel configure wiith bar config type
    public func configure( _ config : LemonadeProgressBarConfig) {
        self.config = config
        self.currentPercentage = config.starterPercentage
        self.configureLabel()
    }
    /**
     If you want change current percetange with exec function , use this one
     
     - parameter percentage: Exec percentage.
     */
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
    /**
     If you want add percentage current percetange with new percetange , user this one
     
     - parameter percentage: addtional percentage.
     */
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
    
    //Calcualting width or height value with percentage
    private func calculate()-> CGFloat{
        let value = config!.alignment == .horizontal ? bounds.width : bounds.height
        let percentage = ((currentPercentage) * value) / 100
        if currentPercentage <= 100 {
            return percentage
        }
        DispatchQueue.main.async {
            self.delegate?.progressFinished(self)
        }
        return 0.0
    }
    
    // Label configure with type
    private func configureLabel() {
        switch config!.textType {
        case .none:
            break
        default:
            self.addSubview(progressLabel)
            progressLabel.center(to: self)
            progressLabel.width(self, equalTo: .width , multiplier: 0.8)
            self.bringSubviewToFront(progressLabel)
            if config!.alignment == .vertical {
                progressLabel.transform = CGAffineTransform.init(rotationAngle:  -CGFloat.pi / 2)
            }
        }
    }
    // Progress bar configure
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
    
    // This function animate with auto animate duration
    private func autoAnimate() {
        if config!.automaticProgressDuration == 0 { return }
        let total : Double = Double(100.0 - config!.starterPercentage)
        let stepByPerSecond : Double = total / Double(config!.automaticProgressDuration)
        var currentSecond = 0
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.addPercentage(CGFloat(stepByPerSecond))
            currentSecond += 1
            if currentSecond >= self.config!.automaticProgressDuration {
                timer.invalidate()
                DispatchQueue.main.async {
                    self.delegate?.progressFinished(self)
                }
            }
        }
    }
}
