//
//  LemonadeTextView.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 26.08.2021.
//

import Foundation

public protocol LemonadeTextViewDelegate : AnyObject {
    /**
               
               Send valid state depends on minumum char count
               
               - parameter textfield: Current textfield.
               - parameter value: Valid state depends on minumum char count.
               */
    func isMinimumLimitValid( _ textView : LemonadeTextView ,  _ value : Bool )
    /**
               
               Send valid state depends on maximum char count
               
               - parameter textfield: Current textfield.
               - parameter value: Valid state depends on maximum char count.
               */
    func isMaximumLimitValid( _ textView : LemonadeTextView ,  _ value : Bool )
    
    /// Trigger when user tap something on textfield
    func didTextChange( _ textView : LemonadeTextView)
    
    
}
public class LemonadeTextView : UITextView {
    /// Lemonade delegate
    public weak var lemonadeDelegate : LemonadeTextViewDelegate?
    
    private(set) var lemonadeText : LemonadeText?
    private(set) var lemonadePlaceholderText : LemonadeText?
    
    /// Maximum char limit. If you set , use delegate isMaximumLimitValid function
    public var maximumCharLimit : Int? = nil
    
    /// Maximum char limit. If you set , use delegate isMinimumLimitValid function
    public var minimumCharLimit : Int? = nil
    
    /// Empty char state
    public var isEmptyCharAllowed : Bool = false
    
    private var UIStates: [LemonadeStateConfig] = []
    
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience public init(frame: CGRect, textContainer: NSTextContainer? , text : LemonadeText) {
        self.init(frame:frame , textContainer : textContainer)
        self.text(text)
    }
    convenience public init(frame : CGRect , textContainer : NSTextContainer?  , text : LemonadeText , placeholder : LemonadeText) {
        self.init(frame:frame , textContainer : textContainer)
        self.text(text)
        self.placeholder(placeholder)
    }
}

extension LemonadeTextView {
    public func text( _ text : LemonadeText){
        self.text = text.text
        self.textColor = text.color
        self.textAlignment = text.alignment
        self.font = text.font
        self.lemonadeText = text
    }
    public func placeholder( _ placeholder : LemonadeText) {
        self.lemonadePlaceholderText = placeholder
    }
}

extension LemonadeTextView : UITextViewDelegate {
    public func textViewDidEndEditing(_ textView: UITextView) {
        if self.lemonadePlaceholderText == nil { return }
        if !text.isEmpty{ return }
        text = self.lemonadePlaceholderText?.text
    }
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if self.lemonadePlaceholderText == nil { return }
        let condition = text == self.lemonadePlaceholderText!.text
        if condition { text = "" }
    }
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if !isEmptyCharAllowed { if text == " " && text.isEmpty { return false } }
        guard
            let textViewText = textView.text
            , let rangeOfTextToReplace = Range(range, in: textViewText) else {
            return false
        }
        if maximumCharLimit == nil { return true }
        let substringToReplace = textViewText[rangeOfTextToReplace]
        let count = textViewText.count - substringToReplace.count + text.count
        return count <= maximumCharLimit!
    }
    public func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        lemonadeDelegate?.didTextChange(self)
        if minimumCharLimit != nil {
            let condition = text.count >= minimumCharLimit!
            lemonadeDelegate?.isMinimumLimitValid(self, condition)
        }
        if maximumCharLimit != nil{
            let condition = text.count <= maximumCharLimit!
            lemonadeDelegate?.isMaximumLimitValid(self, condition)
        }
    }
}
