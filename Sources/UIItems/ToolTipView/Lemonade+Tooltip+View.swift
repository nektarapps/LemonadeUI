//
//  Lemonade+Tooltip+View.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 26.08.2021.
//

import UIKit



public class LemonadeToolTip : UIView {
    private var configs : [LemonadeToolTipConfig] = []
    private var startIndex : Int = 0
    private var endIndex : Int = 0
}
extension LemonadeToolTip {
    public func configure( _ config : [LemonadeToolTipConfig]){
        if self.superview == nil { fatalError("SuperView can't be empty")}
        self.configs = config
        self.endIndex = configs.count - 1
        self.fill2SuperView()
       // self.isHidden = true
        
       // self.drawToolTip()
    }
}
extension LemonadeToolTip {
    // Start
    // Reset
    // Clear
    // Next
    // Prev
}

