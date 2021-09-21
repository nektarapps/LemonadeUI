//
//  LemonadeTextfield.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 19.08.2021.
//

import UIKit


public protocol LemonadeTextFieldDelegate : AnyObject {
    
    /**
     Sending valid state depends on regex
     
     - parameter textfield: Current textfield.
     - parameter value: Valid state depends on regex.
     */
    func isTextValid( _ textfield : LemonadeTextfield ,  _ value : Bool)
    
    /**
     
     Send valid state depends on minumum char count
     
     - parameter textfield: Current textfield.
     - parameter value: Valid state depends on minumum char count.
     */
    func isMinimumLimitValid( _ textfield : LemonadeTextfield ,  _ value : Bool )
    /**
     
     Send valid state depends on maximum char count
     
     - parameter textfield: Current textfield.
     - parameter value: Valid state depends on maximum char count.
     */
    func isMaximumLimitValid( _ textfield : LemonadeTextfield ,  _ value : Bool )
    
    /// Trigger when user tap something on textfield
    func didTextChange( _ textfield : LemonadeTextfield)
    
    
}
extension LemonadeTextFieldDelegate {
    func isTextValid( _ textfield : LemonadeTextfield ,  _ value : Bool) {}
    func isMinimumLimitValid( _ textfield : LemonadeTextfield ,  _ value : Bool ) {}
    func isMaximumLimitValid( _ textfield : LemonadeTextfield ,  _ value : Bool ) {}
    func didTextChange( _ textfield : LemonadeTextfield) {}
}




public class LemonadeTextfield : UITextField {
    
    /// Lemonade delegate
    public weak var lemonadeDelegate : LemonadeTextFieldDelegate?
    
    /// Validation regex getter
    private(set) var validationRegex : String? = nil
    
    /// Validation state
    private(set) var isValidationEnabled : Bool = false
    
    /// Empty char state
    public var isEmptyCharAllowed : Bool = false
    
    /// Maximum char limit. If you set , use delegate isMaximumLimitValid function
    public var maximumCharLimit : Int? = nil
    
    /// Maximum char limit. If you set , use delegate isMinimumLimitValid function
    public var minimumCharLimit : Int? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    deinit {
        self.delegate = nil
        self.removeTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private(set) var lemonadeText : LemonadeText?
    
    private var UIStates: [LemonadeStateConfig] = []
    
    /// Lemonade Text init
    public convenience init(frame : CGRect , text : LemonadeText) {
        self.init(frame : frame)
        self.text(text)
    }
    /// Collapse Lemonade Text init
    public convenience init(frame : CGRect , text : LemonadeText , placeholder : LemonadeText) {
        self.init(frame:frame)
        self.text(text)
        self.placeholder(placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension LemonadeTextfield {
    public func text( _ text : LemonadeText) {
        self.text = text.text
        self.textColor = text.color
        self.textAlignment = text.alignment
        self.font = text.font
        
        self.lemonadeText = text
    }
    public func placeholder(  _ placeholder : LemonadeText){
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = placeholder.alignment
        let attributes = NSAttributedString(string: placeholder.text
                                            , attributes: [
                                                NSAttributedString.Key.foregroundColor : placeholder.color
                                                , NSAttributedString.Key.font : placeholder.font ,
                                                NSAttributedString.Key.paragraphStyle : paragraph , NSAttributedString.Key.kern : placeholder.kern])
        self.attributedPlaceholder = attributes
    }
    
    /**
     Set UI state
     
     - parameter state: LemonadeUIState.
     - parameter customView: Optional view , if dont want to use default state view type.
     */
    public func setState( _ state : LemonadeUIState , customView : UIView? = nil){
        if UIStates.contains(where: {$0.state == state}) { return }
        let view : UIView = customView != nil ? customView! : .init(frame: .zero, color: .init(backgroundColor: state.color.withAlphaComponent(0.5)), radius: .init(radius: 0), border: .init(borderColor: state.color, width: 2.0))
        view.isHidden = true
        self.addSubview(view)
        view.fill2SuperView()
        self.UIStates.append(.init(state: state, view: view))
    }
    
    /// Open state view
    public func openState( _ state : LemonadeUIState){
        if let item = self.UIStates.first(where: { $0.state == state }){
            item.view.isHidden = false
        }
    }
    
    /// Close state view
    public func closeState( _ state : LemonadeUIState){
        if let item = self.UIStates.first(where: { $0.state == state }){
            item.view.isHidden = true
        }
    }
}

extension LemonadeTextfield {
    
    /// Delete validation if exists
    public func removeValidation(){
        self.validationRegex = nil
        self.isValidationEnabled = false
    }
    
    /// Add custom rule. If you set new rule , use delegate's isTextValid function
    public func addValidation( _ rule : String) {
        self.validationRegex = rule
        self.isValidationEnabled = true
    }
    /// Add password rule. If you set , use delegate's isTextValid function
    public func addPasswordValidation(minimumChar : Int , maximumChar : Int) {
        self.validationRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{\(String.init(describing: minimumChar)),\(String.init(describing: maximumChar))}$"
        self.isValidationEnabled = true
    }
    /// Add email rule. If you set , use delegate's isTextValid function
    public func addEmailValidation(){
        self.validationRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        self.isValidationEnabled = true
    }
}


extension LemonadeTextfield : UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !isEmptyCharAllowed {
            if string == " " && textField.text!.count == 0 { return false }
        }
        guard let textFieldText = textField.text
              , let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        if maximumCharLimit == nil { return true}
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= maximumCharLimit!
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        lemonadeDelegate?.didTextChange(self)
        if isValidationEnabled {
            let status = NSPredicate(format: "SELF MATCHES %@", self.validationRegex!).evaluate(with: text)
            lemonadeDelegate?.isTextValid(self, status)
        }
        if minimumCharLimit != nil {
            let condition = text.count >= minimumCharLimit!
            lemonadeDelegate?.isMinimumLimitValid(self, condition)
        }
        if maximumCharLimit != nil {
            let condition = text.count <= maximumCharLimit!
            lemonadeDelegate?.isMaximumLimitValid(self, condition)
        }
        
    }
    
    
}
