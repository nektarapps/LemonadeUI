//
//  ConstraintErrors.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 11.08.2021.
//

import Foundation

/// Constraint Error Type
enum LemonadeConstraintError : String, Error {
    case superViewError  = "SuperView can not be empty. This is illegal"
}
