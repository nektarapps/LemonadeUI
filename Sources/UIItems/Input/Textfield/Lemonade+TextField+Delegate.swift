//
//  Lemonade+TextField+Delegate.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 30.01.2022.
//

import Foundation


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
