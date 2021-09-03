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
    var kern    : Double
    
    /// UnderLine configuration
    var underLine : LemonadeUnderLine?
    
    /// Break Mode
    var breakMode : NSLineBreakMode?
    
    public init (text : String
                 , color : UIColor = .white
                 , font : UIFont = .systemFont(ofSize: 12)
                 , alignment : NSTextAlignment = .center
                 , kern : Double = 0.0
                 , underline : LemonadeUnderLine? = nil
                 , breakMode : NSLineBreakMode? = nil ) {
        self.text = text
        self.color = color
        self.font = font
        self.alignment = alignment
        self.kern = kern
        self.underLine = underline
        self.breakMode = breakMode
    }
    
    
    public func attributeText() -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = self.alignment
        paragraph.lineBreakMode = .byWordWrapping
        
        return self.underLine == nil
            ? NSMutableAttributedString.init(string: self.text, attributes: [NSAttributedString.Key.font : self.font  , NSAttributedString.Key.foregroundColor : self.color , NSAttributedString.Key.paragraphStyle : paragraph , NSAttributedString.Key.kern : self.kern])
            : NSMutableAttributedString.init(string: self.text, attributes: [NSAttributedString.Key.font : self.font  , NSAttributedString.Key.foregroundColor : self.color , NSAttributedString.Key.paragraphStyle : paragraph , NSAttributedString.Key.kern : self.kern , .underlineStyle : self.underLine!.underLine.rawValue , .underlineColor : self.underLine!.underLineColor ])
    }
    
    
    
    
    public func labelHeight(width : CGFloat) -> CGFloat {
        let label : LemonadeLabel = .init(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude), self)
        label.sizeToFit()
        label.layoutIfNeeded()
        return label.frame.height
    }
    public func labelWidth(height : CGFloat) -> CGFloat {
        let label : LemonadeLabel = .init(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height), self)
        label.sizeToFit()
        label.layoutIfNeeded()
        return label.frame.width
    }
}


public struct LemonadeUnderLine {
    var underLine : NSUnderlineStyle
    var underLineColor : UIColor
    
    
    public init( _ type : NSUnderlineStyle , color : UIColor) {
        self.underLine = type
        self.underLineColor = color
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
