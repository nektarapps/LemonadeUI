//
//  Lemonade+Alert.swift
//  LemonadeUI
//
//  Created by Mac on 16.09.2021.
//


public protocol LemonadeAlertDelegate : AnyObject {
    func alertOpened( _ alert : LemonadeAlert)
    func alertClosed( _ alert : LemonadeAlert)
    func buttonTapped( _ button : LemonadeButton , _ alert : LemonadeAlert)
}


public class LemonadeAlert : UIView {
    
    public weak var delegate : LemonadeAlertDelegate?
    
    var config : LemonadeAlertConfig?
    
    var availablePositions : [LemonadeAlertPosition] = []
    
    public convenience init(frame : CGRect , config : LemonadeAlertConfig) {
        self.init(frame:frame)
        self.addConfig(config)
        
        self.configureUI()
    }
    deinit {
        delegate = nil
    }
    
    public func addConfig( _ config : LemonadeAlertConfig) {
        self.config = config
    }
    
    func configureUI(){
        guard let config = config else { return }
        if !availablePositions.contains(config.position) { return }
    }
    
    public func show(presenter : UIViewController) {
        presenter.view.addSubview(self)
        
        delegate?.alertOpened(self)
    }
    
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

