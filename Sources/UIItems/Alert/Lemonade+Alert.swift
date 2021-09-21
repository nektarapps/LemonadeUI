//
//  Lemonade+Alert.swift
//  LemonadeUI
//
//  Created by Mac on 16.09.2021.
//


public protocol LemonadeAlertDelegate : AnyObject {
    
    /// This func trigger when alert opened
    func alertOpened( _ alert : LemonadeAlert)
    
    /// This func trigger when alert closed
    func alertClosed( _ alert : LemonadeAlert)
    
    /// If Alert has some buttons , this function sending tapped button when some buttons tapped.
    func buttonTapped( _ button : LemonadeButton , _ alert : LemonadeAlert)
}


public class LemonadeAlert : UIView {
    
    /// Alert delegate
    public weak var delegate : LemonadeAlertDelegate?
    
    /// Alert configuration value
    var config : LemonadeAlertConfig?
    
    /// Animation availablePositions
    var availablePositions : [LemonadePosition] = []
    
    /// Animation anchor
    var animateAnchor : NSLayoutConstraint?
    
    /// If alert has some button , this value can not be empty.
    var buttons : [LemonadeButton]? = nil
    
    /// Default icon item
    lazy var icon : UIImageView = {
        let imageView : UIImageView = .init(image: config!.icon)
        imageView.backgroundColor = .red
        return imageView
    }()
    /// Default title label item
    lazy var title : LemonadeLabel = {
        return LemonadeLabel.init(frame: .zero, config!.title)
    }()
    /// Default title message item
    lazy var message : LemonadeLabel = {
        return LemonadeLabel.init(frame: .zero, config!.message!)
    }()
    
    /**
     Public init function with configuration
     
     - parameter config: Configuration for alert.
     - returns: none
     - warning: none
     */
    public convenience init(frame : CGRect , config : LemonadeAlertConfig) {
        self.init(frame:frame)
        self.addConfig(config)
        self.configureUI()
    }
    /**
     Public init function with configuration and buttons
     
     - parameter config: Configuration for alert.
     - parameter buttons: Button will added automaticly
     - returns: none
     - warning: none
     */
    public convenience init(frame : CGRect , config : LemonadeAlertConfig , buttons : [LemonadeButton]) {
        self.init(frame : frame , config : config)
        self.buttons = buttons
    }
    
    deinit {
         animateAnchor = nil
        delegate = nil
    }
    
    /// Manuel adding config function
    public func addConfig( _ config : LemonadeAlertConfig) {
        self.config = config
    }
    
    /// If you want configure alert UI , override this method
    func configureUI(){
        guard let config = config else { return }
        if !availablePositions.contains(config.position) { return }
    }
    
    /// Present function , presenter is current ViewController , if you want write custom alert type , you need to override this method
    public func show(presenter : UIViewController) {
        presenter.view.addSubview(self)
        delegate?.alertOpened(self)
        
        self.configureLayout()
        self.configureItemsLayout()
    }
    
    /// This func trigger after show , Current Alert layout configure function
    func configureLayout(){ }
    /// This func trigger after show , Current alert items configure function
    func configureItemsLayout(){ }
    
    /// Dismiss action
    public func dismiss() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.removeFromSuperview()
        }
        delegate?.alertClosed(self)
    }
    
    @objc public func onButtonTapped(button : LemonadeButton) {
        delegate?.buttonTapped(button, self)
    }
}

