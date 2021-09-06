//
//  Lemonade+Segment+Item.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 6.09.2021.
//

import UIKit



final class LemonadeSegmentItem : UIView {
    
    private lazy var segmentLabel : LemonadeLabel = {
        return .init(frame: .zero, config!.segmentText)
    }()
    
    private lazy var badgeLabel : LemonadeLabel = {
        return .init(frame: .zero, config!.badgeText!)
    }()
    
    private var config : LemonadeSegmentItemConfig?
    
    convenience init (frame : CGRect , config : LemonadeSegmentItemConfig) {
        self.init(frame: frame)
        self.config = config
        
        self.configureUI()
    }
    private func configureUI(){
        if config == nil { return }
        
        self.segmentLabel.centerY(self, equalTo: .centerY)
        self.segmentLabel.centerX(self, equalTo: .centerX , constant: config!.hasBadge ? -11 : 0)
        self.segmentLabel.width(constant: config!.segmentText.labelHeight(width: 20))
        
        if config!.hasBadge {
            self.config!.badgeView?.left(self.segmentLabel, equalTo: .right , constant: 5)
            self.config!.badgeView?.centerY(self, equalTo: .centerY)
            self.config!.badgeView?.widthAndHeight(constant: 22)
            
            self.badgeLabel.center(to: self.config!.badgeView!)
            self.badgeLabel.width(self.config!.badgeView!, equalTo: .width)
        }
    }
}
