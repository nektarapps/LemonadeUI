//
//  WrapContent.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 3.09.2021.
//

public protocol WrapContent {
    func calcualation() -> CGFloat
}



public struct Test : Codable , WrapContent {
    public func calcualation() -> CGFloat {
        let text = LemonadeText.init(text: text).labelHeight(width: .screenWidth(24))
        let description = LemonadeText.init(text: description).labelHeight(width: .screenWidth(24))
        
        return text + description
    }
    
    var text : String = ""
    var description : String = ""
}
