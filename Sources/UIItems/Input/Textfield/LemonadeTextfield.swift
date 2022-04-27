//
//  LemonadeTextfield.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 19.08.2021.
//

import UIKit

public class LemonadeTextfield : UITextField {
    
    /// Lemonade delegate
    public weak var lemonadeDelegate : LemonadeTextFieldDelegate?
    public var isAutoStateChangeAfterValdidation: Bool = true
    
    /// Regex getter
    private(set) var regexType: RegexType = .none
    
    /// Validations
    private(set) var textLimitTypes: [TextLimitType] = []
    
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
    
    public func leftMargin( _ size: CGFloat) {
        self.leftView = .init(frame: .init(x: 0, y: 0, width: size, height: bounds.height))
        self.leftViewMode = .always
    }

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
    public func removeValidationAndRegex(){
        textLimitTypes.removeAll(keepingCapacity: false)
        regexType = .none
    }
    public func addRegex(type: RegexType) {
        regexType = type 
    }
    public func addTextLimits(types: [TextLimitType]) {
        self.textLimitTypes = types
    }
    /// Add custom rule. If you set new rule , use delegate's isTextValid function
    public func addCustomRegex(rule : String) {
        regexType = .custom(string: rule)
    }
    /// Add password rule. If you set , use delegate's isTextValid function
    public func addPasswordValidation(minimumChar : Int , maximumChar : Int) {
        regexType = .passwordValidate(min: minimumChar, max: maximumChar)
    }
    /// Add email rule. If you set , use delegate's isTextValid function
    public func addEmailValidation(){
        regexType = .emailValidate
    }
}


extension LemonadeTextfield : UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !textLimitTypes.contains(where: { $0.isEmptyCharAllowed }) {
            if string == " " && textField.text!.count == 0 { return false }
        }
        guard let textFieldText = textField.text
              , let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        guard let maximumCharLimit = textLimitTypes.first(where: {$0.maximumCharValue != nil})?.maximumCharValue else {
             return true
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= maximumCharLimit
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        lemonadeDelegate?.didTextChange(self)
        switch regexType {
        case .none:
            break
        default:
            let status = NSPredicate(format: "SELF MATCHES %@", regexType.validationString).evaluate(with: text)
            if isAutoStateChangeAfterValdidation {
                status == false ? openState(.warning) : closeState(.warning)
            }
            lemonadeDelegate?.isTextValid(self, status)
        }
        if let minimumCharLimit = textLimitTypes.first(where: {$0.maximumCharValue != nil})?.minimumCharValue {
            let condition = text.count >= minimumCharLimit
            if isAutoStateChangeAfterValdidation && condition == false {
                 condition == false ? openState(.warning) : closeState(.warning)
            }
            lemonadeDelegate?.isMinimumLimitValid(self, condition)
        }
        if let maximumCharLimit = textLimitTypes.first(where: {$0.maximumCharValue != nil})?.maximumCharValue {
            let condition = text.count <= maximumCharLimit
            if isAutoStateChangeAfterValdidation && condition == false {
                 condition == false ? openState(.warning) : closeState(.warning)
            }
            lemonadeDelegate?.isMaximumLimitValid(self, condition)
        }
        
    }
    
    
}
