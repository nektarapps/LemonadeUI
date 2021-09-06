//
//  Lemonade+Segment+Config.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 6.09.2021.
//

public struct LemonadeSegmentItemConfig  {
    var segmentText : LemonadeText
    var badgeText   : LemonadeText?
    var badgeView   : UIView?
    
    
    public init(segmentText : LemonadeText) {
        self.segmentText = segmentText
        self.badgeText = nil
        self.badgeView = nil
    }
    public init(segmentText : LemonadeText , badgeView : UIView , badgeText : LemonadeText) {
        self.segmentText = segmentText
        self.badgeView = badgeView
        self.badgeText = badgeText
    }
    
    var hasBadge : Bool {
        return self.badgeView != nil && self.badgeText != nil
    }
}
