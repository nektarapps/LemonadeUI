//
//  Lemonade+Verification+ProgressBar.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 2.03.2022.
//

import Foundation

public protocol LemonadeVerificationDelegate: AnyObject {
    
    /// Step Changed function
    func stepChanged( _ progressBar: LemonadeVerificationProgressBar, step: Int)
    
    /// Progress Finished function
    func progressFinished(_ progressBar: LemonadeVerificationProgressBar)
}


public class LemonadeVerificationProgressBar: UIView {
    
    public weak var delegate: LemonadeVerificationDelegate?

    private lazy var backgroundProgressBar: UIView = {
        return UIView(frame: .zero
                      , color: config?.barBacgroundColor ?? .init(backgroundColor: .systemGray)
                      , radius: .init(radius: 3))
    }()
    
    private lazy var progressBarView: UIView = {
        return UIView(frame: .zero
                      , color: config?.progressBarColor ?? .init(backgroundColor: .systemGreen)
                      , radius: .init(radius: 3))
    }()
    
    private var currentStep : Int = 0
    
    private var widthForPerStep: CGFloat = 0.0
    
    private var animationAnchor: NSLayoutConstraint?
    
    private var config: LemonadeVerificationProgressBarConfig?
    
    private var currentSubItems: [(UIImageView , UILabel)] = []
    
    public convenience init(frame: CGRect
                            ,  _ config : LemonadeVerificationProgressBarConfig) {
        self.init(frame : frame)
        self.configure(config)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if animationAnchor != nil { return }
        configureProgress()
        configureProgressItems()
    }
    
    deinit {
        config = nil
        delegate = nil
    }
    
    public func configure( _ config: LemonadeVerificationProgressBarConfig) {
        self.config = config
        if config.startStep > config.items.count - 1 { fatalError("Current step can't be bigger than items count ")}
        self.currentStep = config.startStep
        configureProgressBar()
    }
    
    private func configureProgressBar(){
        addSubview(backgroundProgressBar)
        backgroundProgressBar.addSubview(progressBarView)
        
        backgroundProgressBar.top(self, equalTo: .top , constant: 10)
        backgroundProgressBar.leftAndRight(self , constant: 24)
        backgroundProgressBar.height(constant: 6)
        
        progressBarView.left(backgroundProgressBar, equalTo: .left)
        progressBarView.top(backgroundProgressBar, equalTo: .top)
        progressBarView.bottom(backgroundProgressBar, equalTo: .bottom)
    }
    
    private func configureProgress(){
        calculatePerStepWidth()
        let index = self.currentStep + 1
        animationAnchor = progressBarView.widthAnchor.constraint(equalToConstant: widthForPerStep * CGFloat(index))
        animationAnchor?.isActive = true
    }
    
    private func updateProgress(progressBarIndex: Int, imageIndex: Int, imageColor: LemonadeColor) {
        animationAnchor?.constant = widthForPerStep * CGFloat(progressBarIndex)
        currentSubItems[imageIndex].0.color(imageColor)
        UIView.animate(withDuration: 0.4) { [weak self] in
              self?.layoutIfNeeded()
        }
        delegate?.stepChanged(self, step: currentStep)
    }
    
    private func configureProgressItems(){
        guard let config = config , !config.items.isEmpty else {
            return
        }
        for (index,item) in config.items.enumerated() { createPerItem(index: index, item: item) }
    }
    
    private func createPerItem(index: Int,item: LemonadeVerificationProgressBarItem) {
        let imageView : UIImageView
        if #available(iOS 13.0, *) {
             imageView = UIImageView(image: .init(systemName: item.iconName))
        } else {
            imageView = UIImageView(image: .init(named: item.iconName))
        }
        guard let config = config else { return }
        imageView.color(currentStep > index ? config.activeImageBackgroundColor : config.defaultImageBackgroundColor)
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.radius(.init(radius: 8))
        
        addSubview(imageView)
        imageView.top(progressBarView, equalTo: .top, constant: -5)
        imageView.left(self, equalTo: .left , constant: (CGFloat((index + 1)) * widthForPerStep) + 15)
        imageView.widthAndHeight(constant: 16)
        
        let label: LemonadeLabel = .init(frame: .zero, item.text)
        addSubview(label)
        label.centerX(imageView, equalTo: .centerX)
        label.top(imageView, equalTo: .bottom , constant: 4)
        label.widthAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true

        currentSubItems.append((imageView,label))
    }
    private func calculatePerStepWidth(){
        guard let config = config else { return }
        let safeWidth: CGFloat = bounds.width - 48
        widthForPerStep = safeWidth / CGFloat(config.items.count)
    }
 }
extension LemonadeVerificationProgressBar {
    public func nextStep(){
        guard let config = config ,!config.items.isEmpty else { return }
        if (currentStep + 1) > (config.items.count - 1) { return }
        currentStep += 1
        updateProgress(progressBarIndex: currentStep + 1, imageIndex: currentStep - 1, imageColor: config.activeImageBackgroundColor)
        if currentStep == config.items.count - 1 { delegate?.progressFinished(self) }
    }
    public func previousStep(){
        guard let config = config ,!config.items.isEmpty else { return }
        if (currentStep - 1) < 0 { return }
        currentStep -= 1
        updateProgress(progressBarIndex: currentStep + 1, imageIndex: currentStep, imageColor: config.defaultImageBackgroundColor)
    }
    public func step(to: Int) {
        guard let config = config ,!config.items.isEmpty else { return }
        let condition = ((currentStep + 1) > (config.items.count - 1)) && ((currentStep - 1) < 0)
        if condition { return }
        let diff = to - currentStep
        if diff < 0 {
            for _ in diff...0 { previousStep() }
        }else {
            for _ in 1...diff { nextStep() }
        }
    }
}
