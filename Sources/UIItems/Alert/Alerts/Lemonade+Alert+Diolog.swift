//
//  Lemonade+Alert+Diolog.swift
//  LemonadeUI
//
//  Created by Mac on 16.09.2021.
//

public class LemonadeAlertDialog : LemonadeAlert {
    
    private lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    
    override var availablePositions: [LemonadePosition] {
        get {
            return [ .left , .right , .top , .bottom]
        }
        set {
            self.availablePositions = newValue
        }
    }
    
    override func configureUI() {
        super.configureUI()
        self.icon.tintColor = config!.alertState.alertColor.backgroundColor
        self.color(config!.alertState.alertColor)
        self.radius(.init(radius: 8))
    }
    
    
    override func configureLayout() {
        self.width(superview!, equalTo: .width , multiplier: 0.8)
        switch config!.position {
        case .left:
            animateAnchor = self.leftAnchor.constraint(equalTo: superview!.leftAnchor , constant: -1 * .screenWidth())
            self.centerY(superview!, equalTo: .centerY)
        case .right:
            animateAnchor = self.rightAnchor.constraint(equalTo: superview!.rightAnchor , constant: 2 * .screenWidth())
            self.centerY(superview!, equalTo: .centerY)
        case .top:
            animateAnchor = self.topAnchor.constraint(equalTo: superview!.topAnchor , constant: -1 * .screenHeight())
            self.centerX(superview!, equalTo: .centerX)
        case .bottom:
            animateAnchor = self.bottomAnchor.constraint(equalTo: superview!.bottomAnchor , constant: 2 * .screenHeight())
            self.centerX(superview!, equalTo: .centerX)
        }
        animateAnchor?.isActive = true
    }
    
    public override func show(presenter: UIViewController) {
        super.show(presenter: presenter)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animateAnchor?.isActive = false
            switch self.config!.position {
            case .left:
                self.animateAnchor = self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor , constant: 24)
            case .right:
                self.animateAnchor = self.rightAnchor.constraint(equalTo: self.superview!.rightAnchor , constant: -24)
            case .top , .bottom:
                self.animateAnchor = self.centerYAnchor.constraint(equalTo: self.superview!.centerYAnchor)
            }
            self.animateAnchor?.isActive = true
            
            UIView.animate(withDuration: 1.0) {
                self.superview!.layoutIfNeeded()
            }
            
            if self.config!.closeDuration > 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(self.config!.closeDuration)) {
                    self.dismiss()
                }
            }
        }
    }
    
    public override func dismiss() {
        animateAnchor?.isActive = false
        switch config!.position {
        case .left:
            animateAnchor = self.leftAnchor.constraint(equalTo: superview!.leftAnchor , constant: -1 * .screenWidth())
        case .right:
            animateAnchor = self.rightAnchor.constraint(equalTo: superview!.rightAnchor , constant: 2 * .screenWidth())
        case .top:
            animateAnchor = self.topAnchor.constraint(equalTo: superview!.topAnchor , constant: -1 * .screenHeight())
        case .bottom:
            animateAnchor = self.bottomAnchor.constraint(equalTo: superview!.bottomAnchor , constant: 2 * .screenHeight())
        }
        animateAnchor?.isActive = true
        UIView.animate(withDuration: 1.0) {
            self.superview!.layoutIfNeeded()
        }
        super.dismiss()
    }
    
    
    override func configureItemsLayout() {
        if config!.icon != nil {
            self.addSubview(icon)
            icon.centerX(self, equalTo: .centerX)
            icon.widthAndHeight(self, equalTo: .width , multiplier: 0.4)
            icon.top(self, equalTo: .top , constant: 30)
        }
        self.addSubview(title)
        title.top(config!.icon == nil ? self : icon, equalTo: .bottom, constant: 15)
        title.centerX(self, equalTo: .centerX)
        title.width(self, equalTo: .width , multiplier: 0.8)
        if self.buttons == nil && config!.message == nil {
            title.bottom(self, equalTo: .bottom , constant: -30)
        }
        if config!.message != nil {
            self.addSubview(message)
            message.centerX(self, equalTo: .centerX)
            message.width(self, equalTo: .width , multiplier: 0.8)
            message.top(title, equalTo: .bottom , constant: 15)
            if buttons == nil {
                message.bottom(self, equalTo: .bottom , constant: -30)
            }
        }
        if buttons != nil {
            self.addSubview(stackView)
            for button in buttons! {
                button.onClick(target: self, #selector(onButtonTapped(button:)))
                stackView.addArrangedSubview(button)
                button.width(self, equalTo: .width , multiplier: 0.8)
                button.height(constant: 50)
            }
            
            stackView.centerX(self, equalTo: .centerX)
            stackView.width(self, equalTo: .width , multiplier: 0.8)
            stackView.top(message, equalTo: .bottom , constant: 10)
            stackView.bottom(self, equalTo: .bottom , constant: -30)
        }
    }
}


