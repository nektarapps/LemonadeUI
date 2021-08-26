//
//  ConfigUI+View.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 12.08.2021.
//

/// Border type
public struct LemonadeBorder {
    var borderColor : CGColor = UIColor.white.cgColor
    var borderWidth : CGFloat = 0.0
    
    public init(){}
    
    /**
     Border type
     
     - parameter borderColor: Border color. Default value white.
     - parameter width: Border width. Default value 0.
     */
    public init(borderColor : UIColor , width : CGFloat) {
        self.borderColor = borderColor.cgColor
        self.borderWidth = width
    }
}


/// Radius type
public struct LemonadeRadius {
    var radius : CGFloat = 12
    var maskedCorners : CACornerMask? = nil
    
    public init() { }
    
    /**
     Radius type
    
     - parameter radius: View border radius. Default value 12.
     - parameter maskedCorners: Radius corners. Default value is nil.
     */
    public init (radius : CGFloat , maskedCorners : CACornerMask? = nil) {
        self.radius = radius
        self.maskedCorners = maskedCorners
    }
}
/// Color type
public struct LemonadeColor {
    var backgroundColor : UIColor? = nil
    var gradient        : LemonadeGradient? = nil

    /**
     Color type
     
     - parameter backgroundColor: Solid Background Color (optional).
     - parameter gradient: Gradient Background Color (optional).
     - warning: If all params are empty , can not draw any color. Becaues default value is nil
     */
    public init(backgroundColor : UIColor? = nil , gradient : LemonadeGradient? = nil) {
        self.backgroundColor = backgroundColor
        self.gradient = gradient
    }
}

/// Gradient type
public struct LemonadeGradient {
    var colors : [CGColor]
    var from : CGPoint
    var to   : CGPoint
    var locations : [NSNumber]?
    
    /**
     Gradient Type
     
     - parameter colors: Transition colors depends on points.
     - parameter from: Starting point
     - parameter to: End point
     - parameter locations: Locations between from and to points ex : [0.3 , 0.7 , 0.8]
     */
    public init(colors : [CGColor] , from : CGPoint , to : CGPoint , locations : [NSNumber]? = nil) {
        self.colors = colors
        self.from = from
        self.to = to
        self.locations = locations
    }
}


public struct LemonadeEmptyUI {
    var image : UIImage?
    var text  : String
    var descriptionText : String?
    
    /**
     Empty UI Config
     
     - parameter image: Will center of the screen. Default value nil.
     - parameter text: Title of empty type. Default value is No Result Found :(
     - parameter descriptionText: Description text of empty type. Default value is nil
     */
    public init (image : UIImage? = nil , text : String = "No Result Found :(" , descriptionText : String? = nil) {
        self.image = image
        self.text = text
        self.descriptionText = descriptionText
    }
}


public struct LemonadeShadow {
    var shadowColor : UIColor
    var opacity     : Float
    var offset      : CGSize
    var radius      : CGFloat
    
    /**
     Shadow config
     
     - parameter shadowColor: Shadow color.
     - parameter opacity: Shadow opacity. Default value is 1.0
     - parameter offset: Shadow offet
     - parameter radius: Shadow radius
     */
    public init (shadowColor : UIColor , opacity : Float = 1.0 , offset : CGSize , radius : CGFloat) {
        self.shadowColor = shadowColor
        self.opacity = opacity
        self.offset = offset
        self.radius = radius
    }
}

public struct LemonadeStateConfig {
    var state : LemonadeUIState
    var view  : UIView
    
    /**
     UI State config
     
     - parameter state: State type
     - parameter view: State view 
     */
    public init( state : LemonadeUIState , view : UIView){
        self.state = state
        self.view = view
    }
}

public enum LemonadeUIState {
    case error
    case warning
    case success
    
    
    var color : UIColor {
        switch self {
        case .error:return .systemRed
        case .warning:return .systemYellow
        case .success:return .systemGreen
        }
    }
}
