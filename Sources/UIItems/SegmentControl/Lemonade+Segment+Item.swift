//
//  Lemonade+Segment+Item.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 6.09.2021.
//

import UIKit



public final class LemonadeSegmentItem : UIView {
    
    private lazy var segmentLabel : LemonadeLabel = {
        return .init(frame: .zero, config!.segmentText)
    }()
    
    private lazy var badgeLabel : LemonadeLabel = {
        return .init(frame: .zero, config!.badgeText!)
    }()
    
    private var config : LemonadeSegmentItemConfig?
    
    public convenience init (frame : CGRect , config : LemonadeSegmentItemConfig) {
        self.init(frame: frame)
        self.config = config
        
        self.configureUI()
    }
    private func configureUI(){
        if config == nil { return }
        self.addSubview(segmentLabel)
        
        self.segmentLabel.centerY(self, equalTo: .centerY)
        self.segmentLabel.centerX(self, equalTo: .centerX , constant: config!.hasBadge ? -11 : 0)
        self.segmentLabel.width(constant: config!.segmentText.labelHeight(width: 20))
        
        if config!.hasBadge {
            self.addSubview(config!.badgeView!)
            self.addSubview(badgeLabel)
            
            self.config!.badgeView?.left(self.segmentLabel, equalTo: .right , constant: 5)
            self.config!.badgeView?.centerY(self, equalTo: .centerY)
            self.config!.badgeView?.widthAndHeight(constant: 22)
            
            self.badgeLabel.center(to: self.config!.badgeView!)
            self.badgeLabel.width(self.config!.badgeView!, equalTo: .width)
        }
    }
    
    
    
    public func badgeText( _ text : String) {
        self.badgeLabel.text = text
    }
}
