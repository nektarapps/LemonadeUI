//
//  Config+Lemonade+Label.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 13.08.2021.
//


public struct LemonadeText {
    
    /// Label Text
    var text    : String
    
    /// Label Color
    var color   : UIColor
    
    /// Label font
    var font    : UIFont
    
    /// Label alignment
    var alignment : NSTextAlignment
    
    /// Spacing value between characters
    var kern    : Double?
    
    public init (text : String , color : UIColor = .white , font : UIFont = .systemFont(ofSize: 12) , alignment : NSTextAlignment = .center) {
        self.text = text
        self.color = color
        self.font = font
        self.alignment = alignment
    }
    
    
    public init (text : String , color : UIColor = .white , font : UIFont = .systemFont(ofSize: 12) , alignment : NSTextAlignment = .center , kern : Double) {
        self.text = text
        self.color = color
        self.font = font
        self.alignment = alignment
        self.kern = kern
    }
}



public struct LemonadeCollapseText {
    /// Collapse text collapsing limit
    var maxLength : Int
    
    /// General text
    var text      : LemonadeText
    
    /// Show more text
    var moreText  : LemonadeText
    
    /// Showw less text
    var lessText  : LemonadeText
    
    /// Opacity animation settings value
    var isAnimate : Bool
    
    
    var collapseText : String?
    var isCollapse : Bool = false
    
    
    
    public init(max : Int , text : LemonadeText , moreText : LemonadeText , lessText : LemonadeText , isAnimate : Bool = false) {
        self.maxLength = max
        self.text = text
        self.moreText = moreText
        self.lessText = lessText
        self.isAnimate = isAnimate
        
        let condition = text.text.count > maxLength
        self.isCollapse = condition
        if condition { collapseText = String.init(text.text.prefix(maxLength)) }
    }
    
    public mutating func toggleAnimate( _ value : Bool){ self.isAnimate = value }
    public mutating func toggleCollapse( _ value : Bool){ self.isCollapse = value }
}
