//
//  Lemonade+Text+Limit+Type.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 30.01.2022.
//


public enum TextLimitType {
    case charLimit(min: Int? , max: Int?)
    case emptyCharAllowed
    
    var isEmptyCharAllowed: Bool {
        switch self {
        case .charLimit: return false
        case .emptyCharAllowed: return true
        }
    }
    var minimumCharValue: Int? {
        switch self {
        case .charLimit(let min , _): return min
        case .emptyCharAllowed: return nil
        }
    }
    var maximumCharValue: Int? {
        switch self {
        case .charLimit(_ , let max): return max
        case .emptyCharAllowed: return nil
        }
    }
}
