//
//  Lemonade+Progress+Chart.swift
//  LemonadeUI
//
//  Created by Mac on 17.09.2021.
//


public struct LemonadeProgressChartConfig {
    /// Bar Alignment
    var alignment : LemonadeAlignment
    
    /// X and Y axis border color , default is .black
    var borderColor : LemonadeColor
    
    /// Bars
    var elements : [LemonadeProgressChartElement]
    
    /// Percentage show , Default value is true
    var isLinePercentangeShow : Bool
    
    /// Bar title , default value is nil
    var titleText : LemonadeText?
    
    
    public init(alignment : LemonadeAlignment
                , borderColor : LemonadeColor = .init(backgroundColor: .black)
                , titleText : LemonadeText? = nil
                , isLinePercentageShow : Bool = true
                , elements : [LemonadeProgressChartElement] ){
        self.borderColor = borderColor
        self.alignment = alignment
        self.elements = elements
        self.isLinePercentangeShow = isLinePercentageShow
        self.titleText = titleText
    }
}

public struct LemonadeProgressChartElement {
    /// Bar text
    var text : LemonadeText
    /// Active percentage
    var percentage : CGFloat
    /// Bar color
    var barColor   : LemonadeColor
    /// If you want create custom progress view , pass view to this variable
    var progressView : UIView
    
    public init(percentage : CGFloat , barColor : LemonadeColor , text : LemonadeText , progressView : UIView){
        self.text = text
        self.barColor = barColor
        self.percentage = percentage
        self.progressView = progressView
    
    }
    
}
