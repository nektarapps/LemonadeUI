//
//  Lemonade+Regex+Type.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 30.01.2022.
//


public enum RegexType {
    case emailValidate
    case passwordValidate(min:Int , max:Int)
    case custom(string: String)
    case none
    
    var validationString: String {
        switch self {
        case .emailValidate:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case .passwordValidate(let min, let max):
            return "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{\(String.init(describing: min)),\(String.init(describing: max))}$"
        case .custom(let string):
            return string
        case .none:
            return ""
        }
    }
}
