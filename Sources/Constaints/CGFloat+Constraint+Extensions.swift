//
//  CGFloat+Constraint+Extensions.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 11.08.2021.
//

import Foundation


extension CGFloat {
    public static func screenWidth( _ margin : CGFloat = 0.0) -> CGFloat {
        return UIScreen.main.bounds.width - margin
    }
    public static func screenHeight( _ margin : CGFloat = 0.0) -> CGFloat {
        return UIScreen.main.bounds.height - margin
    }
    static var statusBarHeight : CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
        }
        return 0.0
    }
}
