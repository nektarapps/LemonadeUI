//
//  Lemonade+Labelled+Input.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 26.08.2021.
//

import UIKit


public class LemonadeLabelledInput : UIView {
    
    public var lemonadeLabel : LemonadeLabel? = nil
    public var lemonadeTextfield : LemonadeTextfield? = nil
    public var lemonadeTextView : LemonadeTextView? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    /**
     Textfield init
     
     - parameter text: Label Text.
     - parameter labelPosition: Label Text.
     - parameter textfieldText: Textfield text.
     - parameter placeholder: Textfield placeholder text.
     - parameter margin: Space between label and textfied
     - returns: none
     */
    public convenience init(frame : CGRect
                            , text : LemonadeText
                            , labelPosition : LemonadeConstraint
                            , textfieldText : LemonadeText
                            , placeholder : LemonadeText? = nil , margin : CGFloat = 0.0) {
        self.init(frame : frame)
        
        self.label(text , position: labelPosition)
        self.textfield(textfieldText ,placeholder:placeholder ,labelPosition: labelPosition , margin: margin)
    }
    
    
    /**
     TextView init
     
     - parameter text: Label Text.
     - parameter labelPosition: Label Text.
     - parameter textViewText: TextView text.
     - parameter placeholder: Textfield placeholder text.
     - parameter margin: Space between label and textfied
     - returns: none
     */
    public convenience init(frame : CGRect
                            , text : LemonadeText
                            , labelPosition : LemonadeConstraint
                            , textViewText : LemonadeText
                            , placeholder : LemonadeText? = nil , margin : CGFloat = 0.0) {
        self.init(frame : frame)
        
        self.label(text , position: labelPosition)
        self.textView(textViewText ,placeholder:placeholder ,labelPosition: labelPosition , margin: margin)
    }
}


extension LemonadeLabelledInput {
    /**
     Label create
     
     - parameter text: Label text.
     - parameter position: Label position on view.
     */
    public func label( _ text : LemonadeText , position : LemonadeConstraint){
        let label : LemonadeLabel = .init(frame: .zero, text)
        self.addSubview(label)
        
        label.width(self, equalTo: .width)
        label.height(constant: text.labelHeight(width: self.bounds.width))
        switch position {
            case .left:
                label.left(self, equalTo: .left)
                label.centerY(self, equalTo: .centerY)
            case .right:
                label.right(self, equalTo: .right)
                label.centerY(self, equalTo: .centerY)
            case .top:
                label.top(self, equalTo: .top)
                label.centerX(self, equalTo: .centerX)
            case .bottom:
                label.bottom(self, equalTo: .bottom)
                label.centerX(self, equalTo: .centerX)
            default:break
        }
        
        self.lemonadeLabel = label
    }
    
    /**
     Textfield create
     - parameter text: Textfield text.
     - parameter placeholder: Textfield placeholder text.
     - parameter labelPosition: Label position for constraint of textfield.
     - parameter margin: Label position on view.
     
     - warning: If label did not set , This func will return without creating textfield
     */
    public func textfield( _ text : LemonadeText
                           , placeholder : LemonadeText? = nil
                           , labelPosition : LemonadeConstraint
                           , margin : CGFloat = 0.0){
        if lemonadeLabel == nil { return }
        let textfield : LemonadeTextfield = placeholder == nil
            ? .init(frame: .zero, text: text)
            : .init(frame: .zero, text: text, placeholder: placeholder!)
        self.addSubview(textfield)
        textfield.width(self, equalTo: .width)
        switch labelPosition {
        case .left:
            textfield.left(self.lemonadeLabel!, equalTo: .right , constant: margin)
            textfield.height(self, equalTo: .height)
        case .right:
            textfield.right(self.lemonadeLabel!, equalTo: .left , constant: -margin)
            textfield.height(self, equalTo: .height)
        case .top:
            textfield.bottom(self, equalTo: .bottom)
            textfield.top(self.lemonadeLabel!, equalTo: .bottom , constant: margin)
        case .bottom:
            textfield.top(self, equalTo: .top)
            textfield.bottom(self.lemonadeLabel!, equalTo: .top , constant: -margin)
        default:break
        }
        
        self.lemonadeTextfield = textfield
    }
    /**
     Textview create
     - parameter text: Textview text.
     - parameter placeholder: Textview placeholder text.
     - parameter labelPosition: Label position for constraint of Textview.
     - parameter margin: Label position on view.
     
     - warning: If label did not set , This func will return without creating Textview
     */
    public func textView( _ text : LemonadeText
                           , placeholder : LemonadeText? = nil
                           , labelPosition : LemonadeConstraint , margin : CGFloat = 0.0){
        if lemonadeLabel == nil { return }
        let textView : LemonadeTextView = placeholder == nil
            ? .init(frame: .zero, textContainer: nil , text: text)
            : .init(frame: .zero, textContainer: nil , text: text ,placeholder: placeholder!)
        self.addSubview(textView)
        textView.width(self, equalTo: .width)
        switch labelPosition {
        case .left:
            textView.left(self.lemonadeLabel!, equalTo: .right , constant: margin)
            textView.height(self, equalTo: .height)
        case .right:
            textView.right(self.lemonadeLabel!, equalTo: .left , constant: -margin)
            textView.height(self, equalTo: .height)
        case .top:
            textView.bottom(self, equalTo: .bottom)
            textView.top(self.lemonadeLabel!, equalTo: .bottom , constant: margin)
        case .bottom:
            textView.top(self, equalTo: .top)
            textView.bottom(self.lemonadeLabel!, equalTo: .top , constant: -margin)
        default:break
        }
        
        self.lemonadeTextView = textView
    }
}
