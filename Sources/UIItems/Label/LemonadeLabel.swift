//
//  LemonadeLabel.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 13.08.2021.
//

import UIKit


public class LemonadeLabel : UILabel {
    
    
    /// Getter LemonadeText
    private(set) var lemonadeText : LemonadeText?
    
    /// Getter LemonadeAttributeText
    private(set) var lemonadeAttributedText : [LemonadeText]?
    
    /// Getter Collapse Text
    private(set) var lemonateCollapseText   : LemonadeCollapseText?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /// Lemonade Text init
    public convenience init(frame : CGRect , _ text : LemonadeText) {
        self.init(frame : frame)
        if text.kern != 0.0 || text.underLine != nil { self.attributedText([text]) }
        else { self.text(text) }
    }
    /// Collapse Lemonade Text init
    public convenience init(frame : CGRect , _ collapseText : LemonadeCollapseText) {
        self.init(frame:frame)
        self.collapseText(collapseText)
        
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showToggleTapped(gesture:))))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var text: String? {
        didSet {
            if self.lemonadeText != nil { self.lemonadeText?.text = text ?? "" }
            if self.lemonateCollapseText != nil { self.lemonateCollapseText?.text.text = text ?? "" }
        }
    }
    
    
    
}


extension LemonadeLabel {
    
    /**
     Text set
     
     - parameter text: Text type.
     */
    public func text( _ text : LemonadeText){
        self.text = text.text
        self.textColor = text.color
        self.textAlignment = text.alignment
        self.font = text.font
        self.numberOfLines = 0
        if text.breakMode != nil { self.lineBreakMode = text.breakMode! }
        self.lemonadeText = text
    }
}
extension LemonadeLabel {
    
    /**
     Attributed Text set
     
     - parameter texts: Lemonade Text array with params.
     */
    
    public func attributedText( _ texts : [LemonadeText]) {
        if texts.isEmpty { return }
        let attrbsString = NSMutableAttributedString.init()
        
        for text in texts {
            let attributeText = text.attributeText()
            attrbsString.append(attributeText)
        }
        self.numberOfLines = 0
        self.attributedText = attrbsString
        self.lemonadeAttributedText = texts
    }
    
    
    /**
     Change attribute text with array index which come from attributedText( _ texts : [LemonadeText]) function
     
     - parameter at: Index number.
     - parameter newText: New Text type.
     - parameter isAnimate: Opacity animations is active or not.
     */
    public func changeAttributedText(at : Int , newText : LemonadeText , isAnimate : Bool) {
        if lemonadeAttributedText == nil { return }
        if lemonadeAttributedText!.isEmpty { return }
        lemonadeAttributedText!.remove(at: at)
        lemonadeAttributedText!.insert(newText, at: at)
        if isAnimate { self.animate(.opacity(values: [1.0 , 0.0 , 1.0]) ,config: .init(duration: 1, repeatCount: 0, autoReverse: false)) }
        self.attributedText(lemonadeAttributedText!)
    }
}


extension LemonadeLabel {
    
    /**
     Collapse text set
     
     - parameter collapse: Collapse label settings type.
     */
    public func collapseText( _ collapse : LemonadeCollapseText) {
        let collapseAttrbs = NSMutableAttributedString(string: collapse.collapseText ?? "", attributes: [
            .foregroundColor : collapse.text.color , .font : collapse.text.font
        ])
        let showMoreAttrbs = NSMutableAttributedString(string: collapse.moreText.text
                                                       , attributes: [
                                                        .foregroundColor : collapse.moreText.color , .font : collapse.moreText.font
                                                       ])
        collapseAttrbs.append(showMoreAttrbs)
        
        
        let fullTextAttrbs = NSMutableAttributedString(string: collapse.text.text
                                                       , attributes: [
                                                        .foregroundColor : collapse.text.color , .font : collapse.text.font
                                                       ])
        let showLess = NSMutableAttributedString(string: collapse.lessText.text
                                                 , attributes: [
                                                    .foregroundColor : collapse.lessText.color , .font : collapse.lessText.font
                                                 ])
        fullTextAttrbs.append(showLess)
        let isBigger = collapse.text.text.count > collapse.maxLength
        self.numberOfLines = 0
        self.attributedText = collapse.isCollapse == true ? collapseAttrbs : isBigger == false ? NSMutableAttributedString(string: collapse.text.text, attributes:[
            .foregroundColor : collapse.text.color , .font : collapse.text.font
        ]): fullTextAttrbs
        self.lemonateCollapseText = collapse
    }
    
    /// Open text like show more text tapped
    public func showMore(){
        guard var collapse = lemonateCollapseText else { return }
        collapse.toggleCollapse(false)
        if collapse.isAnimate { self.animate(.toggleOpacity, config: .init(duration: 1), complitionHanler: { self.collapseText(collapse) }) }
    }
    
    /// Close text like show less text tapped
    public func showLess(){
        guard var collapse = lemonateCollapseText else { return }
        collapse.toggleCollapse(true)
        if collapse.isAnimate { self.animate(.toggleOpacity, config: .init(duration: 1), complitionHanler: { self.collapseText(collapse) }) }
    }
    
    /// Close animation of collapse text opacity animation
    public func closeCollapseTextAnimation(){
        guard var collapse = lemonateCollapseText else { return }
        collapse.toggleAnimate(false)
    }
    
    /// Open animation of collapse text opacity animation
    public func openCollapseTextAnimation(){
        guard var collapse = lemonateCollapseText else { return }
        collapse.toggleAnimate(false)
    }
    
}
//MARK:-> Toggle
extension LemonadeLabel {
    @objc private func showToggleTapped(gesture: UITapGestureRecognizer){
        guard let collapse = lemonateCollapseText else { return }
        let showMoreTextArea = (self.text! as NSString).range(of: collapse.moreText.text)
        let shoeLessTextArea = (self.text! as NSString).range(of: collapse.lessText.text)
        
        if gesture.didTapAttributedTextInLabel(label: self, inRange: showMoreTextArea) {
            showMore()
        }else if gesture.didTapAttributedTextInLabel(label: self, inRange: shoeLessTextArea) {
            showLess()
        }
    }
}
