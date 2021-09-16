//
//  Lemonade+Bar+Alert.swift
//  LemonadeUI
//
//  Created by Mac on 16.09.2021.
//

public class LemonadeBarAlert: LemonadeAlert {
    
    private var animateAnchor : NSLayoutConstraint?
    
    private lazy var icon : UIImageView = {
        let imageView : UIImageView = .init(image: config!.icon)
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private lazy var title : UILabel = {
        return LemonadeLabel.init(frame: .zero, config!.title)
    }()
    private lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    override var availablePositions: [LemonadeAlertPosition] {
        get {
            return [.top , .bottom]
        }
        set {
            self.availablePositions = newValue
        }
    }
    
    private var buttons : [LemonadeButton]? = nil
    
    public convenience init(frame : CGRect , config : LemonadeAlertConfig , buttons : [LemonadeButton]) {
        self.init(frame : frame , config : config)
        self.buttons = buttons
    }
    
    
    deinit {
        animateAnchor = nil
    }
    
    override func configureUI() {
        super.configureUI()
        self.color(config!.alertState.alertColor)
        self.radius(.init(radius: 12))
        self.border(.init(borderColor: .white, width: 2.0))
    }
    public override func show(presenter: UIViewController) {
        super.show(presenter: presenter)
        self.configureLayout()
        self.configureItemsLayout()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animateAnchor?.isActive = false
            self.animateAnchor = self.config!.position == .top ? self.topAnchor.constraint(equalTo: self.superview!.topAnchor , constant: 60) : self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor , constant: -60)
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
        animateAnchor = config!.position == .top ? self.topAnchor.constraint(equalTo: superview!.topAnchor , constant: -1 * .screenHeight()) : self.bottomAnchor.constraint(equalTo: superview!.bottomAnchor , constant: 2 * .screenHeight())
        animateAnchor?.isActive = true
        UIView.animate(withDuration: 1.0) {
            self.superview!.layoutIfNeeded()
        }
        super.dismiss()
    }
}
extension LemonadeBarAlert {
    private func configureLayout() {
        self.leftAndRight(superview! , constant: 24)
        animateAnchor = config!.position == .top ? self.topAnchor.constraint(equalTo: superview!.topAnchor , constant: -1 * .screenHeight()) : self.bottomAnchor.constraint(equalTo: superview!.bottomAnchor , constant: 2 * .screenHeight())
        animateAnchor?.isActive = true
    }
    private func configureItemsLayout(){
        if config!.icon != nil {
            self.addSubview(icon)
            icon.left(self, equalTo: .left , constant: 10)
            icon.centerY(self, equalTo: .centerY)
            icon.widthAndHeight(self, equalTo: .height , multiplier: 0.5)
        }
        
        self.addSubview(title)
        title.left(config!.icon == nil ? self : icon, equalTo: .left, constant: 15)
        title.right(self, equalTo: .right ,constant: -15)
        title.top(self, equalTo: .top , constant: 10)
        if self.buttons == nil {
            title.bottom(self, equalTo: .bottom , constant: -10)
        }
        
        if self.buttons != nil {
            self.addSubview(stackView)
            for button in buttons! {
                button.onClick(target: self, #selector(onButtonTapped(button:)))
                stackView.addArrangedSubview(button)
            }
            
            stackView.leftAndRight(self , constant: 15)
            stackView.top(title, equalTo: .bottom , constant: 10)
            stackView.bottom(self, equalTo: .bottom , constant: -10)
            stackView.centerX(self, equalTo: .centerX)
            stackView.height(constant: 50)
        }
    }
}

