//
//  LemonadeButton.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 17.08.2021.
//

import UIKit


public class LemonadeButton : UIButton {
    
    ///Switch Button type delegate
    public weak var lemonadeSwitchButtonDelegate : LemonadeSwitchButtonDelegate?
    
    /// Button Click animation
    public var clickAnimation : LemonadeAnimation?
    
    private weak var toggleView : UIView?
    private var toggleLeftAnchor : NSLayoutConstraint?
    private var switchButtonConfig : LemonadeSwitchButtonConfig?
    private var toggleConfig : LemonadeSwitchToggleConfig?
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(frame : CGRect , _ text : LemonadeText) {
        self.init(frame:frame)
        if text.kern != 0.0 || text.underLine != nil { self.attributedText(text) }
        else { self.text(text) }
    }
}

extension LemonadeButton {
    
    /**
     Switch button settings
     
     - parameter config: LemonadeSwitchButtonConfig.
     - parameter toggleConfig: LemonadeSwitchToggleConfig.
     - returns: none
     - warning: Can't add onClick function after setting up
     */
    
    public func switchButton( _ config : LemonadeSwitchButtonConfig , toggleConfig : LemonadeSwitchToggleConfig){
        self.layoutIfNeeded()
        color(toggleConfig.isOn ? config.activeColor : config.deActiveColor)
        createToggledView(toggleConfig)
        self.onClick(target: self, #selector(self.toggleClick))
        
        self.switchButtonConfig = config
        self.toggleConfig = toggleConfig
    }
    
    ///Creating toogling view
    private func createToggledView( _ config : LemonadeSwitchToggleConfig){
        let view : UIView = .init(frame: .zero
                                  , color: config.isOn ? config.activeColor : config.deActiveColor, radius: .init(radius: config.width / 2.0)
                                  , border: config.border)
        view.isUserInteractionEnabled = false
        self.addSubview(view)
        view.height(constant: config.height)
        view.width(constant: config.width)
        view.centerY(self, equalTo: .centerY)
        toggleLeftAnchor = view.leftAnchor.constraint(equalTo: self.leftAnchor , constant: config.isOn ? self.bounds.width - ( config.width + config.padding ) : config.padding)
        toggleLeftAnchor?.isActive = true
        
        self.toggleView = view
    }
    
    /// Toggle trigger with param
    @objc public func toggle( _ value : Bool) {
        if toggleLeftAnchor == nil || toggleView == nil || switchButtonConfig == nil || toggleConfig == nil { return }
        
        toggleLeftAnchor?.constant = value ? self.bounds.width - ( toggleConfig!.width + toggleConfig!.padding ) : toggleConfig!.padding
        
        self.toggleConfig?.onChange(value)
        self.lemonadeSwitchButtonDelegate?.didToggle(self, isOn: value)
        
        UIView.animate(withDuration: switchButtonConfig!.animationDuration) {
            self.color(value ? self.switchButtonConfig!.activeColor : self.switchButtonConfig!.deActiveColor)
            self.toggleView?.color(self.toggleConfig!.isOn ? self.toggleConfig!.activeColor : self.toggleConfig!.deActiveColor)
            self.layoutIfNeeded()
        }
    }
    
    /// Toggle trigger without param
    @objc public func toggleClick(){ toggle( (!(toggleConfig?.isOn ?? false) ) ) }
    
}



extension LemonadeButton {
    
    /// Text configuration function
    public func text( _ text : LemonadeText) {
        self.setTitle(text.text, for: .normal)
        self.setTitleColor(text.color, for: .normal)
        self.titleLabel?.font = text.font
        self.titleLabel?.textAlignment = text.alignment
    }
    /// Atrributed Text configuration function
    public func attributedText( _ text : LemonadeText) {
        self.setAttributedTitle(text.attributeText(), for: .normal)
    }
    
    /// Adding click
    public func onClick(target : Any? , _ action : Selector) {
        if target == nil && superview == nil {
            fatalError("SuperView can't be empty. That's illegal.")
        }
        if toggleConfig != nil || switchButtonConfig != nil { return }
        self.addTarget(target , action: action, for: .touchUpInside)
    }
}


extension LemonadeButton {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let animation = self.clickAnimation {
            self.layoutIfNeeded()
            self.animate(animation, config: .init(duration: 0.3, repeatCount: 1, autoReverse: true))
        }
    }
}
